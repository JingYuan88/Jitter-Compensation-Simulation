clc;
clear all;
close all;


jit = [ 1e-12 1e-11 2e-11 3e-11 4e-11 5e-11 6e-11 7e-11 8e-11 9e-11 10e-11 11e-11 12e-11 13e-11 14e-11 ]*1e12;

ori_idealchan   = [ 0 0 0 0.0050 0.1183 0.3317 0.6117 0.7317 0.7817 0.8233 0.8717 0.8633 0.9050 0.9167 0.9200];
cubic_idealchan = [ 0 0 0 0.0117 0.0400 0.0917 0.1967 0.3233 0.5000 0.6417 0.7367 0.7767 0.8583 0.8800 0.9350];

ori_snr5    = [ 0.0033 0.0050 0.0200 0.0933 0.2217 0.3933 0.6217 0.7350 0.7950 0.8483 0.8583 0.8750 0.9067 0.9267 0.9150];
cubic_snr5  = [ 0.0683 0.0583 0.0833 0.1350 0.2033 0.2450 0.3467 0.4567 0.5933 0.7150 0.7583 0.8100 0.8717 0.8867 0.9100];

ori_snr10   = [ 0 0 0 0.0317 0.1600 0.3633 0.6200 0.7217 0.7800 0.8350 0.8767 0.8767 0.9017 0.9117 0.9117];
cubic_snr10 = [ 0.0017 0 0.0167 0.0333 0.0917 0.1567 0.2533 0.3700 0.5150 0.6550 0.7500 0.7717 0.8633 0.8750 0.9217 ];


ori_snr18   = [ 0 0 0 0.0067 0.1117 0.3350 0.6267 0.7283 0.7800 0.8217 0.8700 0.8617 0.9050 0.9183 0.9200];
cubic_snr18 = [ 0 0 0.0017 0.0167 0.0450 0.0833 0.2083 0.3383 0.5033 0.6433 0.7183 0.7667 0.8550 0.8750 0.9183];


figure;
plot(jit,cubic_idealchan,'LineWidth',2);hold;
plot(jit,cubic_snr5,'--mo','LineWidth',2,'MarkerSize',7);
plot(jit,cubic_snr10,':gs','LineWidth',2,'MarkerSize',7);
plot(jit,cubic_snr18,'-.r*','LineWidth',2,'MarkerSize',7);
xlabel('Jitter rms value(standard deviation), pS');ylabel('Symbol Error Rate');grid on;
title('Symbol Error Rate for Jitter rms At Different AWGN Channel');
legend('cubic-idealchan', 'cubic-snr5', 'cubic-snr10', 'cubic-snr18' ); hold;



figure;
plot(jit,ori_idealchan,'LineWidth',2);hold;
plot(jit,ori_snr5,'--mo','LineWidth',2,'MarkerSize',7);
plot(jit,ori_snr10,':gs','LineWidth',2,'MarkerSize',7);
plot(jit,ori_snr18,'-.r*','LineWidth',2,'MarkerSize',7);
xlabel('Jitter rms value(standard deviation), pS');ylabel('Symbol Error Rate');grid on;
title('Symbol Error Rate for Jitter rms At Different AWGN Channel');
legend('ori-idealchan', 'ori-snr5', 'ori-snr10', 'ori-snr18' ); hold;