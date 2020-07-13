clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba2ff10_data.csv";
title = "b";
% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % sampling rate
v = 1; % one channel
% test_channel_1 = Data(:,[2,3]);
test_channel_1 = Data(:,[2,3,4,5,12,13,18]);
start = 1;
max_out = 200; % max output plots before break
plott = 0;

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
    if loop >= start
        % channel_frame = detrend(test_channel_1(a:a+window_size),9);
        channel_frame = test_channel_1(a:a+window_size,:);
        %info_matrix = write_stats(info_matrix,channel_frame,loop,y/step_size,a,a+window_size,title,0);
        % Raw signal %
        if plott == 1
            figure;
            subplot(3,1,1)
            plot(1:window_size+1,channel_frame);
        end
        
        % FFT %
        
        [f,P] = run_fast_fourier_2(channel_frame,fs,v);
        % plot the frequency/amplitude fourier
        if plott == 1
            subplot(3,1,2)
            plot(f,P);
        end
        fftStats(loop,1) = min(P);
        fftStats(loop,2) = max(P);
        fftStats(loop,3) = mean(P);
        fftStats(loop,4) = std(P);
        
        % STFT %
        
        frame_size = 128;
        [f1,p11] = run_short_fourier(channel_frame,fs,frame_size);
        subplot(3,1,3);
        legend(int2str(frame_size));
        xlabel('Time (s)'); ylabel('Frequency, Hz');
        stftStats(loop,1) = min(min(p11));
        stftStats(loop,2) = max(max(p11));
        stftStats(loop,3) = mean(mean(p11));
        stftStats(loop,4) = std(std(p11));

    % 
    %     % CWT %
    %     subplot(4,1,4);
    %     CWT_in(channel_frame(:,2));
    %     
        if plott == 1
            figure;
            for s = 1:7

                subplot(2,4,s)
                CWT_in(channel_frame(:,s));
            end

            figure;
            for s = 1:7
                subplot(2,4,s)
                frame_size = 128;
                [f1,p11] = run_short_fourier(channel_frame(:,s),fs,frame_size);
                legend(int2str(frame_size));
                xlabel('Time (s)'); ylabel('Frequency, Hz');
            end
        end
    end
    
end
