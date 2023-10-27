format long
clear
clc
%rng(42)
global ols_param ols_b_mat llf  delta_yt zt resid x0_initial
Tbl = readtable('slowdown.csv');
data_mat = [ Tbl.CPUS*100,Tbl.OIL, Tbl.YUS*100, Tbl.SUS];
data_mat = data_mat(41:end,:);
addpath(genpath('\\cabinet\work$\jdr501\My Documents\MATLAB\MATLAB_SVECM'))
optimizer = 2;


if max(size(gcp)) == 0 % parallel pool needed
    parpool % create the parallel pool
end
diary  friday_27    
  runs=3   
[smth_prob,sigma,...
    lamdas,params,B_matrix, converge,trans_prob] = parallel_draws(runs,data_mat,3,[0,0,0,1],2,100,1e-6 )


level = exp(smth_prob)
diary off