%%
clear;
% read video frame https://au.mathworks.com/help/matlab/ref/videoreader.read.html
v = VideoReader('Eric2020.mp4');
RGB = read(v,1);


I  = rgb2gray(RGB);
% Extract edges.

BW = edge(I,'canny');
% Calculate Hough transform.

[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
% Display the original image and the Hough matrix.

subplot(2,1,1);
imshow(RGB);
title('gantrycrane.png');
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);




%%
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
