function  loopresult = Improvement2(s,I,Q,loopcount,Taylor_order,noise_floor,modulated_data)

load('systemParameter_storage','tt')
i = loopcount;

    while(i)   

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