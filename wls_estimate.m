function [wls_param] = wls_estimate(sigma,smth_prob, delta_yt, zt)
%WLS_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
obs = size(smth_prob, 1);
regimes = size(smth_prob, 2);

t_sum_dnom = 0;
r_sum_dnom = 0;
t_sum_numo = 0;
r_sum_numo = 0;
smth_prob_level = exp(smth_prob);

    for regime = 1:regimes 
    
        for t = 1:obs
            t_sum_dnom = t_sum_dnom + ...
                         smth_prob_level(t,regime)* (zt(t,:).' * zt(t,:));
        end
  
        r_sum_dnom = r_sum_dnom +... 
                     kron(t_sum_dnom, pinv(sigma(:,:,regime))); 
    end 
  
    for t = 1:obs 
        for regime = 1:regimes
           r_sum_numo = r_sum_numo +...
                        kron(...
                             smth_prob_level(t,regime)* zt(t,:).',...
                             pinv(sigma(:,:,regime)));
        end
        t_sum_numo = t_sum_numo + r_sum_numo * delta_yt(t,:).';
    end
    
    wls_param = linsolve(r_sum_dnom,t_sum_numo); % returns column vector wls_params 
    
end

