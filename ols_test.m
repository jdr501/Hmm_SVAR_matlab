x =[1 2 3 4 5 6 7 8 9 ]
K_var =2
B_matrix = reshape(x(1:K_var*K_var),K_var, K_var)
regimes=2

x0 = ones(1, K_var*K_var+K_var*(regimes-1))
x0(1,1:K_var*K_var)= reshape(B_matrix,[], K_var*K_var)