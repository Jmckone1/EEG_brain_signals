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
    subplot(2,1,1)
    plot(1:window_size+1,test_channel_1(a:a+window_size));
    % FFT %
    subplot(2,1,2)
    [f,P] = run_fast_fourier_2(test_channel_1(a:a+window_size),fs,v);
    % plot the frequency/amplitude fourier

    plot(f,P);
    % P1_output(:,v) = P;
    % F1_output(:,v) = f;

end

% 
% frame_size = 64;
% for j = 1:4
%     % STFT %
%     figure;
%     [f1,p11] = run_short_fourier(test_channel_1(:,v),fs,frame_size);
%     legend(int2str(frame_size));
%     xlabel('Time (s)'); ylabel('Frequency, Hz');
%     frame_size = frame_size * 2;
% end
% 
% % CWT %
% figure;
% CWT_in(test_channel_1(:,v));
% title("Channel " + v);
