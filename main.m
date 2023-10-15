format long
clear
clc
global ols_param ols_b_mat
Tbl = readtable('slowdown.csv');
data_mat = [ Tbl.CPUS*100,Tbl.OIL, Tbl.YUS*100, Tbl.SUS];
data_mat = data_mat(41:end,:);

%em_algorith(data_mat, 3,[0,0,0,1], 2,3, 1e-6)
%initialize 
[delta_yt,zt,resid,start_prob,trans_prob, sigma,x0] = initialize(data_mat, 3,[0,0,0,1], 2);
sigma

cond_dens = conditional_density(resid,sigma);
[marginal, predicted,ll]= hamilton_filter(cond_dens,trans_prob,log(ones(1,2)/2));
[smth_prob,smth_jnt_prob, start_prob] = Kim_smoother(marginal, predicted, trans_prob);
tans_prob_function(smth_prob,smth_jnt_prob)




%estep 
[smth_prob,smth_joint_prob,loglikelihood, start_prob] = e_step(resid,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob);
                                                    
 %mstep    
 len = size(x0,2);
 for i = 1:len
   
   x0(1,i)= x0(1,i)+0.01*randn(1,1);  
 end
 sigma_old = sigma;
 [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          resid, params] = m_step(smth_prob,...
                                      smth_joint_prob,...
                                      resid,...
                                      delta_yt,zt,x0);


[delta_yt,zt,resid,start_prob,trans_prob, sigma,x0] = initialize(data_mat, 3,[0,0,0,1], 2);
cond_dens = conditional_density(resid,sigma);
[log_likelihood, alpha]= forward(cond_dens, trans_prob,start_prob);
[beta] =backward(cond_dens,trans_prob);
[gamma,epsilon] = smoothed_joint(cond_dens, ...
                                          trans_prob,...
                                          alpha,...
                                          beta);
                                      
 smooth_1 = exp(gamma);
 plot(smooth_1,'DisplayName','smooth_1')
 exp(tans_prob_estimate(gamma,epsilon))
 
 
  [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          resid, params] = m_step(smooth_1,...
                                      epsilon,...
                                      resid,...
                                      delta_yt,zt,x0);

