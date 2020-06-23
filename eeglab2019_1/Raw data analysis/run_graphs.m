clc; clear; close all;
load('Workspaces/cba1ff03_wk.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   code Run                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_channel_1 = Event_028;
fs = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           channel 1           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------ fast time fourier start ------ %

[L,C] = size(test_channel_1);

run_raw_graphs(test_channel_1,"event 007",[3,4]);
% output matrix for signal frequency and ampllitude
x = size( run_fast_fourier_2(test_channel_1,fs,1));
P1_output = zeros(x(2), C);
F1_output = zeros(x(2), C);
figure
for v = 2:C
    % apply fft to the signal
    [f,P] = run_fast_fourier_2(test_channel_1,fs,v);
    subplot(3,4,v-1);plot(f,P);title("Channel " + v);
    % plot the frequency/amplitude fourier
    P1_output(:,v-1) = P;
    F1_output(:,v-1) = f;
end

% -----short time fourier start----- %

figure
% for each channel
for v = 2:C
    % set base frame size
    frame_size = 512;
    subplot(3,4,v-1);
    [f1,p11] = run_short_fourier(test_channel_1(:,v),fs,frame_size);
    %plot(f1,P1_output(v-1));title("Channel " + v);
    title(['spectogram of amplitude, frame size: ',num2str(frame_size)])
    xlabel('Time, s'); ylabel('Frequency, Hz');
end

% ----- Continuous wavelet start----- %

figure
% i need to label this properly for the output
for v = 2:C
    subplot(3,4,v-1);
    CWT_in(test_channel_1(:,v));
end
