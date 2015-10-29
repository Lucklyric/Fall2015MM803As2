clear;
ImgA = imread('A.jpg');
ImgB = imread('B.jpg');
ImgC = imread('C.jpg');
ImgD = imread('D.jpg');

ImgGT = imread('ex1_result.jpg');

fuseAB= uint8(wfusimg(ImgA,ImgB,'haar',2,'mean','mean'));

fuseBC=uint8(wfusimg(ImgB,ImgC,'haar',2,'mean','mean'));
fuseCD = uint8(wfusimg(ImgC,ImgD,'haar',2,'mean','mean'));

% fuseABC= uint8(wfusimg(fuseAB,fuseBC,'haar',2,'mean','mean'));
% fuseBCD= uint8(wfusimg(fuseBC,fuseCD,'haar',2,'mean','mean'));
% fuseABCD= uint8(wfusimg(fuseABC,fuseBCD,'haar',2,'mean','mean'));
%Fus_Method = struct('name','userDEF','param','myApFun');

finalA = uint8(wfusimg(fuseAB,fuseCD,'haar',2,'mean','mean'));
%finalB = uint8(wfusimg(fuseAB,fuseCD,'haar',1,'min','mean'));
%finalAB = uint8(wfusimg(finalA,finalB,'haar',1,'mean','mean'));
%finalAB = uint8(wfusimg(fuseAB,fuseCD,'haar',1,'mean','mean'));

figure();imshow(fuseAB);
figure();imshow(fuseCD);
figure();
imshowpair(ImgGT,finalA,'montage');


