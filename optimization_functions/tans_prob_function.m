function [trans_prob] = tans_prob_function(smth_prob,smth_joint_prob)
%TANS_PROB_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
% note that the smooth joint prob we are getting are the transposed ones

obs = size(smth_prob,1);
regimes = size(smth_prob,2);
smth_sum = zeros(1, regimes);
joint_sum_T = zeros(regimes, regimes); 

for regime_j = 1: regimes
    for regime_k = 1: regimes 
       joint_sum_T(regime_j,regime_k) = logsumexp(...
           reshape(smth_joint_prob(regime_j,regime_k,:),obs,[]));
    end
end
 
for regime = 1:regimes
    smth_sum(1,regime)= logsumexp(smth_prob(:,regime));
end

for regime_j = 1: regimes
    for regime_k = 1: regimes 
       joint_sum_T(regime_j,regime_k) = joint_sum_T(regime_j,regime_k) - smth_sum(1,regime_j);
    end
end 
trans_prob = joint_sum_T.';

end

