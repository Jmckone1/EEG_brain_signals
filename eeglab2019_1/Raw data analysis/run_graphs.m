clc; clear; close all;

% input workspace, defined in the prior
load('Workspaces/cba1ff03_32_wk.mat');
% load('Workspaces/cba1ff04_wk.mat');
% load('Workspaces/detrend.mat');

% events 7, 8, 15,18,19,20,54,55,96,97
test_channel_1 = Event_009;

% in some cases channel 14 and 19 show some response (very few)

% dataset 3 has some interesting respoinses, either being dim in amost all
% or bright in many channels other that those that show the most consistant
% response

trend_level = 0;
fs = 1000;
subplot_dims = [4,8]; % for 32 channel data
% subplot_dims = [3,4]; % for 9 channel data
% gets input dimensions
[L,C] = size(test_channel_1);

% ------ fast time fourier start ------ %
% provides a frequency analysis of the data.

% making use of a 9 point polynominal in order to remove the general trends
% from the data
test_channel_1 = detrend(test_channel_1,trend_level);

% final value starts at the channel specified (since channel 1 in the 32
% channel data is the time series of the dataset)
run_raw_graphs(test_channel_1,"event 008",subplot_dims,2);
% output matrix for signal frequency and ampllitude
x = size( run_fast_fourier_2(test_channel_1,fs,1));
P1_output = zeros(x(2), C);
F1_output = zeros(x(2), C);

% % making use of a 9 point polynominal in order to remove the general trends
% % from the data
% test_channel_1 = detrend(test_channel_1,trend_level);

figure;
% for each channel
for v = 1:C
    % apply fft to the signal
    [f,P] = run_fast_fourier_2(test_channel_1,fs,v);
    subplot(subplot_dims(1),subplot_dims(2),v);
    % plot the frequency/amplitude fourier
    plot(f,P);
    title("Channel " + v);
    P1_output(:,v) = P;
    F1_output(:,v) = f;
end

% -----short time fourier start----- %
% applies the short time fourier transform that shows the time-frequency
% analysis of the data - with a manually defined frame size (64 - 1024).
% higher frame sizes means more frequency data and less temporal data,
% lower fram sizes means less frequency data and more temporal data.

figure;

% for each channel
for v = 1:C
    % set base frame size
    frame_size = 128;
    subplot(subplot_dims(1),subplot_dims(2),v);
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
for v = 1:C
    subplot(subplot_dims(1),subplot_dims(2),v);
    CWT_in(test_channel_1(:,v));
    title("Channel " + v);
end

xdMODWT = wden(test_channel_1(:,2),'modwtsqtwolog','s','mln',10,'sym4');
% xd = wdenoise(test_channel_1(:,2),4);
figure;
% plot(test_channel_1(:,2),'r')
% hold on;
plot(xdMODWT);
figure;
plot(test_channel_1(:,2));
