function [sigma,...
          B_matrix,...
          lamdas] =  sigma_estimate(residuals_old,smth_prob,x0)
%SIGMA_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
K_var = size(residuals_old,2);
len_x = size(x0);
lb = zeros(len_x);
opt_fun = @(x) num_opt(x,smth_prob, residuals_old);
for i = 1:len_x
    if i <= K_var*K_var
        lb(i) = -Inf;
    else 
        lb(i) = 0.001;
    end
end 
result = fmincon(opt_fun,x0, [],[],[],[],lb,[],[]);
[sigma,...
 B_matrix,...
 lamdas] = result(1);
end

