
%% Locate one number plate
clear all; clc; close all;
I=imread("car1.jpg"); originalImage = I;
I = imgaussfilt(I,3);
I = rgb2gray(I);
I = edge(I, "Canny");

% fill in closed regions
I = imfill(I,"holes");

% remove objects with area less than 1% of total image size;
[x, y] = size(I); 
I = bwpropfilt(I,"Area",[0.01*x*y, x*y]);

% Show bounding box of predicted number plate
imshow(originalImage);
s = regionprops(I, "BoundingBox");
rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);
