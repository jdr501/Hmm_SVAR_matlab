function [delta_yt,zt,resid,start_prob,trans_prob, sigma, x0] = initialize(data_mat, lags,Beta_array, regimes)
%INITIALIZE Summary of this function goes here
%   Detailed explanation goes here
[delta_yt,zt] = data_gen(data_mat,lags,Beta_array);
resid = ols_resid(delta_yt,zt);
[sigma, x0,resid] = initial_sigma(resid,regimes, delta_yt, zt);
start_prob = log(ones(1,regimes)/regimes); % done
trans_prob = log(ones(regimes,regimes)/regimes); % done 


end 