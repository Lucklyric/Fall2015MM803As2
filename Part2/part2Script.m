close; clear;
%load noisy image
I = imread('noisy_image.jpg');

[h,w] = size(I);

DI = double(I);
IDFT = fft2(DI);
subplot(1,3,1),imagesc(DI),colormap(gray),axis image,title('Denoising image');

%load original image
J = imread('cameraman.tif');
DJ = double(J);
JDFT = fft2(DJ);

Mask = IDFT-JDFT;

MDFT = fft2(Mask);

Gap = (fftshift(log2(abs(IDFT)+1))-fftshift(log2(abs(JDFT)+1)));
Cel = (max(Gap(:))*0.65);
Gap = Gap>Cel;
MaskL = ones(h,w);
[a,b] = ind2sub(size(MaskL),(find(Gap)));
MaskL(a(13),b(13)) = 0;
MaskL(a(16),b(16)) = 0;
MaskL(a(19),b(19)) = 0;
MaskL(a(22),b(22)) = 0;
% MaskL(a(16),b(16)) = 0;
%  for i=20:21
%      for j=20:21
%          MaskL(a(i),b(j)) = 0;
%      end
%  end

% for i=1:length(a)
%     for j=1:length(b)
%         dist=sqrt((i-round(h/2))^2 + (j-round(w/2))^2);
%         if(dist > 0.2*w) 
%             MaskL(a(i),b(j)) = 0;
%         end
%     end
% end



H = ifft2(IDFT.*(fftshift(MaskL)));
HI = real(H);
subplot(1,3,2),imagesc(HI),colormap(gray),axis image,title('Orignial image');
subplot(1,3,3),imagesc((fftshift(log2(abs(IDFT)+1)))),colormap(gray),axis image,title('Orignial image');
