% demonstrates lowpass, bandpass and highpass filters
close all;
clear all;



I = imread('noisy_image.jpg');
figure(1);
subplot(1,2,1),imagesc(I),colormap(gray),axis image,title('pout image');

J = double(I);

JDFT = fft2(J);

subplot(1,2,2),imagesc(fftshift(log2(abs(JDFT)+1))),colormap(gray),axis image,title('DFT magnitude in log scale');

[h,w] = size(I);
MaskL = zeros(h,w);
MaskL(round(h/2),round(w/2))=1;
MaskL = double(bwdist(MaskL)<=min(h/6,w/6));

figure(2);
subplot(2,3,1), imagesc(MaskL),colormap(gray),axis image,title('Low pass mask');

L = ifft2(JDFT.*fftshift(MaskL));

LI = real(L);
subplot(2,3,4), imagesc(LI),colormap(gray),axis image,title('Low pass image');

MaskB = zeros(h,w);
MaskB(round(h/2),round(w/2))=1;
MaskB = double(bwdist(MaskB)<=min(h/5.45,w/5.45))-MaskL;

subplot(2,3,2), imagesc(MaskB),colormap(gray),axis image,title('Band pass mask');

B = ifft2(JDFT.*fftshift(MaskB));
BI = real(B);
subplot(2,3,5), imagesc(BI),colormap(gray),axis image,title('Band pass image');

MaskH = ones(h,w) - MaskB;
subplot(2,3,3), imagesc(MaskH),colormap(gray),axis image;title('High pass mask');

H = ifft2(JDFT.*fftshift(MaskH));
HI = real(H);
subplot(2,3,6),imagesc(HI),colormap(gray),axis image,title('High pass image');

K = LI+BI+HI;
figure(3);
subplot(1,2,1), imagesc(K),colormap(gray),axis image,title('LI + BI + HI');
subplot(1,2,2), imagesc(J),colormap(gray),axis image,title('Original pout image');