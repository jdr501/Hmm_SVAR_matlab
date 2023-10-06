function [ols_resid] = ols_resid(delta_yt,zt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
shape = size(delta_yt);
obs = shape(1);
k_vars = shape(2);
len_zt = size(zt,2);
denom = 0;
numo=0;
ols_resid = zeros(shape);



    for t = 1:obs
        temp_zt = reshape(zt(t,:),len_zt,1);
        temp_d_yt = reshape(delta_yt(t,:),k_vars,1);
        denom = denom + kron(temp_zt * temp_zt.' , eye(k_vars));
        numo = numo +  kron(temp_zt,eye(k_vars))* temp_d_yt;
    end
    
    ols_param = linsolve(denom,numo);
  
    
    
    for t = 1:obs
        temp_zt = reshape(zt(t,:),len_zt,1);
        temp_d_yt = reshape(delta_yt(t,:),k_vars,1);
        temp_res = (temp_d_yt - ...
                         kron(temp_zt.', eye(k_vars))* ...
                         ols_param);
        ols_resid(t,:) = temp_res.';
    end 
    
    
end

