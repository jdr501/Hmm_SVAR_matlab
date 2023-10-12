function [marginal_prob,predicted_prob, likelihood] = hamilton_filter(condi_density,...
                                            transition_prob,...
                                            initial_prob)
%HAMILTON Summary of this function goes here
%   note that array epsilon_t-1|t-1 goes from 0 to T observations
% Therefore index 1 of the array corresponds to  time period 0 
% However epsilon_t|t-1 , index of the array corresponds to t   
regimes = size(condi_density, 2);
obs = size(condi_density, 1);
marginal_prob= zeros(obs+1,regimes);
predicted_prob = zeros(obs,regimes); % epsilon_t|t-1 , index of the array corresponds to t 
ll = zeros(obs,1) ;

    for t = 0:obs
        if t==0
            marginal_prob(t+1,:)=  initial_prob; % t=0 -> index = t+1 
        else 
            marginal_prob(t+1,:) = condi_density(t,:) + predicted_prob(t,:);
            ll(t,1)=  logsumexp(marginal_prob(t+1,:));
            marginal_prob(t+1,:) = marginal_prob(t+1,:)- ll(t,1);
        
        
            for regime = 1:regimes
                predicted_prob(t,regime)= logsumexp( ...
                                                transition_prob(regime,:)+...
                                                  marginal_prob(t,:)  );
            end
        end
     
    end 

likelihood = sum(ll);
end



