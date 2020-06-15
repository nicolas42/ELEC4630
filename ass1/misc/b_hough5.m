clear; clc; close all;
v = VideoReader('Eric2020.mp4');
for index = 1:10:30*5

I = read(v,index);
I = imcrop(I,[1/4*v.Width 0  1/2*v.Width, 3/4*v.Height]);

I = rgb2gray(I);
BW = edge(I);
BW = imdilate(BW, strel('line',5,0));
[x, y] = size(BW); 
BW = bwpropfilt(BW,"Area",[0.01*x*y, x*y]);

imshow(BW)



[H,T,R] = hough(BW,'Theta',[80:89 -90:-80]);
P  = houghpeaks(H,5);
lines1 = houghlines(BW,T,R,P,'FillGap',x);

[H,T,R] = hough(BW,'Theta',[ -10:10]);
P  = houghpeaks(H,5);
lines2 = houghlines(BW,T,R,P);

lines = [lines1 lines2];

imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end



end

% close all;



%%

corners = detectHarrisFeatures(BW);
imshow(BW); hold on;
plot(corners.selectStrongest(5));
