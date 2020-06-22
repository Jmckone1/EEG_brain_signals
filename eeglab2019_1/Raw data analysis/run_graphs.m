clc; clear; close all;
load('Workspaces/cba1ff01_wk.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   code Run                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_channel_1 = Event_007; % event does not occur 
test_channel_2 = Event_008; % event does occur
fs = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           channel 1           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ------fast time fourier start------ %

[L,C] = size(test_channel_1);

run_raw_graphs(test_channel_1,"event 007");
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

% i need to label this properly for the output
for v = 2:C
    subplot(3,4,v-1);
    CWT_in(test_channel_2(:,v));
end


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %           channel 2           %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% [L,C] = size(test_channel_2);
% 
% run_raw_graphs(test_channel_2,"event 008");
% % output matrix for signal frequency and ampllitude
% x = size( run_fast_fourier_2(test_channel_2,1000,1));
% P2_output = zeros(x(2), C);
% F2_output = zeros(x(2), C);
% figure
% 
% for v = 2:C
%     % apply fft to the signal
%     [f,P] = run_fast_fourier_2(test_channel_2,1000,v);
%     % plot the frequency/amplitude fourier
%     subplot(3,4,v-1);plot(f,P);title("Channel " + v);
%     P2_output(:,v-1) = P; % signal plot points
%     F2_output(:,v-1) = f; % amplitude plot points
% end
% 
% % ----fast fourier transform end---- %
% % -----------------------------------%
% % -----short time fourier start----- %
% 

% 
% figure
% % for each channel
% for v = 2:C
%     % set base frame size
%     frame_size = 512;
%     subplot(3,4,v-1);plot(f,P);title("Channel " + v);
%     [f1,P11] = run_short_fourier(test_channel_2,fs,frame_size);
%     title(['spectogram of amplitude, frame size: ',num2str(frame_size)])
%     xlabel('Time, s'); ylabel('Frequency, Hz');
% end
% 
% % ------short time fourier end------ %
% % ---------------------------------- %
% 

