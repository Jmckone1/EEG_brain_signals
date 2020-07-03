clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba1ff02_data.csv";

% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % 
v = 1; % one channel
test_channel_1 = Data(:,2);

[i,~] = size(Data(:,2));
step_size = 1024;
window_size = 2048;

test_channel_1 = detrend(test_channel_1,4);

x = mod(i,step_size);
y = i - x;
i = 0;

for a = 1:step_size:y+1
    % channel_frame = detrend(test_channel_1(a:a+window_size),9);
    channel_frame = test_channel_1(a:a+window_size);

    % Raw signal %
    figure;
    subplot(4,1,1)
    plot(1:window_size+1,channel_frame);
    
    % FFT %
    subplot(4,1,2)
    [f,P] = run_fast_fourier_2(channel_frame,fs,v);
    % plot the frequency/amplitude fourier
    plot(f,P);

    % STFT %
    subplot(4,1,3);
    frame_size = 128;
    [f1,p11] = run_short_fourier(channel_frame,fs,frame_size);
    legend(int2str(frame_size));
    xlabel('Time (s)'); ylabel('Frequency, Hz');

    % CWT %
    subplot(4,1,4);
    CWT_in(channel_frame);
    
    i = i + 1;
    
    if i == 10
        break;
    end
end
