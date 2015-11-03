clear;close all;
%Read all input images
ImgA = (imread('A.jpg'));
ImgB = (imread('B.jpg'));
ImgC = (imread('C.jpg'));
ImgD = (imread('D.jpg'));

%Read the ground truth images
ImgGT = imread('ex1_result.jpg');

%Fuse A & B 
fuseAB = uint8(wfusimg(ImgA,ImgB,'haar',3,'mean','mean'));

%Fuse B & C
fuseBC = uint8(wfusimg(ImgB,ImgC,'haar',3,'mean','mean'));

%Fuse C & D
fuseCD = uint8(wfusimg(ImgC,ImgD,'haar',3,'mean','mean'));

%Fuse AB & BC
fuseABC= uint8(wfusimg(fuseAB,fuseBC,'haar',3,'mean','mean'));

%Fuse BC & CD
fuseBCD= uint8(wfusimg(fuseBC,fuseCD,'haar',3,'mean','mean'));

%Build my own AP function
Fus_Method = struct('name','userDEF','param','myApFun');

%Fuse the ABC & BCD by custom AP function
final = uint8(wfusimg(fuseABC,fuseBCD,'haar',2,Fus_Method,'mean'));

%This compare with the ground truth 
figure();imshowpair(ImgGT,final,'montage');


