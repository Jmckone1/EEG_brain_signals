function run_graphs(channel_name1, channel_name2)
    
    test_channel_1 = channel_name1;
    test_channel_2 = channel_name2;
    figure;

    [x,~] = size(test_channel_1);
    subplot(1,2,1);
    plot(1:x,test_channel_1(:,:));
    title("Test channel 1");
    ylim([-350 350])

    %figure;
    [x,~] = size(test_channel_2);
    subplot(1,2,2);
    plot(1:x,test_channel_2(:,:));
    title("Test channel 2");
    ylim([-350 350])

    figure
    for v = 2:32
        [x,~] = size(test_channel_1);
        subplot(4,8,v-1);
        plot(1:x,test_channel_1(:,v));
        title("Channel " + v);
        ylim([-350 350])
    end

    figure
    for v = 2:32
        [x,~] = size(test_channel_2);
        subplot(4,8,v-1);
        plot(1:x,test_channel_2(:,v));
        title("Channel " + v);
        ylim([-350 350])
    end
end