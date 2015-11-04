function [ C ] = myApFun( A,B )
%MYAPFUN Summary of this function goes here
C = A;

%Translate rgb to hsv 
hsvA = rgb2hsv(A);
hsvB = rgb2hsv(B);

%Get the height and width
[h,w,~] = size(A);

%using graythresh function to find the level for A and B based on their
%brightness
level1 = graythresh(uint8(hsvA(:,:,3)));
level2 = graythresh(uint8(hsvB(:,:,3)));

%Segment the A & B and create a mask
segA = im2bw(uint8(A),level1);
segB = im2bw(uint8(B),level2);
segD = segA & segB; 

%Gaussion filter for the binary mask to get a weight matrix
DsegD = double(segD);
GsedD = imgaussfilt(DsegD,7);

%Show the mask and weight matrix
figure();
subplot(1,2,1),imshow(segD),axis image,title('Mask');
subplot(1,2,2),imshow(GsedD),axis image,title('Weight Matrix');

%Linear combination between the the two source images according to the
%correspoing weight
double(A);double(B);
for i=1:h
    for j = 1:w
        for k =1:3
            %Save to the final outputs
            C(i,j,k) = A(i,j,k)*GsedD(i,j) + B(i,j,k)*(1-GsedD(i,j));
        end
    end
end

