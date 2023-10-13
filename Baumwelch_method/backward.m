function [beta] =backward(cond_density,trans_prob)
%Backward Summary of this function goes here
%   Detailed explanation goes here
shp_dens = size(cond_density);
obs = shp_dens(1);
regimes = shp_dens(2);
beta =zeros(shp_dens);

for t = obs:-1:1
    for regime = 1:regimes 
        if t == regime
           beta(t,regime) = 1;
        else
           beta(t,regime) = logsumexp(beta(t+1,:)+ ...
                                      trans_prob(:,regime)+...
                                      cond_density(t,:));
        end 
    end 
end

