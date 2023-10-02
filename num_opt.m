function [value] = num_opt(x,smth_prob, resid)
%Function for numerical optimization
%   Detailed explanation goes here
shp_resid = size(resid);
obs = shp_resid(1);
K_var = shp_resid(2);
regimes = size(smth_prob,2);

    for regime = 1: regimes 
        density_array(t,regime)= mvnpdf(residuals_matrix,...
                                        mean_zero, ...
                                        sigma_regimes(:,:,regime)); 
    end 
end

