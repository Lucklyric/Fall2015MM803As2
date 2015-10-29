function [ C ] = myApFun( A,B )
%MYAPFUN Summary of this function goes here
%   Detailed explanation goes here
C=A;
D = logical(triu(ones(500,752)));
for i=1:3
MatA = A(:,:,i); MatB=B(:,:,i);
MaxD = abs(MatA) >= abs(MatB);
MaxC = MatA*MaxD+MatB*~MaxD;
MinD = abs(MatA) <= abs(MatB);
MinC = MatA*MinD+MatB*~MinD;
C(:,:,i) = MaxC*D+MinC*D;
end
end

