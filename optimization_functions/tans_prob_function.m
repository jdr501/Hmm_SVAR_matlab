function [trans_prob] = tans_prob_function(smth_prob,smth_joint_prob)
%TANS_PROB_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
joint_len = size(smth_joint_prob,2);
joint_sum = zeros(joint_len,1);
regimes = size(smth_prob,2);
smth_sum = zeros(regimes,1);
for i = 1:joint_len 
    joint_sum(i) = logsumexp(smth_joint_prob(:,i));
end 

for regime = 1:regimes
    smth_sum(regime,1)= logsumexp(smth_prob(:,regime));
end
denom = kron(ones(regimes,1),smth_sum);
vec_p =  joint_sum - denom ;
trans_p = reshape(vec_p,regimes,regimes);
trans_prob = trans_p.';
end

