function s = IQModulation(complex_time_signal,tt_jittered)

I=real(complex_time_signal);
Q=imag(complex_time_signal);

C1 = I .* cos(2*pi * 2.6e9 * tt_jittered);   % Subsampling is done here also
C2 = Q .* sin(2*pi * 2.6e9 * tt_jittered);
s = C1 + C2;                                 % s is the subsampled data vector

%figure;periodogram(s,[],[],q_ratio/T)       % another type of ploting
%title('Subsampled OFDM symbol')

end
