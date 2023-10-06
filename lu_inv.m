function [A_inv] = lu_inv(A)
%LU_INV Summary of this function goes here
%   Detailed explanation goes here
  [L,U] = lu(A);
  A_inv = inv(L)* inv(U);
end

