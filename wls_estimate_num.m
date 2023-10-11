function [ll] = wls_estimate_num(params,...
                                 sigma,...
                                 smth_prob, ...
                                 delta_yt, zt)
%WLS_ESTIMATE_NUM Summary of this function goes here
%   Detailed explanation goes here
obs = size(delta_yt,1);
k_vars = size(delta_yt,2);
regimes = size(smth_prob,2);
ll =0;
t_sum = 0 ;
  for regime = 1:regimes
      for t = 1:obs
        u = delta_yt(t,:).' - kron(zt(t,:), eye(k_vars))*params 
        t_sum = t_sum -0.5*...
                          log(smth_prob(t,regime))*...
                          u.'* pinv(sigma(:,:,regime))* u ; 
      end 
      ll = ll+ t_sum;
  end 
  %ll= -ll;
end

