function [smth_prob,smth_jnt_prob] = Kim_smoother(marginal_prob,predicted_prob, trans_prob)
%KIM_SMOOTHER Summary of this function goes here
%  Note that epsilon t|T also goes from 0...T hence there are obs+1 in the
%  array and time period t corresponds to t+1 in the array index
obs = size(predicted_prob,1);
regimes = size(predicted_prob,2);
smth_prob =  zeros(obs+1,regimes);
smth_jnt_prob = zeros(obs,regimes*regimes);

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
smth_prob = smth_prob(2:end,:);%getting rid of the zero period observation
end

            