
function  modulate_data = QamModulation(data)

%   - reshape to matrix form where each row represent a symbol
%   - map row of matrix from binary to decimal symbol
%   - modulate using M-QAM
%   - modulate_data is the serial output stream of QAM modulated data

load('systemParameter_storage','bits_per_symbol','total_data_bit','M_qam')

symbol = reshape(data,bits_per_symbol,total_data_bit/bits_per_symbol)';
data_s = bi2de(symbol);     
modulate_data = modulate(modem.qammod(M_qam),data_s).';  

end


