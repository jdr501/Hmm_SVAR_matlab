function [delta_yt,zt,resid,start_prob,trans_prob, sigma] = initialize(data_mat, lags,Beta_array, regimes)
%INITIALIZE Summary of this function goes here
%   Detailed explanation goes here
[delta_yt,zt] = data_gen(data_mat,lags,Beta_array);
resid = ols_resid(delta_yt,zt);
sigma = initial_sigma(resid,regimes)
start_prob = ones(regimes)/regimes; % done
trans_prob = ones(regimes,regimes)/regimes; % done 

