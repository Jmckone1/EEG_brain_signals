clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba1ff05_data.csv";

% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % 
v = 1; % one channel
test_channel_1 = Data(:,3);
<<<<<<< Updated upstream
=======
[x,~] = size(test_channel_1);
>>>>>>> Stashed changes

figure
plot(test_channel_1)
title("original data")

d_data = detrend(test_channel_1,4);
trend = test_channel_1 - d_data;
mean(d_data);
% 212416 (x^2) above 200,000

figure
plot(1:x,d_data);
title("Channel " + v);
hold on
plot(1:x,trend,':r');
hold on 
plot(test_channel_1,':b')
hold off
title("detrended data");

% FFT %
figure;
[f,P] = run_fast_fourier_2(test_channel_1,fs,v);
% plot the frequency/amplitude fourier

plot(f,P);
P1_output(:,v) = P;
F1_output(:,v) = f;

frame_size = 64;
for j = 1:4
    % STFT %
    figure;
    [f1,p11] = run_short_fourier(test_channel_1(:,v),fs,frame_size);
    legend(int2str(frame_size));
    xlabel('Time (s)'); ylabel('Frequency, Hz');
    frame_size = frame_size * 2;
end

% CWT %
figure;
CWT_in(test_channel_1(:,v));
title("Channel " + v);
