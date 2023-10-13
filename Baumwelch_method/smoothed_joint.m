function [gamma,epsilon] = smoothed_joint(cond_density, ...
                                          trans_prob,...
                                          alpha,...
                                          beta)
%SMOOTHED_JOINT Summary of this function goes here
%   Detailed explanation goes here
shp_alppha = size(alpha);
obs = shp_alppha(1);
regimes = shp_alppha(2);
gamma = zeros(shp_alppha);
epsilon = zeros(obs, regimes,regimes);
temp = zeros(regimes,1);
    
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
                          regime_t2) = alpha(t,regime_t)+ ... 
                                        trans_prob(regime_t2, regime_t)+ ...
                                        cond_density(t,regime_t2)+ ...
                                        beta(t+1,regime_t2);
                                       % note that transition prob matrix
                                       % notation represent the transpose
                                       % of matrix notation that is why we
                                       % have trans_prob(regime_t2, regime_t)
           end

       end 
       
       % normalizing over both regimes 
       tmp = reshape(epsilon(t,:,:),[],regimes*regimes); 
       epsilon(t,:,:) = epsilon(t,:,:) -  logsumexp(tmp);
    end
   
end
