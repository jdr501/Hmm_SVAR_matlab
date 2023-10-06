function [sigma_regimes,B_matrix,lamda] = reconstitute_sigma(x,K_var,regimes)
%RECONSTITUTE_SIGMA Summary of this function goes here
%   Detailed explanation goes here
sigma_regimes = zeros(K_var,K_var,regimes); 
B_matrix = reshape(x(1:K_var*K_var),K_var, K_var);

starting = K_var*K_var +1;
lamda = zeros(K_var,K_var,regimes);
    for regime = 1:regimes
        
        if regime == 1
            lamda(:,:,regime) = eye(K_var);
       
        else
            
            ending = starting + K_var-1;

            lamda(:,:,regime) =  eye(K_var).*...
                                reshape(x(starting:ending),K_var,1 )   ;
            starting = ending +1 ;
        end 
        sigma_regimes(:,:, regime) = B_matrix * ...
                                        lamda(:,:,regime)* ...
                                        B_matrix.';
        
    end
end

