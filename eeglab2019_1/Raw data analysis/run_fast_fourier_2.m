% runs the fast fourier transform on an input event, producing a plot for
% each of the possible channels. 
%
% Takes a multichannel event (input event) and the frequency sampled (fs).
%
% need to figure out a way 
function [f,P1_1] = run_fast_fourier_2(input_event,fs,v)
    
    % Length and size of the channel
    [L,C] = size(input_event);
    
    Y1 = fft(input_event(:,v));

    % get the signal amplitude points
    P2_1 = abs(Y1/L);
    P1_1 = P2_1(1:floor(L/2)+1);
    P1_1(2:end-1) = 2*P1_1(2:end-1);

    % get the signal frequency points
    f = fs*(0:(L/2))/L;

end