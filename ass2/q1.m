%% reset
clear; clc; close all;

%% find circles on morgan
I = imread('morgan.jpg');
A = imgaussfilt(I,2);
radiusRange = [40 70];
[centers,radii,metric] = imfindcircles(A, radiusRange);

figure;
imshow(I);
viscircles(centers, radii,'EdgeColor','b');

% Warning: You just called IMFINDCIRCLES with a large radius range. Large radius ranges reduce algorithm accuracy and increase computational time. For
% high accuracy, relatively small radius range should be used. A good rule of thumb is to choose the radius range such that Rmax < 3*Rmin and (Rmax -
% Rmin) < 100. If you have a large radius range, say [20 100], consider breaking it up into multiple sets and call IMFINDCIRCLES for each set separately,
% like this:


%% find circles and lines on morgan image

% in imfindcircle
% Although the radii are reported as being 56 if the radius range is
% constrained any further is ceases to find one of the circles

RGB = imread('morgan.jpg');
I = rgb2gray(RGB);
BW = edge(I, 'prewitt', 'horizontal');
% prewitt seems slightly better than sobel

% keep only the 100 longest edge objects
[x, y] = size(BW); 
BW = bwpropfilt(BW,"MajorAxisLength",100);
% figure; imshow(BW);

% get lines, makes no difference if I constrain the angle
[H,T,R] = hough(BW);
P  = houghpeaks(H,10);
lines = houghlines(BW,T,R,P);

% get the lines which are closest to the left and right hand side of the
% image
Lxy = [lines(1).point1; lines(1).point2];
Rxy = [lines(1).point1; lines(1).point2];
Ri = 1; Li = 1;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   
   if xy(1,1) < Lxy(1,1)
       Lxy = xy;
       Li = k;
   end

   if xy(2,1) > Rxy(2,1)
       Rxy = xy;
       Ri = k;
   end
   
end

figure; imshow(RGB); hold on;

% Find and plot circles
radiusRange = [40 70];
[centers,radii,metric] = imfindcircles(RGB, radiusRange);
viscircles(centers, radii,'EdgeColor','b');

% Plot Lines
newlines = [ lines(Li) lines(Ri) ];
max_len = 0;
for k = 1:length(newlines)
   xy = [newlines(k).point1; newlines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end



