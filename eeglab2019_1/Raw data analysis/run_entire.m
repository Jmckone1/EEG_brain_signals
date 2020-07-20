clear; clc; close all;
% input the data file
Data_filename = "Data_files/cba2ff04_data.csv";

% dataset 1_03, 1_10, 1_11, 1_13
% dataset 2_06, 2_08 seems irregular, 2_11, 2_12
% read the csv file contents for the signal data

% this observation was only for channel 1, in almost all cases of the
% dataset there is some irregularity in at least one of the major channels
% (those that show the most response) this is likely cuased due to slippage
% or vibration of an electrode due to motion of the subject, not sure if
% there is a way to detect / fix this but its likely a large part of the
% problem when it comes to extracranal electrodes.
Data = readmatrix(Data_filename);
fs = 1000; %
% v = 1; % one channel
%test_channel_1 = Data(:,5);
test_channel_1 = Data(:,[2,3,4,5,12,13,18]);
[x,C] = size(test_channel_1);
plot_s = [4,2];

figure;
plot(test_channel_1);
title("original data");

d_data = detrend(test_channel_1,9);
trend = test_channel_1 - d_data;
mean_val = mean(d_data);
% 212416 (x^2) above 200,000

figure
plot(1:x,trend);
title("data trends");
xlabel("time (ms)");
ylabel("signal amplitude");

figure
plot(1:x,d_data);

% plot each of the detrended channels individually
figure;
for v = 1:C
    subplot(plot_s(1),plot_s(2),v);
    plot(1:x,d_data(:,v));
    title("channel " + v);
end

% performs the fast fourier transform, due to the high prevelance of 0
% within the dataset the first 50 values have been ignored for the time
% being, this allows more clarity on the rest of the signal frequencies.

% throughout each of the signals there appears to be a drop precisely at
% the 50Hz zone, otherwise the data tends towards 0.
% FFT %
figure;
for v = 1:C
    subplot(plot_s(1),plot_s(2),v);
    [f,P] = run_fast_fourier_2(test_channel_1,fs,v);
    plot(f(:,50:end),P(50:end,:));
    ylabel("Amplitude"); xlabel("frequency(Hz)");
    title("Fast Fourier Transform (FFT) entire signal");
end

% % the stft process takes a massive amount of resource to produce a plot
% of this size, due to it being a spectrogram and hasving the amount of
% points, havent used it for this part of the process unless it wants to be
% done manually / individually.

% figure;
% frame_size = 64;
% % for j = 1:4
% %     % STFT %
% %     figure;
%     for v = 1:C
%         subplot(plot_s(1),plot_s(2),v);
%         [f1,p11] = run_short_fourier(test_channel_1(1:10:end,v),fs,frame_size);
%         legend(int2str(frame_size));
%         xlabel('Time (s)'); ylabel('Frequency, Hz');
%     end
%     frame_size = frame_size * 2;
% % end

% not much of interest but at least it runs fast for this bit
% CWT %
figure;
for v = 1:C
    subplot(plot_s(1),plot_s(2),v);
    CWT_in(test_channel_1(:,v));
    title("channel" + v);
end
