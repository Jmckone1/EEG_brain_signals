clc; clear; close all;

% input the event file
Event_filename = "cba1ff01_events.csv";
Data_filename = "cba1ff01_data.csv";

% read the csv file contents for the events and the signal data
Events = readmatrix(Event_filename);
Data = readmatrix(Data_filename);

% get the dimensions of the event matrix
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

% should i split this section into iterating throught he given events or
% should i use a fixed window size to iterate through the entire signal?
info_matrix = zeros(m,4);
% loop through each of the possible events
for i = 2:m+1

    L2=str2(i-1,:);
    % this runs an imput string (L2) as a line of code
    % 'base' refers to the workspace that the lines will be assigned to as
    % new variables. - i.e base = current directory/ workspace
    evalin('base',L2);
    
    % k becomes the labels (prelim) for whether an event occurs or not
    % based upon the first channel (this is just for testing purposes)
    data = Data(event_start:event_end,:);
    % if there is a value above 0 within the given event then label as 1,
    % otherwise label as 0, this only works for the first event and will
    % need to be chaecked regardless.
    if sum(data(:,2) > 0) > 0
        label_prelim(i) = 1;
    else
        label_prelim(i) = 0;
    end
    
    info_matrix(i-1,1) = i-1;
    info_matrix(i-1,2) = event_start;
    info_matrix(i-1,3) = event_end;
    info_matrix(i-1,4) = label_prelim(i);
    if i < m+1
        event_start = event_end;
        event_end = Events(i,3);
    end
end

writematrix(info_matrix,"class/test.csv");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   code Run                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_channel_1 = Event_007; % event does not occur 
test_channel_2 = Event_008; % event does occur

run_graphs(test_channel_1,test_channel_2);
[L,C] = size(test_channel_1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           channel 1           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% output matrix for signal frequency and ampllitude
x = size( run_fast_fourier_2(test_channel_1,1000,1));
P1_output = zeros(x(2), C);
F1_output = zeros(x(2), C);
figure
for v = 2:C
    % apply fft to the signal
    [f,P] = run_fast_fourier_2(test_channel_1,1000,v);
    subplot(4,8,v-1);plot(f,P);title("Channel " + v);
    % plot the frequency/amplitude fourier
    P1_output(:,v-1) = P;
    F1_output(:,v-1) = f;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           channel 2           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% output matrix for signal frequency and ampllitude
x = size( run_fast_fourier_2(test_channel_2,1000,1));
P2_output = zeros(x(2), C);
F2_output = zeros(x(2), C);
figure
for v = 2:C
    % apply fft to the signal
    [f,P] = run_fast_fourier_2(test_channel_2,1000,v);
    % plot the frequency/amplitude fourier
    subplot(4,8,v-1);plot(f,P);title("Channel " + v);
    P2_output(:,v-1) = P; % signal plot points
    F2_output(:,v-1) = f; % amplitude plot points
end
