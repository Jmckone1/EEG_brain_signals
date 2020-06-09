function run_fourier(input_channel,fs)
    
    % Length and size of the channel
    [L,C] = size(input_channel);
    
    figure
    for v = 2:C
        Y1 = fft(input_channel(:,v));
    
        % get the signal amplitude points
        P2_1 = abs(Y1/L);
        P1_1 = P2_1(1:floor(L/2)+1);
        P1_1(2:end-1) = 2*P1_1(2:end-1);

        % get the signal frequency points
        f = fs*(0:(L/2))/L;
        
        subplot(4,8,v-1);
        plot(f,P1_1);
        title("Channel " + v);
    end
end