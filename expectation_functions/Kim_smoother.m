function [smth_prob,jnt_prob,start_prob] = Kim_smoother(flt_prob,predicted_prob, trans_prob)
%KIM_SMOOTHER Summary of this function goes here
%  Note that epsilon t|t also goes from 0...T hence 
%  time period t corresponds to t+1 in the array index
obs = size(predicted_prob,1);
regimes = size(predicted_prob,2);
smth_prob =  zeros(obs+1,regimes);

%https://www.r-bloggers.com/2022/02/kim-1994-smoother-algorithm-in-regime-switching-model-using-r-code/
 
jnt_prob = zeros(regimes,regimes,obs); % notation is jntprob(j,k,t)
jnt_prob_t0 = zeros(regimes,regimes,1); % for initial prob 
smth_prob = zeros(obs,regimes);
start_prob = zeros(1,regimes);
smth_prob(obs,:) = flt_prob(obs+1,:); % because we have 0 observation 
disp('this is flterd prob')
disp(exp(flt_prob))
disp('-------------------')
disp('this is predicted prob')
disp(exp(predicted_prob))
disp('-------------------')
for t = obs-1:-1:1
    for regime_j = 1:regimes
        for regime_k = 1:regimes 
        jnt_prob(regime_j,regime_k,t)= smth_prob(t+1,regime_k)+...
                                     flt_prob(t+1,regime_j)+ ... %bcs flt prob has 0 obs
                                     trans_prob(regime_k,regime_j)- ...
                                     predicted_prob(t,regime_k);
        end 
    end
    for regime_j = 1:regimes 
        smth_prob(t,regime_j)= logsumexp(jnt_prob(regime_j,:,t));
    end 
end 





% initial prob estimation 
    for regime_j = 1:regimes
        for regime_k = 1:regimes 
        jnt_prob_t0(regime_j,regime_k,1)= smth_prob(1,regime_k)+...
                                     flt_prob(1,regime_j)+ ... %bcs flt prob has 0 obs
                                     trans_prob(regime_k,regime_j)- ...
                                     predicted_prob(1,regime_k);
        end 
    end
    
    for regime_j = 1:regimes 
        start_prob(1,regime_j)= logsumexp(jnt_prob_t0(regime_j,:,t));
    end 
    start_prob(1,:) = start_prob(1,:) - logsumexp(start_prob(1,:));
    
 for t = 1:size(smth_prob,1)
     smth_prob(t,:) = smth_prob(t,:) - logsumexp(smth_prob(t,:));

end    
    
    
end















            