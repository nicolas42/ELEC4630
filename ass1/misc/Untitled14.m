% Find Line Segments and Highlight longest segment

% extract line segments based on hough transform
% https://au.mathworks.com/help/images/ref/houghlines.html

clear; clc; close all;
% Read image into workspace.
% read video frame https://au.mathworks.com/help/matlab/ref/videoreader.read.html
v = VideoReader('Eric2020.mp4');
% I = read(v,1);
index = 0;

for index=1:10:100
% index = 1
I = read(v,index);
I = imcrop(I,[1/4*v.Width 10  1/2*v.Width, 3/4*v.Height]);

I = rgb2gray(I);
% Rotate the image.
rotI = imrotate(I,0,'crop');
%figure, imshow(rotI)
% Create a binary image.
BW = imbinarize(rotI);
% BW = edge(rotI,'canny');

figure; imshow(BW);

end
