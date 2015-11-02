function [ result,mask ] = BandPassFun( low,high,I )
%BANDPASSFUN Summary of this function goes here
%   Detailed explanation goes here
J = double(I);
JDFT = fft2(J);
[h,w] = size(I);
MaskL = zeros(h,w);
				
MaskL(round(h/2),round(w/2))=1;
MaskL = double(bwdist(MaskL)<=min(h*(low),w*(low)));
% d0=(min(h*(low),w*(low)))^2;				%Cutoff Frequency
% n=5; 
% for i=1:h
%     for j=1:w
%         dist=(i-round(h/2))^2 + (j-round(w/2))^2;
%         MaskL(i,j)= ( 1 + (dist/d0)^(2*n))^(-1);
%     end
% end
  MaskB = zeros(h,w);
% d2=(min(h*(high),w*(high)))^2;				%Cutoff Frequency
% for i=1:h
%     for j=1:w
%         dist=(i-round(h/2))^2 + (j-round(w/2))^2;
%         MaskB(i,j)= ( 1 + (dist/d2)^(2*n))^(-1);
%     end
% end
% MaskB = MaskB-MaskL;

MaskB(round(h/2),round(w/2))=1;
MaskB = double(bwdist(MaskB)<=min(h*(high),w*(high)))-MaskL;


mask = ~MaskB;
B = ifft2(JDFT.*fftshift(mask));
result = imsharpen(real(B));

end

