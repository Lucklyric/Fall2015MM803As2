close; clear;
I = imread('noisy_image.jpg');
[result,mask] = BandPassFun(1/6,1/5.45,I);
[result2,mask2] = Butter_Lowpass(1/8,1/7.9,result);
figure();
subplot(1,3,1),imagesc(I),colormap(gray),axis image,title('Original image');
subplot(1,3,2),imagesc(mask2),colormap(gray),axis image,title('Mask image');
subplot(1,3,3),imagesc(result),colormap(gray),axis image,title('Result image');

figure();
imshowpair(result,result2,'montage');