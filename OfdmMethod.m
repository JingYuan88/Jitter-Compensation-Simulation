function carriers = OfdmMethod(modulate_data)

load('systemParameter_storage','carrier_count','symbols_per_carrier','IFFT_bin_length')

% Serial to Parallel Conversion  
carrier_matrix = reshape(modulate_data, carrier_count, symbols_per_carrier).';

% Assign each carrier to its IFFT bin
%   - each row of complex_carrier_matrix represents one symbol period, with
%     a symbol for each carrier
%   - a matrix is generated to represent all IFFT bins (columns) and all 
%     symbols (rows)

info = carrier_matrix(1,:);                                               % each row represent 1 OFDM symbol        
IFFT_modulation=zeros(1,IFFT_bin_length);                                 % cre8 the ifft length
IFFT_modulation(1:(carrier_count/2)) =  info(1:(carrier_count/2));        % first 300 in left
IFFT_modulation((IFFT_bin_length-((carrier_count/2)-1)):IFFT_bin_length) =  info(((carrier_count/2)+1):carrier_count);  % remain 300/2 at right, with zero left at middle
carriers=ifft(IFFT_modulation,IFFT_bin_length);

end