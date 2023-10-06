format long
Tbl = readtable('slowdown.csv');
data_mat = [Tbl.OIL, Tbl.YUS*100, Tbl.CPUS*100, Tbl.SUS];
data_mat = data_mat(41:end,:);

%initialize 
[delta_yt,zt,resid,start_prob,trans_prob, sigma,x0] = initialize(data_mat, 3,[0,0,0,1], 2);

%estep 
[smth_prob,smth_joint_prob,loglikelihood] = e_step(resid,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob);
                                                        
 %mstep                                                        
 [trans_prob,...
          sigma,...
          B_matrix,...
          lamdas,... 
          resid, params] = m_step(smth_prob,...
                                      smth_joint_prob,...
                                      resid,...
                                      delta_yt,zt,x0);