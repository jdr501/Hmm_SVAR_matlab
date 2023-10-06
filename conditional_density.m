function [density_array] = conditional_density(residuals_matrix, ...
                                               sigma_regimes)
%CONDITIONAL_DENSITY 
% This function estimates the conditional density for given cov. matrix and
% observed residuals.
% residuals_matrix: residuals from fitted model 
% Note the this matrix is different from pthon version
% time is represented by raws and different variabkles in columns
% EX: obs_matrix_(t,K_var)
% this is eta_t on the paper p(observed|state) 
% Return log of conditional densities

shp_obs   = size(residuals_matrix);
obs = shp_obs(1);
k_var = shp_obs(2);
shp_sigma = size(sigma_regimes);
k_regimes = shp_sigma(3);
density_array = zeros(obs,k_regimes);
mean_zero = zeros(k_var,1);
    for t = 1:obs
        for regime = 1: k_regimes
            density_array(t,regime)= mvnpdf(residuals_matrix(t,:).',...
                                            mean_zero, ...
                                            sigma_regimes(:,:,regime));
        end 
    end 
density_array = log(density_array);
end


