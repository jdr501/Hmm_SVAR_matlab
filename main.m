format long
Tbl = readtable('slowdown.csv');
data_mat = [Tbl.OIL, Tbl.YUS*100, Tbl.CPUS*100, Tbl.SUS];
data_mat = data_mat(41:end,:);
[delta_yt,zt,resid,start_prob,trans_prob] = initialize(data_mat, 3,[0,0,0,1], 2);
