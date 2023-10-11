function [sigma,x0] = initial_sigma(residuals,regimes)
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
    %b_mat = pinv(sum/obs);
    %b_mat = b_mat ;%+ randn(k_vars,k_vars);
    bmat2 = cov(residuals)+ 0.01* randn(k_vars,k_vars);
    b_mat = bmat2;

    for regime = 1: regimes 
        sigma(:,:, regime) = b_mat * b_mat.';
    end
 
    x0 = ones(1, k_vars*k_vars+k_vars*(regimes-1));
    x0(1,1:k_vars*k_vars)= reshape(b_mat,[], k_vars*k_vars);
    

end

