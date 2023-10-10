function [smth_prob,...
          loglikelihood,...
          sigma,...
          B_matrix,...
          lamdas,...
          params,llf] = em_algorith(data_mat,lags, beta, regimes,maxiter,tolerance)
%EM_ALGORITH Summary of this function goes here
%   Detailed explanation goes here



[delta_yt,zt,resid,start_prob,trans_prob, sigma,x0] = initialize(data_mat, lags,beta, regimes);
    llf = [];
    i=0;
    delta = 0;
    while i < maxiter % && (i < 2 || (delta > tolerance))
        %estep 
        [smth_prob,smth_joint_prob,...
            loglikelihood, start_prob] = e_step(resid,sigma,...
                                                trans_prob,start_prob);
        display(start_prob)
                                                    
        %mstep                                                        
        [trans_prob,sigma,...
            B_matrix,lamdas,... 
            resid, params,x0] = m_step(smth_prob, smth_joint_prob,...
                                    resid,delta_yt,...
                                    zt,x0);

        llf(end+1)= loglikelihood;
        
        if i > 1
            delta = 2 * (llf(end) - llf(end-1)) /abs(llf(end) - llf(end-1));
        end 
        i= i+1;
    end 
end

