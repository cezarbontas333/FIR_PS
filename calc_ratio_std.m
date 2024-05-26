function [ratio_std] = calc_ratio_std(H, stopband, passband)
%CALC_RATIO_STD Calculates ratio of standard deviations
%   Ratio is between stop band and pass band.
ratio_std = std(abs(H(length(H) - length(stopband) : end))) / std(abs(H(1 : length(passband))));
end

