function [sigma,...
          B_matrix,...
          lamdas, result] =  sigma_estimate(residuals_old,smth_prob,x0)
%SIGMA_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
K_var = size(residuals_old,2);
len_x = size(x0);
lb = zeros(len_x);
regimes = size(smth_prob,2);
opt_fun = @(x) num_opt(x,smth_prob, residuals_old);
for i = 1:len_x(2)
    if i <= K_var*K_var
        lb(1,i) = -Inf;
    else 
        lb(1,i) = 0.001;
    end
end 

options = optimoptions('fmincon',...
    'Algorithm','sqp','Display','final','ConstraintTolerance',1e-6, ...
   'StepTolerance',1.0000e-6);

options.MaxFunctionEvaluations = 50000;
options.MaxIterations = 15000;

 result = fmincon(opt_fun,x0, [],[],[],[],lb,[],[], options)
[sigma,...
 B_matrix,...
 lamdas] =  reconstitute_sigma(result,K_var,regimes);
end

