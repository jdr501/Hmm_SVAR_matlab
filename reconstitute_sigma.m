function [sigma_regimes,B_matrix,lamda] = reconstitute_sigma(x,K_var,regimes)
%RECONSTITUTE_SIGMA Summary of this function goes here
%   Detailed explanation goes here
sigma_regimes = zeros(K_var,K_var,regimes,'uint64'); 
B_matrix = reshape(x(1:K_var*K_var),K_var, K_var);

starting = K_var*K_var +1;
lamda = zeros(K_var,K_var,regimes, 'uint64');
    for regime = 1:regimes
        ending = starting + K_var;
        if regime == 1
            lamda(:,:,regime) = eye(K_var);
        else
            lamda(:,:,regime) = eye(K_var)* ...
                                reshape(x(starting:ending),K_var,1 );
        end 
        sigma_regimes(:,:, regime) = B_matrix * ...
                                        lamda(:,:,regime)* ...
                                        B_matrix.';
        starting = ending +1 ;
    end
end

