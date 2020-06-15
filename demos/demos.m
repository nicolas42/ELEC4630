% Make sure to add all the directories to the path by right clicking on
% them

%% reset
clear; close all; clc;

%% Detect Corners

I = checkerboard;
% Find the corners.

corners = detectHarrisFeatures(I);
% apparently harris features are minimum eigen features because this is an
% equivalent function
% corners = detectMinEigenFeatures(I);
% Display the results.

imshow(I); hold on;
plot(corners.selectStrongest(50));

%% compare edges
RGB = imread('ass2/morgan.jpg');
BW = rgb2gray(RGB);
figure; imshow(edge(BW,'canny',0.1)); title('canny');
figure; imshow(edge(BW,'sobel')); title('sobel');
figure; imshow(edge(BW,'prewitt')); title('prewitt');
figure; imshow(edge(BW,'horizontal')); title('horizontal');
figure; imshow(edge(BW,'vertical')); title('vertical');

%% Blur
RGB = imread('ass2/morgan.jpg');
figure;
imshow(imgaussfilt(RGB,2));

%% canny edge detection with filtering followed by hough lines
RGB = imread('ass2/morgan.jpg');
BW = rgb2gray(RGB);
E = edge(BW,'canny',0.1);
E = bwpropfilt(E,"MajorAxisLength",100);

figure; imshow(E); title('canny filtered');

[H,T,R] = hough(E);
P  = houghpeaks(H,20);
lines = houghlines(E,T,R,P); % ,'FillGap',5,'MinLength',7

% Plot Lines
imshow(E), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

end

%% draw hough graph
RGB = imread('gantrycrane.png');
I  = rgb2gray(RGB);
% Extract edges.

BW = edge(I,'canny');
% Calculate Hough transform.

[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
% Display the original image and the Hough matrix.

figure;
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

%% draw lines
RGB = imread('gantrycrane.png');
I = rgb2gray(RGB);
BW = edge(I,'canny',0.1);
figure; imshow(BW);

[H,T,R] = hough(BW);
P  = houghpeaks(H,10);
lines = houghlines(BW,T,R,P);


% Plot Lines
figure;
imshow(RGB), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end


%% Locate one number plate
I=imread("ass1/numberplates2020/car1.jpg"); originalImage = I;
I = imgaussfilt(I,3);
I = rgb2gray(I);
I = edge(I, "Canny");

% fill in closed regions
I = imfill(I,"holes");

% remove objects with area less than 1% of total image size;
[x, y] = size(I); 
I = bwpropfilt(I,"Area",[0.01*x*y, x*y]);

% Show bounding box of predicted number plate
figure;
imshow(originalImage);
s = regionprops(I, "BoundingBox");
rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);


%% Note: is this a weird if then syntax?
a = []
a(isempty(a)) = NaN;
% if a is empty make it NaN

%% print table of object properties
regionprops('table',BW)
