function [result] = lagmat(delta_yt,lags)
%LAGMAT Summary of this function goes here
%   Detailed explanation goes here
shape = size(delta_yt);
obs = shape(1);
k_vars = shape(2);
result = zeros(obs,k_vars*lags);
    start = 1; 
    ending = k_vars ;
    for lag = 1:lags
        result(lag+1:end ,start:ending)= delta_yt(1:end-lag, :);  
        start = ending +1; 
        ending = ending + k_vars;
    end 

end

