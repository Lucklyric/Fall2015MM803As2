clear;close all;
ImgA = (imread('A.jpg'));
ImgB = (imread('B.jpg'));
ImgC = (imread('C.jpg'));
ImgD = (imread('D.jpg'));

ImgGT = imread('ex1_result.jpg');

fuseAB = uint8(wfusimg(ImgA,ImgB,'haar',3,'mean','mean'));

fuseBC = uint8(wfusimg(ImgB,ImgC,'haar',3,'mean','mean'));
fuseCD = uint8(wfusimg(ImgC,ImgD,'haar',3,'mean','mean'));

fuseABC= uint8(wfusimg(fuseAB,fuseBC,'haar',3,'mean','mean'));
fuseBCD= uint8(wfusimg(fuseBC,fuseCD,'haar',3,'mean','mean'));
% fuseABCD= uint8(wfusimg(fuseABC,fuseBCD,'haar',2,'mean','mean'));
Fus_Method = struct('name','userDEF','param','myApFun');
%fuseAB = uint8(wfusimg(ImgA,ImgB,'haar',1,Fus_Method,'mean'));

%finalA = uint8(wfusimg(fuseAB,fuseCD,'haar',1,'max','mean'));
finalB = uint8(wfusimg(fuseABC,fuseBCD,'haar',1,Fus_Method,'min'));
%finalAB = uint8(wfusimg(finalA,finalB,'haar',1,'mean','mean'));
%finalAB = uint8(wfusimg(fuseAB,fuseCD,'haar',1,'mean','mean'));

figure();imshow(fuseABC);
level = graythresh(fuseABC);
segABC = im2bw(fuseABC,level);
figure();imshow(fuseBCD);
level = graythresh(fuseBCD);
segBCD = im2bw(fuseBCD,level);

%figure();imshow(fuseAB);
figure();imshowpair(ImgGT,finalB,'montage');


