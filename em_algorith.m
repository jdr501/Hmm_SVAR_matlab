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
    
    for i = 1: maxiter  
        if i==1
            intial_step = true ;
        else 
            intial_step = false;   
        end 
        
         [smth_prob,smth_joint_prob,loglikelihood, start_prob] = e_step(resid,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob, intial_step);
                                                  
          %mstep  
          if i ==1
              x0=  x0 + 0.1*x0.*(1+randn(size(x0)));
          else 
              x0 = x0 + 0.5*x0_old.*(1+randn(size(x0)));
          end 
          x0_old = x0;
 
          [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          resid, params,x0] = m_step(smth_prob,...
                                      smth_joint_prob,...
                                      resid,...
                                      delta_yt,zt,x0);
                               
                       
           disp(trans_prob)                       

           llf = [llf,loglikelihood]
           
           
        
            if i >= 2
                delta =  abs(llf(end) - llf(end-1))/ abs(llf(end-1))
                if delta<tolerance
                    break 
                end
            end 

    
    end 
end

