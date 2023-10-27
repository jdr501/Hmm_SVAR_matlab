function [sigma,...
          B_matrix,...
          lamdas, x0_new] =  sigma_estimate(resid,smth_prob,x0, optimizer)
%SIGMA_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
x02 = x0.';
K_var = size(resid,2);
len_x = size(x02);
lb = zeros(len_x);
ub = ones(len_x)*inf;
regimes = size(smth_prob,2);

opt_fun = @(x) num_opt_w_grad(x,smth_prob, resid, 1e-2);

for i = 1:len_x(1)
    if i <= K_var*K_var
        lb(i,1) = -inf;
    else 
        lb(i,1) = 0.01;
    end
end 
not_psd = true;
while not_psd
ini_sigma = reconstitute_sigma(x0,K_var,regimes);
chol_decomp =[];
wt= 0.6;
for regime = 1:regimes 
    [t,num]=cholcov(ini_sigma(:,:,regime));
   chol_decomp = [chol_decomp,num ];
end
if  any(chol_decomp) ==1
    disp('initial values not valid try different start values')
    disp(x0)
    disp('-----------------------------------')
    x0 = (1-wt)*x0 + wt*randn(size(x0));
    x0((K_var*K_var+1):end) = ones(1,K_var);

else
    disp('valid initial values')
    disp(x0)
    disp('value at the initial value')
    disp(opt_fun(x0))
    disp('-----------------------------------')
    not_psd = false;
end 
end 


if optimizer ==1 

% c based BFGS optimizer-----------------
% Ask for very high accuracy
opts    = struct( 'x0', x02 );
opts.printEvery     = 20;
opts.m  = 5;
opts.pgtol      = 1e-24;
opts.factr      = 1e-12;
opts.m =20;
opts.maxIts = 5000;
% The {f,g} is another way to call it
[result,f,info] = lbfgsb( opt_fun , lb, ub, opts );
display(info)

x0_new = result.';
%-------------------------------------------------------

else
% fmincon optimizer-----------------
options = optimoptions('fmincon',...
                       'Algorithm','sqp',...
                       'Display','iter',...
                       'ConstraintTolerance',1e-6, ...
                       'StepTolerance',1e-6,...
                       'UseParallel',true);
     
options.SpecifyObjectiveGradient = true;

options.MaxFunctionEvaluations = 50000;
options.MaxIterations = 15000;
options.OptimalityTolerance = 1e-6;
%options = optimoptions(@simulannealbnd, 'Display', 'iter')
%result = simulannealbnd(opt_fun,x0,lb,ub,options)
result = fmincon(opt_fun,x0, [],[],[],[],lb,[],[], options)
x0_new = result;
%-------------------------------------------------------
end 

[sigma,...
 B_matrix,...
 lamdas] =  reconstitute_sigma(result,K_var,regimes);
end

