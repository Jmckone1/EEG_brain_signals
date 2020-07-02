clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba1ff01_data.csv";

% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % 
v = 1; % one channel
test_channel_1 = Data(:,2);

[i,~] = size(Data(:,2));
step_size = 1024;
window_size = 2048;

test_channel_1 = detrend(test_channel_1,10);

x = mod(i,step_size);
y = i - x;

for a = 1:step_size:y+1

    figure;
    subplot(4,1,1)
    plot(1:window_size+1,test_channel_1(a:a+window_size));
    % FFT %
    subplot(4,1,2)
    [f,P] = run_fast_fourier_2(test_channel_1(a:a+window_size),fs,v);
    % plot the frequency/amplitude fourier
    plot(f,P);

    frame_size = 128;
    % STFT %
    subplot(4,1,3);
    [f1,p11] = run_short_fourier(test_channel_1(:,v),fs,frame_size);
    legend(int2str(frame_size));
    xlabel('Time (s)'); ylabel('Frequency, Hz');

    % CWT %
    subplot(4,1,4);
    CWT_in(test_channel_1(:,v));
    title("Channel " + v);

end
