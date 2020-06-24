clc; clear; close all;

% input the event file
Event_filename = "Event_files/cba1ff05_events.csv";
Data_filename = "Data_files/cba1ff05_data.csv";

writestats = 0;

% event 01 is in some cases flawed and in most cases significantly longer
% than the rest of the events given a subject.

% read the csv file contents for the events and the signal data
Events = readmatrix(Event_filename);
Data = readmatrix(Data_filename);

% Data = split_channels(Data);

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

% info matrix: 
% 1 event number
% 2 event start
% 3 event end
% 4 event classification
% 5 channel 1 max
% 6 channel 1 min
% 7 channel 1 mean

info_matrix = zeros(m,7);
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
    if sum(data(:,2) > 300) > 0
        label_prelim(i) = 1;
    else
        label_prelim(i) = 0;
    end
    if writestats == 1
        info_matrix(i-1,1) = i-1;
        info_matrix(i-1,2) = event_start;
        info_matrix(i-1,3) = event_end;
        info_matrix(i-1,4) = label_prelim(i);
        info_matrix(i-1,5) = max(data(:,2));
        info_matrix(i-1,6) = min(data(:,2));
        info_matrix(i-1,7) = mean(data(:,2));
    end
    if i < m+1
        event_start = event_end;
        event_end = Events(i,3);
    end
end

if writestats == 1
    writematrix(info_matrix,"class/cba1ff05_info.csv");
end

