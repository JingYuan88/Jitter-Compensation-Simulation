function [w_I w_Q noise_floor] = FloorMsgEstimation(s)

load('systemParameter_storage','tt')

% Obtain 'CLEAN' Message signal by BPF
N    = 1000;       % Order
Fc1  = 0.79;       % First Cutoff Frequency      
Fc2  = 0.89;       % Second Cutoff Frequency     
flag = 'noscale';  % Sampling Flag
win = blackman(N+1);

b  = fir1(N, [Fc1 Fc2], 'bandpass', win, flag);
Hd = dfilt.dffir(b);
ss = [s zeros(1,N/2) ];
s_msg= filter(Hd, ss);
s_msg = s_msg((N/2)+1:end);
% figure;periodogram(s_msg,[],[],Fs)
% title('Message Signal after BPF')


% Obtain the noise floor
noise_floor = s - s_msg;


% Estimated I and Q
[w_I w_Q] = IQDemodulation(s_msg,tt);

end