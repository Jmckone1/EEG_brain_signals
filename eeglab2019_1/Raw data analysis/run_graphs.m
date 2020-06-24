clc; clear; close all;

% input workspace, defined in the prior
% load('Workspaces/cba1ff01_32_wk.mat');
load('Workspaces/cba1ff01_wk.mat');

test_channel_1 = Event_028;
fs = 1000;
% subplot_dims = [4,8]; % for 32 channel data
subplot_dims = [3,4]; % for 10 channel data
% gets input dimensions
[L,C] = size(test_channel_1);

% ------ fast time fourier start ------ %
% provides a frequency analysis of the data.

run_raw_graphs(test_channel_1,"event 007",subplot_dims);
% output matrix for signal frequency and ampllitude
x = size( run_fast_fourier_2(test_channel_1,fs,1));
P1_output = zeros(x(2), C);
F1_output = zeros(x(2), C);

figure;

% for each channel
for v = 2:C
    % apply fft to the signal
    [f,P] = run_fast_fourier_2(test_channel_1,fs,v);
    subplot(subplot_dims(1),subplot_dims(2),v-1);
    % plot the frequency/amplitude fourier
    plot(f,P);
    title("Channel " + v);
    P1_output(:,v-1) = P;
    F1_output(:,v-1) = f;
end

% -----short time fourier start----- %
% applies the short time fourier transform that shows the time-frequency
% analysis of the data - with a manually defined frame size (64 - 1024).
% higher frame sizes means more frequency data and less temporal data,
% lower fram sizes means less frequency data and more temporal data.

figure;

% for each channel
for v = 2:C
    % set base frame size
    frame_size = 32;
    subplot(subplot_dims(1),subplot_dims(2),v-1);
    [f1,p11] = run_short_fourier(test_channel_1(:,v),fs,frame_size);
    % prodcues an amplitude spectrogram dependant upon the frame size
    title("Channel " + v);
    legend(int2str(frame_size));
    xlabel('Time (s)'); ylabel('Frequency, Hz');
end

% ----- Continuous wavelet start----- %
% applies the continuous wavelet transform on the data for an automated
% time-frequency analysis frame sizing - produces a spectrogram as an
% output

figure;

% for each channel
for v = 2:C
    subplot(subplot_dims(1),subplot_dims(2),v-1);
    CWT_in(test_channel_1(:,v));
    title("Channel " + v);
end
