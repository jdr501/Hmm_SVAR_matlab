function [smth_prob,....
          smth_joint_prob, ....
          ll_new, start_prob, ...
          trans_prob, sigma,B_matrix,...
          lamdas, resid,...
          params,x0] = numerical_ini_guess(old_smooth,...
                                           old_smth_joint_prob, ...
                                           old_resid,delta_yt,... 
                                           zt,x0,ll, ...
                                           start_prob)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 opt_fun2 = @(x) num_opt_w_grad(x,old_smooth, old_resid, 1e-6);
 ll_new = -inf;
 iter = 1;
 max_itr = 100;
 x0_old = x0;
 %save_llf = ones(max_itr,(size(x0,2)+1))
while  iter<  2

    itr = 10;
    x0_list = zeros(itr,size(x0,2));
    f_val_list = zeros(itr,1);
    for i = 1:itr
        if i==1
            x0_list(i,:) = x0;
        elseif  i <= 2*(itr-1)/3 
            x0_list(i,:) = x0 - 0.01*randn(size(x0));

        else
            x0_list(i,:) = x0 + 0.01*randn(size(x0));
        end 
        try
            f_val_list(i)= opt_fun2(x0_list(i,:));
        catch
            f_val_list(i) = inf;
        end 
    end 
    [~,index]= min(f_val_list);
    if index ==1 
        disp('origianl x0 results in minimum value')
    end 
    x0=x0_list(index,:);
    
    
  
    
    
    
 [trans_prob, sigma, B_matrix,...
     lamdas, resid, params,x0] = m_step(old_smooth,...
                                      old_smth_joint_prob,...
                                      old_resid,...
                                      delta_yt,zt,x0,2);

  [smth_prob,smth_joint_prob,ll_new, start_prob] = e_step(resid,...
                                        sigma,...
                                        trans_prob,...
                                        start_prob, true);
  iter = iter +1 ;
  disp('this is ll_new:')
  disp(ll_new)
  disp('this is ll_old')
  disp(ll)
  if ll_new < ll
      x0 = x0_old + rand(size(x0));
  end
  if iter == max_itr
      disp('maximum itteration reached, could not find an improving loglikelyhood in this step!') 
   end
 end
end