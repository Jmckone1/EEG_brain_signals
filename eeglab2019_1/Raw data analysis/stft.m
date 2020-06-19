function [STFT,f,t] = stft(x,win,hop,nfft,fs)
    x = x(:);
    xlen = length(x);
    wlen = length(win);
    NUP = ceil((1+nfft)/2);
    L = 1+fix((xlen-wlen)/hop);
    STFT = zeros(NUP,L);
    for i = 0:L-1
        xw = x(1+i*hop:wlen+i*hop).*win;
        X=fft(xw,nfft);
        STFT(:,1+i) = X(1:NUP);
    end
    t=(wlen/2:hop:wlen/2+(L-1)*hop)/fs;
    f=(0:NUP-1)*fs/nfft;
end