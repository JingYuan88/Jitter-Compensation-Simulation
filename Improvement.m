function  loopresult = Improvement(s,I,Q,loopcount,Taylor_order,modulated_data,complex_time_signal)

load('systemParameter_storage','tt')
%global Sjitter;
i = loopcount;

    while(i)   
         %figure;plot(real(complex_time_signal(1:320)));hold;plot(I(1:320),'r');hold
    % Reconstruct the msg content using the IQ value compensated
        C1 = I .* cos(2*pi * 2.6e9 * tt);   
        C2 = Q .* sin(2*pi * 2.6e9 * tt);
        s_construct = C1 + C2;    

    % Obtain the noise floor
        noise_floor = s - s_construct;

    % Perform jitter estimation again
        dt_est = TaylorEstimation(I,Q,noise_floor,Taylor_order);
        %10*log10(mean(abs(Sjitter(1:end)-dt_est(1:end)).^2))

    % Compensation via IQDemodulation
        [w_I w_Q] = IQDemodulation(s,tt+real(dt_est)); 
        I = w_I;
        Q = w_Q;
        
    % undo OFDM and demodulation to obtain data in symbol
        received_symb = FFT_Demodulate(w_I,w_Q);                        

    % ERROR CALCULATION 
        [symbol_error SER bit_error BER] = ErrorCalculation(received_symb,modulated_data);   % calculate error
        loopresult((loopcount-i+1),:) = [symbol_error SER bit_error BER];                    % (loopcount-i+1) is just to make the reverse numbering
        
        i = i-1;        
       
    end
    
end