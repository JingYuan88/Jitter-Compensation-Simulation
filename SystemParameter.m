function filename = SystemParameter()

% OFDM system parameters
carrier_spacing = 15e3;    % 15KHz spacing between carrier
IFFT_bin_length = 1024;    % IFFT bin count for Tx, FFT bin count for Rx 
carrier_count = 600;       % number of active carriers  (in simulation need 600)
M_qam = 16;                % 16-QAM modulatin scheme
symbols_per_carrier =1;    % symbols per carrier
SNR = 26;                  % channel signal to noise ratio (dB)  
Fif = 103.36e6;            % Intermediate freq after subsampling process, inpaper
Sys_bandwidth = 15.36e6;   % 1024 x 15KHz = 15.36MHz bandwidth
Fs = 16*Sys_bandwidth;     % Oversampling by 16 time as in paper
Fc = 2.6e9;                % Carrier freq

    
% Derived parameters
Tu = 1/carrier_spacing;                         % usefull OFDM symbol duration
T = Tu/IFFT_bin_length;                         % Elementary period , 1/T is the system bandwidth .
bits_per_symbol = log2(M_qam);                  % 4 bits per symbol for 16-QAM 
q_ratio = 16;                                   % upsampling ratio so that each point represent 1 sampling freq of Fs
total_data_bit =  carrier_count * symbols_per_carrier * bits_per_symbol;    % Total binary data to transmit
t=Tu/IFFT_bin_length:Tu/IFFT_bin_length:Tu;     % Time vector for each OFDM symbol

tt=T/q_ratio:T/q_ratio:Tu;                      % This will become the simulation sampling freq/ same with subsampling freq


filename = 'systemParameter_storage';
save(filename);

end