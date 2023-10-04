function [ll] = num_opt(x,smth_prob, resid)
%Function for numerical optimization
%   Detailed explanation goes here
shp_resid = size(resid);
obs = shp_resid(1);
K_var = shp_resid(2);
regimes = size(smth_prob,2);
wght_dens = zeros(obs,regimes, 'unit64');
reconstituted_param = reconstitute_sigma(x,K_var,regimes);
sigma_regimes = reconstituted_param(1); % this takes the sigma arrray 

    for regime = 1: regimes
        for t = 1:obs
            wght_dens(t,regime)= exp(smth_prob(t, regime)) *... % taking exp to levels
                                 log(mvnpdf(resid(t,:),...
                                            mean_zero, ...
                                            sigma_regimes(:,:,regime))); 
        end 
    end
    ll =0;
    for t = 1:obs
       ll= ll + sum(wght_dens(t,:));
    end
    ll = -ll;
end

