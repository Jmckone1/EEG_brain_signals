% provides an output that plots the raw EEG data for a particular event,
% inputs the channel data, the channel name for plotting and the subplot
% numbers as an array of 2 numbers i.e [8,4].

function run_raw_graphs(channel_1,input_name,plotNum)
    
    % gets the number of channels in the input data
    [x,z] = size(channel_1);
    
    % plots all channels on a single graph -  hard limiting on axis
    figure;
    plot(1:x,channel_1(:,:));
    title(input_name);
    ylim([-350 550])

    % plots all channels seperately on a single subplot - hard limiting on
    % axis
    figure
    for v = 2:z
        subplot(plotNum(1),plotNum(2),v-1);
        plot(1:x,channel_1(:,v));
        title("Channel " + v);
        ylim([-350 550])
    end
end