function [sigma,x0, resid ] = initial_sigma(residuals,regimes, delta_yt, zt)
global x0_initial  ols_b_mat  
%INITIAL_SIGMA Summary of this function goes here
%   Detailed explanation goes here
shape = size(residuals);
obs = shape(1);
k_vars = shape(2);
sigma = zeros(k_vars, k_vars, regimes );
sum_val = 0 ;
    for t= 1:obs 
        tem_resid = residuals(t,:).';
        sum_val = tem_resid*tem_resid.';
    end 

    
    bmat2 = sqrtm(cov(residuals,1))+ 0.001* rand(k_vars,k_vars);
    b_mat = bmat2;
    ols_b_mat = b_mat;
    for regime = 1: regimes 
        if regime == 1
        sigma(:,:, regime) = b_mat * b_mat.';
        else 
        sigma(:,:, regime) = b_mat *  ... 
                                    eye(k_vars)*...
                                    b_mat.';
        sq_sigma = sqrtm(sigma(:,:,regime));
        sigma(:,:, regime) = sq_sigma* sq_sigma.';
        end
    end
    
    
 
 
    x0 = ones(1, k_vars*k_vars+k_vars*(regimes-1));
    x0(1,1:k_vars*k_vars)= reshape(b_mat,[], k_vars*k_vars);
    
     x0(1,k_vars*k_vars+1:end) = [1,1,1,4];
   x0_initial = x0;
    
   
   %---------------------------------
   % Random initialization 
   %---------------------------------

    index = randi(length(residuals),1,10);
    
    resid_sample = residuals(index,:);
    
   [~,ind]= max(mahal(resid_sample,residuals));
   eucleadin_dist = zeros(length(residuals),2);
  
   eucleadin_dist(:,2)= sum((residuals - residuals(ind,:)).^2,2);
   eucleadin_dist(:,1)= sum(residuals.^2,2);
   regime_2 = []; %zeros(length(residuals),1);
   regime_1 = [];
   for t = 1: length(residuals)
       [~, ind]= min(eucleadin_dist(t,:));
       if ind == 2
           regime_2 = [regime_2 ; residuals(t,:)];
       else
           regime_1 = [regime_1 ; residuals(t,:)];
       end 
   end 
   

   sigma = zeros(k_vars,k_vars, regimes);
   sigma(:,:,1)= cov(regime_1,1);
   sigma(:,:,2)= cov(regime_2,1);
   start_prob = log([0.5,0.5]);
   trans_prob = log([0.7,0.3;0.3,0.7]);
   smth_prob = e_step(residuals,sigma,trans_prob, start_prob,true);
   wls_param = wls_estimate(sigma,smth_prob, delta_yt, zt);
   resid = res_estimate(wls_param,delta_yt, zt);
   
  x0 = [ reshape(sqrtm(sigma(:,:,1)),[], k_vars*k_vars) ,...
       diag(sqrtm(sigma(:,:,2))/ sqrtm(sigma(:,:,1))).'];
   x0_initial = x0;

end

