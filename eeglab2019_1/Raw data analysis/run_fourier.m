function run_fourier(channel_name1, channel_name2)

    test_channel_1 = channel_name1;
    test_channel_2 = channel_name2;

    figure
    for v = 2:32
        [x,~] = size(test_channel_1);
        subplot(4,8,v-1);
        plot(1:x,real(fft(test_channel_1(:,v))));
        title("Channel " + v);
        ylim([-350 350])
    end

    figure
    for v = 2:32
        [x,~] = size(test_channel_2);
        subplot(4,8,v-1);
        plot(1:x,real(fft(test_channel_2(:,v))));
        title("Channel " + v);
        ylim([-350 350])
    end
end