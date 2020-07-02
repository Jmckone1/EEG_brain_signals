% provides an output that plots the raw EEG data for a particular event,
% inputs the channel data, the channel name for plotting and the subplot
% numbers as an array of 2 numbers i.e [8,4], and the trend level for the
% detrending function (9 point polynominal is best so far);

function run_raw_graphs(channel_1,input_name,plotNum,trend_level)
    
    % gets the number of channels in the input data
    [x,z] = size(channel_1);

    % plots all channels on a single graph -  hard limiting on axis
    figure;
    detrend_sdata = detrend(channel_1,trend_level);
    plot(1:x,detrend_sdata(:,:));
    title(input_name);
    ylim([-350 550])

    % plots all channels seperately on a single subplot - hard limiting on
    % axis
    figure
    for v = 1:z
        detrend_sdata = detrend(channel_1(:,v),trend_level);
        trend = channel_1(:,v) - detrend_sdata;
        mean(detrend_sdata);
        
        subplot(plotNum(1),plotNum(2),v);
        plot(1:x,detrend_sdata);
        title("Channel " + v);
        ylim([-350 550])
        hold on
        plot(1:x,trend,':r');
        hold on 
        plot(channel_1(:,v),':b')
        hold off
        legend("detreded data","trend","original data");
    end
end