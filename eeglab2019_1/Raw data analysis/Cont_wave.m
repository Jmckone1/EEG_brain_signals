function [wave] = Cont_wave(signal,plot)

%build synthetic since wave
dt = 0.01;

x = signal;
t = 0:1:length(x)-1;
N = length(t);

%CWT options
pad = 0;
dj = 0.25; %smaller number gives better resolution, default = 0.25;
so = dt; %default
Jfac = 1; %Sets the maximum scale to compute at (therefore number of scales). 1 is equiv to default. 
j1 =  round(Jfac*(log2(N*dt/so))/dj); %default: (log2(N*dt/so))/dj
mother = 'MORLET';
param = 6; %wave number for morlet, see >> help wave_bases for more details

%compute the CWT 
[wave, period, scale, coi, dj, paramout, k] = contwt(x,dt, pad, dj, so, j1, mother, param);

if plot == 1
    %plot wavelet coeffs 
    imagesc(abs(wave)) 
    xlabel('Time (integer index)') 
    ylabel('Scale')
    hold off
end

end