clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba1ff02_data.csv";
% read the csv file contents for the signal data
Data = readmatrix(Data_filename);
fs = 1000; % sampling rate
v = 1; % one channel
test_channel_1 = Data(:,[2,3,4,5,12,13,18]);
start = 1;
max_out = 10; % max output plots before break

% if 0 no plot only write
% if 1 no write only plot
% if 2 no plot no write
plott = 1;

[i,~] = size(Data(:,2));
step_size = 1024;
window_size = 2048;

test_channel_1 = detrend(test_channel_1,4);

x = mod(i,step_size);
y = i - x;
loop = 0;
j = 1;
% info_matrix = zeros((y/step_size)-1,7);

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
            subplot(4,1,1)
            plot(1:window_size+1,channel_frame);
        end
        
        % FFT %
        
        [fft_f,fft_P] = run_fast_fourier_2(channel_frame,fs,v);
        fft_raw = fft(channel_frame);
        % plot the frequency/amplitude fourier
        if plott == 1
            subplot(4,1,2)
            plot(fft_f,fft_P);
        end
        fftStats(loop,1) = min(fft_P);
        fftStats(loop,2) = max(fft_P);
        fftStats(loop,3) = mean(fft_P);
        fftStats(loop,4) = std(fft_P);
        
        % STFT %
        if plott == 1
            subplot(4,1,3);
        end
        
        frame_size = 1024;
        [stft_raw,stft_f,stft_P] = short_fourier(channel_frame,fs,frame_size,plott);
        
        if plott == 1
            legend(int2str(frame_size));
            xlabel('Time (s)'); ylabel('Frequency, Hz');
        end
        
        stftStats(loop,1) = min(min(stft_P));
        stftStats(loop,2) = max(max(stft_P));
        stftStats(loop,3) = mean(mean(stft_P));
        stftStats(loop,4) = std(std(stft_P));

        % CWT %
        if plott == 1
            subplot(4,1,4);
        end
        [cwt] = Cont_wave(channel_frame(:,2),plott);
        
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
    
    % if plott is 0 (i.e no plotting output) save the variables to mat files
    if plott == 0
        dataset = "dataset_02";

        save("outputs/" + dataset + "/fft/time_" + loop + ".mat",'fft_raw','fft_f','fft_P');
        save("outputs/" + dataset + "/stft/time_" + loop + ".mat",'stft_raw','stft_f','stft_P');
        save("outputs/" + dataset + "/cwt/time_" + loop + ".mat",'cwt');
    end
end

if plott == 0
    save("outputs/" + dataset + "/stats.mat",'fftStats','stftStats');
end