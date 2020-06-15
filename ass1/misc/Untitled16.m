
clear; clc; close all;
v = VideoReader('Eric2020.mp4');
gblock = read(v,1);

I = imcrop(gblock,[1/4*v.Width 0  1/2*v.Width, 3/4*v.Height]);

%Convert the image to Grayscale
I=rgb2gray(I);
figure(1),imshow(I);title('Grayscale Image');pause;
x= I;
%Generate Histogram
imhist(x); pause;
%Perform Median Filtering
x = medfilt2(x);
%Convert Grayscale image to Binary
threshold=98;%assign a threshold value
x(x<threshold)=0;
x(x>=threshold)=1; 
x=logical(x);%convert image to binary compared to threshold
%Perform Median Filtering
im2=medfilt2(x);
figure(1),imshow(im2);title('filtered image');pause;
%Edge Detection
a=edge(im2,'sobel');
imshow(a); title('Edge Detection');pause
%Horizontal Edge Detection
BW=edge(im2,'sobel',(graythresh(I)*0.3),'horizontal');
imshow(BW)
pause;
%Hough Transform
[H,theta,rho] = hough(BW);
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)
% Finding the Hough peaks (number of peaks is set to 10)
P = houghpeaks(H,10,'threshold',ceil(0.2*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');
pause;
%Fill the gaps of Edges and set the Minimum length of a line
lines = houghlines(BW,theta,rho,P,'FillGap',170,'MinLength',350);
figure, imshow(gblock), hold on
max_len = 0;
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
% Plot beginnings and ends of lines
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','green');
end
pause;