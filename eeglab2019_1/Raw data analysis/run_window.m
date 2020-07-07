clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba1ff01_data.csv";
title = "data1";
% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % sampling rate
v = 1; % one channel
test_channel_1 = Data(:,[2,3]);
max_out = 1000; % max output plots before break

[i,~] = size(Data(:,2));
step_size = 1024;
window_size = 2048;

test_channel_1 = detrend(test_channel_1,4);

x = mod(i,step_size);
y = i - x;
loop = 0;
j = 1;
info_matrix = zeros((y/step_size)-1,7);


for a = 1:step_size:y
    
    if loop == max_out || a+window_size > i-1
        break;
    end
    loop = loop + 1;
    
    % channel_frame = detrend(test_channel_1(a:a+window_size),9);
    channel_frame = test_channel_1(a:a+window_size);
    info_matrix = write_stats(info_matrix,channel_frame,loop,y/step_size,a,a+window_size,title,0);
    % Raw signal %
%     figure;
%     subplot(4,1,1)
%     plot(1:window_size+1,channel_frame);
%     
%     % FFT %
%     subplot(4,1,2)
%     [f,P] = run_fast_fourier_2(channel_frame,fs,v);
%     % plot the frequency/amplitude fourier
%     plot(f,P);
% 
%     % STFT %
%     subplot(4,1,3);
%     frame_size = 128;
%     [f1,p11] = run_short_fourier(channel_frame,fs,frame_size);
%     legend(int2str(frame_size));
%     xlabel('Time (s)'); ylabel('Frequency, Hz');
% 
%     % CWT %
%     subplot(4,1,4);
%     CWT_in(channel_frame);
    
end
