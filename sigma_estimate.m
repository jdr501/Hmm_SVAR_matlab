function [sigma,...
          B_matrix,...
          lamdas, x0_new] =  sigma_estimate(resid,smth_prob,x0)
%SIGMA_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
x02 = x0.';
K_var = size(resid,2);
len_x = size(x02);
lb = zeros(len_x);
ub = ones(len_x)*inf;
regimes = size(smth_prob,2);

opt_fun = @(x) num_opt_w_grad(x,smth_prob, resid, 1e-6);

for i = 1:len_x(1)
    if i <= K_var*K_var
        lb(i,1) = -inf;
    else 
        lb(i,1) = 0.01;
    end
end 

if isnan(opt_fun(x02)) 
    disp('initial values not valid try different start values')
    disp(smth_prob)
    j =1 ;
    while j <10 && isnan(opt_fun(x02))
        x02 = x02+ eps*randn(size(x02));
        j = j+1;
    end
    
else
    disp('valid initial values')
end

opts    = struct( 'x0', x02 );
opts.printEvery     = 20;
opts.m  = 5;



% Ask for very high accuracy
opts.pgtol      = 1e-24;
opts.factr      = 1e-12;
opts.m =20;
opts.maxIts = 5000;
% The {f,g} is another way to call it
[result,f,info] = lbfgsb( opt_fun , lb, ub, opts );
display(info)

x0_new = result.';

[sigma,...
 B_matrix,...
 lamdas] =  reconstitute_sigma(result,K_var,regimes);
end

