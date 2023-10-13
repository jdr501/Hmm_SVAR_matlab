function [trans_prob] = tans_prob_estimate(smth_prob,smth_joint_prob)
%TANS_PROB_ESTIMATE Summary of this function goes here
%   Detailed explanation goes here
shp_smth_prob = size(smth_prob);
obs = shp_smth_prob(1);
regimes = shp_smth_prob(2);
tmp_smoothed = zeros(regimes,1);
tmp_smth_joint = zeros(regimes,regimes);
trans_prob = zeros(regimes,regimes);
    for regime_1 = 1: regimes
        tmp_smoothed(regime_1)= logsumexp(smth_prob(1:obs-1, regime_1));
        for regime_2 = 1: regimes
            tmp_smth_joint(regime_1,...
                           regime_2) = logsumexp(...
                                                smth_joint_prob(:,...
                                                regime_1,...
                                                regime_2));
            trans_prob(regime_1,...
                       regime_2) = tmp_smth_joint(regime_1,...
                                                  regime_2)- ...
                                                  tmp_smoothed(regime_1);
        end 
    end

end

