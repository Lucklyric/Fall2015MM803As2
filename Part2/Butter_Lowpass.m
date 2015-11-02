function [ result,mask ] = Butter_Lowpass( low,high,I )
%BUTTER_LOWPASS Summary of this function goes here
%   Detailed explanation goes here

%BANDPASSFUN Summary of this function goes here
%   Detailed explanation goes here
J = double(I);
JDFT = fft2(J);
[h,w] = size(I);
MaskL = zeros(h,w);

d0=(min(h*(low),w*(low)))^2;				%Cutoff Frequency
n=2; 
for i=1:h
    for j=1:w
        dist=(i-round(h/2))^2 + (j-round(w/2))^2;
        MaskL(i,j)= ( 1 + (dist/d0)^(2*n))^(-1);
    end
end
MaskB = zeros(h,w);
d2=(min(h*(high),w*(high)))^2;				%Cutoff Frequency
for i=1:h
    for j=1:w
        dist=(i-round(h/2))^2 + (j-round(w/2))^2;
        MaskB(i,j)= ( 1 + (dist/d2)^(2*n))^(-1);
    end
end
MaskB = MaskB-MaskL;
mask= MaskB;
B = ifft2(JDFT.*fftshift(1-mask));
result = imsharpen(real(B));

end

