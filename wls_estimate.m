function [wls_param] = wls_estimate(sigma,smth_prob, delta_yt, zt)
%WLS_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
obs = size(delta_yt,1);
regimes = size(smth_prob,2);
denom = 0;
numo = 0;
for t = 1:obs
    temp_zt = zt(t,:).';
    temp_d_yt = delta_yt(t,:).';
    temp_denom = 0;
    temp_numo = 0;
    for regime = 1:regimes
        temp_denom = temp_denom + exp(smth_prob(t,regime))*kron(temp_zt * temp_zt.' , sigma(:,:,regime));
        temp_numo = temp_numo +  exp(smth_prob(t,regime))*kron(temp_zt,sigma(:,:,regime))* temp_d_yt;
    end
    denom = denom + temp_denom ;
    numo = numo + temp_numo ;
end 

wls_param = linsolve(denom,numo);
end

