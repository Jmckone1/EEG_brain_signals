function run_raw_graphs(channel_1,input_name)
    
    [~,z] = size(channel_1);
    figure;

    [x,~] = size(channel_1);
    plot(1:x,channel_1(:,:));
    title(input_name);
    ylim([-350 350])

    figure
    for v = 2:z
        [x,~] = size(channel_1);
        subplot(4,8,v-1);
        plot(1:x,channel_1(:,v));
        title("Channel " + v);
        ylim([-350 350])
    end
end