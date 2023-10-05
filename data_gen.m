function [delta_yt,zt] = data_gen(data_mat,lags,Beta_array)
%DATA_GEN Summary of this function goes here
%   Detailed explanation goes here
original_obs = size(data_mat,1);
k_vars = size(data_mat,2);
zt_vars = 3+k_vars*lags;

zt = zeros(original_obs-1, zt_vars);

delta_yt = diff(data_mat);
zt(:,1+end-lags*k_vars:end) = lagmat(delta_yt,lags);

zt(:,1)= ones(original_obs-1,1);
zt(:,2)= 1:original_obs-1;

    for t = 2: original_obs-1
    observation = reshape(data_mat(t-1,:),k_vars,1);
    zt(t,3)= Beta_array *observation;
    end 
zt =zt(lags+1:end,:);
delta_yt = delta_yt(1+lags:end,:);
end

