[delta_yt,zt,resid,start_prob,trans_prob, sigma,x0] = initialize(data_mat, 3,[0,0,0,1], 2);

b= sqrtm(cov(resid(1:20,:),1)) ; 
sigma_2 = cov(resid(20:end,:),1);



lam = diag(sigma_2)./(diag(b)).^2
lam.'


lam = eye(4).*lam.'

sigma_2-b*lam*b.'