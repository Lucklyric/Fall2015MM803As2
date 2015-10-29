function [ C ] = myApFun( A,B )
%MYAPFUN Summary of this function goes here
%   Detailed explanation goes here
C=A;
ImgSize = size(A);
D = logical(triu(ones(ImgSize(1),ImgSize(2))));
for i=1:3
MatA = A(:,:,i); MatB = B(:,:,i);
MaxD = abs(MatA) >= abs(MatB);
CMax = MatA;
CMax(MaxD) = MatA(MaxD);
CMax(~MaxD) = MatB(~MaxD);

MinD = abs(MatA) <= abs(MatB);
CMin = MatA;
CMin(MinD) = MatA(MinD);
CMin(~MinD) = MatB(~MinD);

CMix = MatA;
CMix(D) = CMin(D);
CMix(~D) = CMax(~D);
C(:,:,i) = CMix;
end
end

