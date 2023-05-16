function [w_I w_Q] = IQDemodulation(signal,time)

r_Q = signal .* sin(2*pi * 2.6e9 * time);
r_I = signal .* cos(2*pi * 2.6e9 * time);

order = 1000;      % Order
Fcut = 0.05;       % Cutoff Frequency
flag = 'noscale';  % Sampling Flag
win = blackman(order+1);
b  = fir1(order, Fcut, 'low', win, flag);
Hd = dfilt.dffir(b);

r_I = [r_I zeros(1,order/2) ];
w_I = filter(Hd, r_I);
w_I = 2*w_I((order/2)+1:end);
r_Q = [r_Q zeros(1,order/2) ];
w_Q = filter(Hd, r_Q);
w_Q = 2*w_Q((order/2)+1:end);

end