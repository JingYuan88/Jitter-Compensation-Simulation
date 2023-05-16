function complex_time_signal = PulseShape(carriers,roll_off,delay)

load('systemParameter_storage','q_ratio')

% Upsampling and pulse shapping
y = rcosflt(carriers,1,q_ratio,'fir',roll_off,delay);    % raised cosine with 0.4 roll factor and 30 delay
delay = delay*q_ratio;      
complex_time_signal = y(delay+1:end-delay).';            % output a raised cosine pulse shaped signal

end
