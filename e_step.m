function [smth_prob,smth_joint_prob,loglikelihood, start_prob] = e_step(residuals,...
                                                            sigma,...
                                                            trans_prob,...
                                                            start_prob)
%E_STEP For given parameters this function calculates:
%   loglikelihood
%   smoothed prob
%   smoothed joint prob
%   all estimated values are in log
cond_density = conditional_density(residuals, sigma); % done 

    
% hamilton kim approach to smoothed probabilities 
[marginal, ...
    predicted,...
    loglikelihood]= hamilton_filter(cond_density,trans_prob,start_prob);

[smth_prob,...
    smth_joint_prob,...
    start_prob] = Kim_smoother(marginal, predicted, trans_prob);


%{
[loglikelihood, alpha] = forward(cond_density, trans_prob, start_prob);% done 
beta = backward(cond_density,trans_prob);% done 
[smth_prob,smth_joint_prob] = smoothed_joint(cond_density,...
                                             trans_prob,...
                                             alpha,beta); % done 
start_prob = smth_prob(1,:);
%}

if isinf(cond_density)
disp('inf in density rerun the itteration')
end

end
