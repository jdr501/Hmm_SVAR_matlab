function [residuals] = res_estimate(wls_param,delta_yt, zt)
%RES_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
% make sure to have a column vector of WLS params 
    if size(wls_param(2))> 1
       wls_param =  reshape(wls_param, size(wls_param(2)),1);
       disp('row vector of wls_param provided, reshaped to a column vector')      
    end 
[obs, K_var] = size(delta_yt);
residuals = zeros(size(delta_yt), 'unit64');
    for t = 1: obs
        temp = delta_yt(t,:).T - ...
                         kron(zt(t,:), eye(K_var)) * wls_param ;
        residuals(t,:) = temp.T;
    end 


end

