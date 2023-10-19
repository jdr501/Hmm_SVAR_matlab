format long
clear
clc
global ols_param ols_b_mat llf
Tbl = readtable('slowdown.csv');
data_mat = [ Tbl.CPUS*100,Tbl.OIL, Tbl.YUS*100, Tbl.SUS];
data_mat = data_mat(41:end,:);
addpath(genpath('/Users/danusha/Documents/Hmm_SVAR_matlab'))
addpath(genpath('~/L-BFGS-B-C/Matlab'))
[smth_prob,...
          loglikelihood,...
          sigma,...
          B_matrix,...
          lamdas,...
          params,llf] = em_algorith(data_mat, 3,[0,0,0,1], 2,100,1e-3)

level = exp(smth_prob)
%estep 
[smth_prob,smth_joint_prob,loglikelihood, start_prob] = e_step(resid,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob);
                                                    
 %mstep    

 
  [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          resid, params,x0] = m_step(smth_prob,...
                                      smth_joint_prob,...
                                      resid,...
                                      delta_yt,zt,x0);

