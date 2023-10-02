function [gamma,epsilon] = smoothed_joint(cond_density, ...
                                          trans_prob,...
                                          alpha,...
                                          beta)
%SMOOTHED_JOINT Summary of this function goes here
%   Detailed explanation goes here
shp_alppha = size(alpha);
obs = shp_alppha(1);
regimes = shp_alppha(2);
gamma = zeros(shp_alppha,'uint64');
epsilon = zeros(obs, regimes,regimes,'uint64');
temp = zeros(regimes,'uint64');
    
    % smoothed prob.
    for t = 1:obs
       for regime = 1: regimes
           temp(regime) = alpha(t,regime)+ beta(t,regime);
       end
       gamma(t,:) =  alpha(t,:)+ beta(t,:) ...
                        - logsumexp(temp); % this is smth prob
    end 
      
    %smoothed joint prob.p(z_t,z_t+1| all obs.)
    for t = 1: obs-1
       for regime_t = 1: regimes
           for regime_t2 = 1: regimes
               epsilon(t, regime_t,...
                          regimes_t2) = alpha(t,regime_t)+ ...
                                        trans_prob(regime_t, regime_t2)+ ...
                                        cond_density(t,regime_t2)+ ...
                                        beta(t+1,regimes_t2);
                                       
           end
           epsilon(t,regime_t,:) = ...
                                    epsilon(t,regime_t,:) - ...
                                    logsumexp(epsilon(t,regime_t,:));
       end 
       
    end
   
end
