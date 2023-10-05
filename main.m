Tbl = readtable('slowdown.csv');
data_mat = [Tbl.OIL, Tbl.YUS*100, Tbl.CPUS*100, Tbl.SUS];
%[delta_yt,zt] = data_gen(data_mat,4,[1,1,1,1]);
[delta_yt,zt,resid,start_prob,trans_prob] = initialize(data_mat, 4,[1,1,1,1], 2);