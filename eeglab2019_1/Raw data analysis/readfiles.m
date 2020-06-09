clc; clear; close all;

Event_filename = "cba1ff01_events.csv";
Data_filename = "cba1ff01_data.csv";

Events = readmatrix(Event_filename);
Data = readmatrix(Data_filename);

[m,n] = size(Events);
event_start = 1;
event_end = Events(1,3);

str1=repmat('Event_',m,1);
% sets the number of possible segments into the 100s (removes the first
% digit for string creation)
N0=num2str(1000+(1:1:m)');N0(:,1)=[];
N1=repmat('=Data(event_start:event_end,:',m,1);
N2=repmat(');',m,1);
str2=[str1 N0 N1 N2];

str3 = [str1 N0];

% loop through each of the possible events
for i = 2:m+1
    L2=str2(i-1,:);
    evalin('base',L2);
    
    % k becomes the labels (prelim) for whether an event occurs or not
    % based upon the first channel
    data = Data(event_start:event_end,:);
    if sum(data(:,2) > 0) > 0
        label_prelim(i) = 1;
    else
        label_prelim(i) = 0;
    end
    if i < m+1
        event_start = event_end;
        event_end = Events(i,3);
    end
end

%channel = 2;
test_channel_1 = Event_007;
test_channel_2 = Event_008;

run_graphs(test_channel_1,test_channel_2);
run_fourier(test_channel_1,1000);
run_fourier(test_channel_2,1000);
% 
% figure;
% [x,~] = size(test_channel_1);
% subplot(1,2,1);
% plot(1:x,test_channel_1(:,channel));
% subplot(1,2,2);
% Fourier = fft(test_channel_1(:,channel));
% plot(1:x,Fourier)
% 
% figure;
% [x,~] = size(test_channel_2);
% subplot(1,2,1);
% plot(1:x,test_channel_2(:,channel));
% subplot(1,2,2);
% Fourier = fft(test_channel_2(:,channel));
% plot(1:x,Fourier)
