% implement the short time fourier transform
function [X,f,S] = short_fourier(x,fs,wlen,plot)

    % window length (recomended to be power of 2)
    % wlen;
    hop = wlen/4;
    % number of fft points (recomended to be power of 2)
    nfft = 4096;  
    % perform STFT
    win = blackman(wlen, 'periodic');
    [S, f, t] = stft(x, win, hop, nfft, fs);

    % calculate the coherent amplification of the window
    C = sum(win)/wlen;

    % take the amplitude of fft(x) and scale it, so not to be a
    % function of the length of the window and its coherent amplification
    X = S;
    S = abs(S)/wlen/C;

    % correction of the DC & Nyquist component
    if rem(nfft, 2)
        % odd nfft excludes Nyquist point
        S(2:end, :) = S(2:end, :).*2;
    else
        % even nfft includes Nyquist point
        S(2:end-1, :) = S(2:end-1, :).*2;
    end

    % convert amplitude spectrum to dB (min = -120 dB)
    S = 20*log10(S + 1e-6);
    if plot == 1
        % plot the spectrogram
        surf(t, f, S)
        shading interp
        axis tight
        view(0, 90)
        hcol = colorbar; ylabel(hcol, 'Magnitude, dB')
    end
    
end