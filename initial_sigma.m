function [sigma,x0] = initial_sigma(residuals,regimes)
global ols_b_mat
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
    
    bmat2 = cov(residuals)+ 0.1* randn(k_vars,k_vars)
    b_mat = bmat2;
    ols_b_mat = b_mat;
    for regime = 1: regimes 
        sigma(:,:, regime) = b_mat * b_mat.';
    end
    
    %{
    %=======================
    b_mat= randn(4);
    lam = eye(k_vars).*rand(4,1)*10;
    %=======================


    
    for regime = 1: regimes 
        if regime ==1
        sigma(:,:, regime) = (b_mat * b_mat.');
        else
         sigma(:,:, regime) = (b_mat * lam* b_mat.') ;  
        end 
    end
    %}
    
    ini_lambda_guess = zeros(1,k_vars*(regimes-1));
    for i = 1: size(ini_lambda_guess,2)
        ini_lambda_guess(1,i)= 1 + rand(1,1);
    end 
 
    x0 = ones(1, k_vars*k_vars+k_vars*(regimes-1));
    x0(1,1:k_vars*k_vars)= reshape(b_mat,[], k_vars*k_vars);
   
    x0(1,k_vars*k_vars+1 : end) = ini_lambda_guess;

end

