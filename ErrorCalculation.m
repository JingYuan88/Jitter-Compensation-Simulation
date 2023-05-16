function [symbol_error SER bit_error BER] = ErrorCalculation(received_symb,modulate_data)

load('systemParameter_storage','carrier_count','M_qam','total_data_bit')

Ori_symb = demodulate(modem.qamdemod(M_qam),modulate_data) ;        %Original symbol send at transmitter side
Total_output_symbol = length(Ori_symb(1:carrier_count)); 

% Find symbol error
symbol_error = length( find(Ori_symb ~= received_symb) );
SER = symbol_error/Total_output_symbol;


% decimal to binary transform
received_bit = de2bi(received_symb);  
Ori_bit = de2bi(Ori_symb);  



  
% Find bit errors
bit_error = length(find(received_bit ~= Ori_bit));
BER  = bit_error/total_data_bit;


end



