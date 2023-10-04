function [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          residuals, params] = m_step(smth_prob,...
                                      smth_joint_prob,...
                                      residuals_old,...
                                      delta_yt,zt)
%M_STEP Summary of this function goes here
%   Detailed explanation goes here
trans_prob = tans_prob_estimate(smth_prob,smth_joint_prob);
[sigma,...
 B_matrix,...
 lamdas] =  sigma_estimate(residuals_old,smth_prob);
params = wls_estimate(sigma_regimes,smth_prob,delta_yt,zt);
residuals = res_estimate(params,delta_yt,zt);
end
