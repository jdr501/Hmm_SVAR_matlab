function [smth_prob,sigma,...
    lamdas,params,B_matrix, converge ] = parallel_draws(runs,data_mat,lags,beta,regimes,maxiter,tolerance )
%PARALLEL_DRAWS Summary of this function goes here
%   Detailed explanation goes here
ll_array = zeros(runs,1);
for i = 1:runs
          [temp_smth_prob,...
          loglikelihood,...
          temp_sigma,...
          temp_B_matrix,...
          temp_lamdas,...
          temp_params, ll] = em_algorith(data_mat,lags, beta,...
                                    regimes,maxiter,tolerance);
        ll_array(i)= loglikelihood;                               
        if i == 1
            smth_prob = temp_smth_prob;
            sigma = temp_sigma ;
            lamdas= temp_lamdas;
            params = temp_params; 
            B_matrix= temp_B_matrix; 
            converge = ll; 
        else 
            if ll_array(i-1) <  ll_array(i)
                smth_prob = temp_smth_prob;
                sigma = temp_sigma ;
                lamdas= temp_lamdas;
                params = temp_params; 
                B_matrix= temp_B_matrix; 
                converge = ll;
                
            end 
        end 
end

