function [smth_prob,sigma,...
    lamdas,params,B_matrix, converge, trans_prob ] = parallel_draws(runs,data_mat,lags,beta,regimes,maxiter,tolerance )
%PARALLEL_DRAWS Summary of this function goes here
%   Detailed explanation goes here
ll_array = []
for i = 1:runs
    try 
          [temp_smth_prob,...
          loglikelihood,...
          temp_sigma,...
          temp_B_matrix,...
          temp_lamdas,...
          temp_params, ll, temp_trans_prob] = em_algorith(data_mat,lags, beta,...
                                    regimes,maxiter,tolerance);
        ll_array= [ll_array, loglikelihood];                               
        if i == 1
            smth_prob = temp_smth_prob;
            sigma = temp_sigma ;
            lamdas= temp_lamdas;
            params = temp_params; 
            B_matrix= temp_B_matrix; 
            converge = ll; 
            trans_prob = temp_trans_prob;
        else 
            if ll_array(end-1) <  ll_array(end)
                smth_prob = temp_smth_prob;
                sigma = temp_sigma ;
                lamdas= temp_lamdas;
                params = temp_params; 
                B_matrix= temp_B_matrix; 
                converge = ll;
                trans_prob = temp_trans_prob;
                
            end 
        end
    disp('====================')
    disp('iteration converged!')
    disp('====================')
    catch 
    disp('====================')
    disp('iteration crashed!')
    disp('====================')
    end 
end

