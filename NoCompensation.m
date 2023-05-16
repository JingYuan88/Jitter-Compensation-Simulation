function [symbol_error SER bit_error BER] = NoCompensation(s,tt,modulated_data)

[w_I w_Q] = IQDemodulation(s,tt); 
received_symb = FFT_Demodulate(w_I,w_Q); 
[symbol_error SER bit_error BER] = ErrorCalculation(received_symb,modulated_data);

end