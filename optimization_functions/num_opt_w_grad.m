function [ll,g] = num_opt_w_grad(x,smth_prob, resid, h)
%NUM_OPT_W_GRAD Summary of this function goes here
%   Detailed explanation goes here
g = zeros(size(x));

ll = num_opt(x,smth_prob, resid);
if nargin < 3
    h = 1e-6;
end
for i = 1:size(x,1)
    x_temp_plus = x;
    x_temp_minus = x;
    x_temp_plus(i) = x_temp_plus(i)+h;
    x_temp_minus(i) =  x_temp_minus(i) -h ;
    g(i) =   (num_opt(x_temp_plus,... 
                        smth_prob,...
                        resid) - num_opt(x_temp_minus,... 
                                            smth_prob,...
                                            resid) )/2*h;
end 
end

