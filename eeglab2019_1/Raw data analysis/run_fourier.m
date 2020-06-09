function run_fourier(test_channel_1, test_channel_2,fs)

    L1 = length(test_channel_1); % signal length
    L2 = length(test_channel_2); % signal length
    
    figure
    for v = 2:32
        Y1 = fft(test_channel_1(:,v));
    
        % get the signal amplitude points
        P2_1 = abs(Y1/L1);
        P1_1 = P2_1(1:floor(L1/2)+1);
        P1_1(2:end-1) = 2*P1_1(2:end-1);

        % get the signal frequency points
        f = fs*(0:(L1/2))/L1;
        
        subplot(4,8,v-1);
        plot(f,P1_1);
        title("Channel " + v);
        %ylim([-350 350])
    end

    figure
    for v = 2:32
        Y1 = fft(test_channel_2(:,v));
        % (signal is symmetrical so only get half)
        % get the signal amplitude points 
        P2_2 = abs(Y1/L2);
        P1_2 = P2_2(1:floor(L2/2)+1);
        P1_2(2:end-1) = 2*P1_2(2:end-1);

        % get the signal frequency points
        f = fs*(0:(L2/2))/L2;
        
        subplot(4,8,v-1);
        plot(f,P1_2);
        title("Channel " + v);
        %ylim([-350 350])
    end
%     figure
%     for v = 2:32
%         fft(test_channel_1(:,v))
%         [x,~] = size(test_channel_1);
%         subplot(4,8,v-1);
%         plot(1:x,real(fft(test_channel_1(:,v))));
%         title("Channel " + v);
%         ylim([-350 350])
%     end
% 
%     figure
%     for v = 2:32
%         [x,~] = size(test_channel_2);
%         subplot(4,8,v-1);
%         plot(1:x,real(fft(test_channel_2(:,v))));
%         title("Channel " + v);
%         ylim([-350 350])
%     end
end