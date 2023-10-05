function [sigma] = initial_sigma(residuals,regimes)
%INITIAL_SIGMA Summary of this function goes here
%   Detailed explanation goes here
shape = size(residuals);
obs = shape(1);
k_vars = shape(2);
sigma = zeros(k_vars, k_vars, regimes );
sum = 0 ;
    for t= 1:obs 
        tem_resid = residuals(t,:).';
        sum = tem_resid*tem_resid.';
    end 
    b_mat = pinv(sum/obs);
    b_mat = b_mat + rand(k_vars);
    
    for regime = 1: regimes 
        sigma(:,:, regime) = b_mat * b_mat.';
    end 
end

