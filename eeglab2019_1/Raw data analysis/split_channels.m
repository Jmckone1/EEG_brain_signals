function [good_channels] = split_channels(all_channels)

% good_channels = all_channels(:,[2,3,4,5,11,12,13,18,23,29]);
good_channels = all_channels(:,[2,3,4,5,12,13,18]);

% second pass after continuous wavelet:
%   2  ,3  ,4 ,5 ,12,13,18
%   B  ,C  ,D ,E ,L ,M ,R
%   FP1,FP2,F3,F4,F7,F8,FZ

end