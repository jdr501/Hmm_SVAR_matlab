function [smth_prob,joint_prob_mat_T,start_prob] = Kim_smoother(marginal_prob,predicted_prob, trans_prob)
%KIM_SMOOTHER Summary of this function goes here
%  Note that epsilon t|T also goes from 0...T hence there are obs+1 in the
%  array and time period t corresponds to t+1 in the array index
obs = size(predicted_prob,1);
regimes = size(predicted_prob,2);
smth_prob =  zeros(obs+1,regimes);
%smth_jnt_prob = zeros(obs,regimes*regimes);

for t = obs :-1: 0
    
    if t == obs
       smth_prob(t+1,:)=  marginal_prob(t+1,:);
    else
        right = zeros(1,regimes);
        temp = zeros(1,regimes);
        for regime = 1:regimes
            right(1,regime)= logsumexp(trans_prob(regime,:)+...
                                                  marginal_prob(t+1,:));
        end
        divide = smth_prob(t+2,:)- right;
        for regime = 1:regimes 
            temp(1,regime)= logsumexp(trans_prob(:,regime).' + divide); 
            % switching to selected regime 'trans_prob(:,regime).'' same as
            % transpose of the tranasition matrix 
        end
        smth_prob(t+1,:)= temp + marginal_prob(t+1,:);
    end 
end 

%{
% joint probability of states 
for t = 0:obs-1
    left = zeros(1,regimes);
    temp = zeros(regimes,regimes);
    for regime = 1:regimes
        left(1,regime)= logsumexp(trans_prob(regime,:)+...
                                                  marginal_prob(t+1,:));
        % here i decends to column vector from a raw vector by taking
        % tanspose of marginal_prob
        temp(:,regime)= left(1,regime)+ marginal_prob(t+1,:).';
    end
    smth_jnt_prob(t+1,:)= ( reshape(trans_prob.',regime*regime,1)+ ...
                        reshape(temp, regime*regime,1)).';
        
end 
%}
% joint prob according to: 
%https://www.r-bloggers.com/2022/02/kim-1994-smoother-algorithm-in-regime-switching-model-using-r-code/

trans_prob_T = trans_prob.';
joint_prob_mat_T = zeros(regimes,regimes,obs);
for t = 0:obs-1
    for regime_j = 1:regimes
        for regime_k = 1: regimes
            joint_prob_mat_T(regime_j,regime_k,t+1) = smth_prob(t+2,regime_k)+...
                                                   marginal_prob(t+1,regime_j)+ ...
                                                   trans_prob_T(regime_j,regime_k) - ...
                                                   predicted_prob(t+1,regime_k);
        end 
    end

end 

start_prob = smth_prob(1,:);
smth_prob = smth_prob(2:end,:);%getting rid of the zero period observation



end

            