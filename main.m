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

%estep 
[smth_prob,smth_joint_prob,loglikelihood, start_prob] = e_step(resid,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob);
  level_smth_prob = exp(smth_prob);                                                    
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





