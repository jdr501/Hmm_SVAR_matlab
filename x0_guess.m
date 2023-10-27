function [x0] = x0_guess(x0)
itr = 100;
x0_list = zeros(itr,size(x0,2));
f_val_list = zeros(itr,1);
for i = 1:itr
if i==1
    x0_list(i,:) = x0;
elseif  i <= 2*(itr-1)/3 
    x0_list(i,:) = x0 -0.1*randn(size(x0));

else
    x0_list(i,:) = x0 + 0.1*randn(size(x0));
end 
f_val_list(i)= opt_fun2(x0_list(i,:));
end 
[f_val,index]= min(f_val_list);
x0=x0_list(index,:);
end

