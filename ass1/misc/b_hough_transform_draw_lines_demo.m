% Find Line Segments and Highlight longest segment

% extract line segments based on hough transform
% https://au.mathworks.com/help/images/ref/houghlines.html

clear;
% Read image into workspace.
% read video frame https://au.mathworks.com/help/matlab/ref/videoreader.read.html
v = VideoReader('Eric2020.mp4');
% I = read(v,1);
I = readFrame(v);
I = imcrop(I,[1/4*v.Width 10  1/2*v.Width, 3/4*v.Height]);

I = rgb2gray(I);
% Rotate the image.
rotI = imrotate(I,0,'crop');
figure
imshow(rotI)
% Create a binary image.
BW = edge(rotI,'canny');

% Get Vertical and Horizontal Hough Lines
[H,T,R] = hough(BW, 'Theta',[85:89 -90:-85]);
P  = houghpeaks(H,5,'threshold',ceil(0.5*max(H(:))));
hlines = houghlines(BW,T,R,P, 'FillGap', 0.5*width);

[H,T,R] = hough(BW, 'Theta',[-5:5]);
P  = houghpeaks(H,1,'threshold',ceil(0.5*max(H(:))));
vlines = houghlines(BW,T,R,P, 'FillGap', 0.5*width);

lines = [hlines vlines];


figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% Highlight the longest line segment by coloring it cyan.
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
% Copyright 2015 The MathWorks, Inc.
