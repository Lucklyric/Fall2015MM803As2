close; clear;
%Load noisy image
I = imread('noisy_image.jpg');

%Get the size of the image
[h,w] = size(I);
DI = double(I);
IDFT = fft2(DI);


%Goad original image
J = imread('cameraman.tif');
DJ = double(J);
JDFT = fft2(DJ);

%Show the Fourier specturm of original and noised images
figure(),
subplot(1,2,1),imagesc(fftshift(log2(abs(JDFT)+1))),colormap(gray),axis image,title('Original Image');
subplot(1,2,2),imagesc(fftshift(log2(abs(IDFT)+1))),colormap(gray),axis image,title('Noised Image');

%Get the Diff matrix and extract the value that exceed the 0.65 of max
%value
Diff = (fftshift(log2(abs(IDFT)+1))-fftshift(log2(abs(JDFT)+1)));
Cel = (max(Diff(:))*0.65);
Diff = Diff>Cel;
Mask = ones(h,w);
[a,b] = ind2sub(size(Mask),(find(Diff)));

%Manually test part to extract the exact frequence of the noise
%  idx = 1;  %set from 1 to length of a to see if the noise has been
%  removed
%  for i=idx:34
%      for j=idx:34
%          MaskL(a(i),b(j)) = 0;
%      end
%  end

%After the manually test I get the exactlly nosie entry of the noise
%frequence and let them to 0 in the Maks matrix
Mask(a(13),b(13)) = 0;
Mask(a(16),b(16)) = 0;
Mask(a(19),b(19)) = 0;
Mask(a(22),b(22)) = 0;

%ffshit with the final Mask to the noised FT
H = ifft2(IDFT.*(fftshift(Mask)));
HI = real(H);

%Show the final result
figure(),
subplot(1,2,1),imagesc(DI),colormap(gray),axis image,title('Noised image');
subplot(1,2,2),imagesc(HI),colormap(gray),axis image,title('My Denoising Image');