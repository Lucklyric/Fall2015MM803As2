function [ C ] = myApFun( A,B )
%MYAPFUN Summary of this function goes here
%   Detailed explanation goes here
C = A;
ImgSize = size(A);
D = logical(triu(ones(ImgSize(1),ImgSize(2))));
level1 = graythresh(uint8(A));
level2 = graythresh(uint8(B));
segA = im2bw(uint8(A),level1);
segB = im2bw(uint8(B),level2);
segD = segA & segB; 
figure(),imshow(segD);
double(A);double(B);
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
CMix(segD) = MatA(segD).*0.9 + MatB(segD).*0.1;
CMix(~segD) = MatA(~segD).*0.9 + MatB(~segD).*0.1;
C(:,:,i) = CMix;
end
end

