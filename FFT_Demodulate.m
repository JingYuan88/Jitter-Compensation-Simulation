function received_symb = FFT_Demodulate(w_I,w_Q)

load('systemParameter_storage','carrier_count','M_qam','q_ratio','IFFT_bin_length')

% Downsampling
w_III = w_I(1:q_ratio:end);
w_QQQ = w_Q(1:q_ratio:end);


% Real/Imag to complex
yy=(w_III + i*w_QQQ);


%FFT process
time_wave_matrix = fft(yy(1:end),IFFT_bin_length);

signal=zeros(1,carrier_count);                                              
signal(1:(carrier_count/2)) =  time_wave_matrix(1:(carrier_count/2));               
signal(((carrier_count/2)+1):carrier_count) = time_wave_matrix(end-(carrier_count/2)+1:end);                         

%scatterplot(signal);grid on
%title('Scatterplot of 600 symbol with jitter sampling')

% QAM demodulation
received_symb = demodulate(modem.qamdemod(M_qam),signal) ;