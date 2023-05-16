function dt_est = TaylorEstimation(w_I, w_Q, noise_floor, EstimationOrder)

load('systemParameter_storage','tt','Fc')


% Estimate instananeous jitter value
MdxdtI = -2*pi*Fc*sin(2*pi *Fc*tt);
MdxdtQ = 2*pi*Fc*cos(2*pi *Fc*tt); 
Mdxdt  = ( w_I.*MdxdtI ) + ( w_Q.*MdxdtQ );       % 1st derivative of message

MdxdtI2 = -((2*pi*Fc)^2)*cos(2*pi *Fc*tt);
MdxdtQ2 = -((2*pi*Fc)^2)*sin(2*pi *Fc*tt); 
Mdxdt2 = ( w_I.*MdxdtI2 ) + ( w_Q.*MdxdtQ2 );     % 2nd derivative of message

MdxdtI3 = -((2*pi*Fc)^3)*sin(2*pi *Fc*tt);
MdxdtQ3 = ((2*pi*Fc)^3)*cos(2*pi *Fc*tt); 
Mdxdt3  = ( -w_I.*MdxdtI3 ) + ( -w_Q.*MdxdtQ3 );  % 3rdd derivative of message


switch EstimationOrder
    case 1
       dt_est1 = noise_floor./(Mdxdt);
       dt_est = dt_est1;
             
    case 2
        a      = (Mdxdt2)/2;
        b      = Mdxdt;
        c      = -noise_floor; 
        bac    = sqrt(b.^2-4*a.*c);
        [u,v]  = min([abs(-b-bac); abs(-b+bac)]);
        dt_est2 = (-b+2*(v-1.5).*bac)./(2.*a); 
        dt_est = dt_est2;
      
    case 3
        a = Mdxdt3/6;
        b = Mdxdt2/2;
        c = Mdxdt;
        d = -noise_floor;
        
        dt = cubicroots(a,b,c,d);
        [u,v]  = min(abs(dt.'));     % find the smallest root
        dt_est3=[];
        for ii = 1:length(v)
            dt_est3 =[ dt_est3 dt(ii,v(ii)) ];
        end
        dt_est = dt_est3;        
        
    otherwise
        disp('No Compensation Applied');  
        dt_est = 0;
end

        if 0%dt_est ~= 0 
            global Sjitter;                             % call in order to plot stem graph
            figure;stem(Sjitter(2050:2080),'fill');
            hold
            stem(real(dt_est(2050:2080)),'r');
            xlabel('N')
            ylabel('Jitter Value, s')
            title(sprintf('Order %d MSE (dB): %.4g',EstimationOrder,10*log10(mean(abs(Sjitter(1:end)-dt_est(1:end)).^2))));
            legend('Original Jitter Value','Estimated Jitter Value');
            hold
        end
end
