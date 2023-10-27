function [flt_prob,predicted_prob, likelihood] = hamilton_filter(condi_density,...
                                            transition_prob,...
                                            initial_prob)
%HAMILTON Summary of this function goes here
%   note that array epsilon_t-1|t-1 goes from 0 to T observations
% Therefore index 1 of the array corresponds to  time period 0 
% However epsilon_t|t-1 , index of the array corresponds to t   
regimes = size(condi_density, 2);
obs = size(condi_density, 1);
flt_prob= zeros(obs+1,regimes);
predicted_prob = zeros(obs,regimes); % epsilon_t|t-1 , index of the array corresponds to t 
ll = zeros(obs,1) ;

    for t = 0:obs
        index = t+1; % index of flt probe when t = 0 is 1 
        if t==0
            flt_prob(index,:)=  initial_prob; % t=0 -> index = t+1 
        else 
            for regime = 1:regimes
                    predicted_prob(t,regime)= logsumexp( ...
                                                transition_prob(regime,:)+...
                                                flt_prob(index-1,:)  );
            end
            predicted_prob(t,:) = predicted_prob(t,:)- logsumexp(predicted_prob(t,:));

            flt_prob(index,:) = condi_density(t,:) + predicted_prob(t,:);
            ll(t,1)=  logsumexp(flt_prob(index,:));
            flt_prob(index,:) = flt_prob(index,:)- ll(t,1);
           flt_prob(index,:) = flt_prob(index,:)- logsumexp(flt_prob(index,:));
        end 
    end 

likelihood = sum(ll);
end



