function [log_likelihood, alpha] = forward(cond_density,... 
                                            trans_prob, ...
                                            start_prob)
                             
%Farward Algorithm to estimate joint prob. of st,observed  
%   Note that transition prob. notation is different from matrix notation: 
%   In P_ij i is initial state j is proceeding state 
%    _         _
%   | P_11 P_21 |
%   | P_12 P_22 |
%    -         -
%   make sure transition probabilities are in log
%   imput initial prob.: inital guess of the prob 
%   Here I use foreward algorithm to find the joint prob. of observed and
%   latent var. P(st,observed 1:t) and use it to find p(st|observed_1:t)

shp_dens = size(cond_density);
obs = shp_dens(1);
regimes = shp_dens(2);

alpha = zeros(shp_dens); % this is joint porb  I.e. P(st,observed 1:t)


    for t = 1:obs

       for regime = 1:regimes
        if t== 1
          % note that trans_prob(regime,:) this is transitioning to the
          % regime from all other states ex: first raw represnt
          % transitioning to state 1 from all other states 
                                   
          alpha(t, regime) = logsumexp( start_prob(regime) + ...
                                       trans_prob(regime,:) + ... 
                                       cond_density(t, regime) ) ;
        else
          alpha(t, regime) = logsumexp( alpha(t-1,regime) + ...
                                       trans_prob(regime,:) + ... 
                                       cond_density(t, regime)) ;
        end 
       end
       
    end 
    log_likelihood = logsumexp(alpha(obs,:)); 
end


