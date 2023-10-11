
sigma1= sigma(:,:,1);
k=4;
u = resid_wls(1,:).';
temp = -0.5*u.'*pinv(sigma1)*u;
(2*pi)^(-k/2)* det(sigma1)^(-0.5)*exp(temp)