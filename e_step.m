function [smth_prob,smth_joint_prob,loglikelihood] = e_step(residuals,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob)
%E_STEP For given parameters this function calculates:
%   loglikelihood
%   smoothed prob
%   smoothed joint prob
%   all estimated values are in log
cond_density = conditional_density(residuals, sigma); 
[loglikelihood, alpha] = forward(cond_density, trans_prob, start_prob);
beta = backward(cond_density,trans_prob);
[smth_prob,smth_joint_prob] = smoothed_joint(alpha,beta); 
end

