clear; clc; close all;
v = VideoReader('Eric2020.mp4');

X=[]; Y=[];
for index = 1:30:30*39

    I = read(v,index);
    % Crop Image
    I = imcrop(I,[1/4*v.Width 10  1/2*v.Width, 3/4*v.Height]);
    [height, width] = size(I);
    I = rgb2gray(I);
    % Get Edges
    BW = edge(I,'canny',0.1);
    imshow(BW);
    
    
    % Get Vertical and Horizontal Hough Lines
    [H,T,R] = hough(BW, 'Theta',[85:89 -90:-85]);
    P  = houghpeaks(H,5,'threshold',ceil(0.5*max(H(:))));
    hlines = houghlines(BW,T,R,P, 'FillGap', 0.5*width);

    [H,T,R] = hough(BW, 'Theta',[-5:5]);
    P  = houghpeaks(H,1,'threshold',ceil(0.5*max(H(:))));
    vlines = houghlines(BW,T,R,P, 'FillGap', 0.5*width);

    lines = [hlines vlines];

    % Find topmost horizontal line
    hline = hlines(1);
    for i=1:length(hlines)
        a = hlines(i).point1(2) + hlines(i).point2(2);
        b = hline.point1(2) + hline.point2(2);
        if a < b
            hline = hlines(i);
        end
    end

    % Find intersection point of horizontal and vertical line
    a1 = hline.point1';
    a2 = hline.point2';
    b1 = vlines(1).point1';
    b2 = vlines(1).point2';
    % a1 + (a2-a1)t1 = b1 + (b2-b1)t2
    A = [a1-a2, b2-b1];
    B = a1-b1;
    % Ax = B
    t = A\B;
    x = a1 + (a2-a1)*t(1);
    x_intersect = x(1);
    y_intersect = x(2);

    
    
    
    X = cat(1,X, x_intersect);
    Y = cat(1,Y, y_intersect);


    % Plot Lines
    imshow(I), hold on
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

    end
    plot(x_intersect,y_intersect,'r*')
    
%     pause
end

figure();
plot([1:1:length(X)]',X);
% xlabel('Frame Number/10')
% ylabel('X Position of Cropped Image');
title('Pantograph and Power Line Intersection Point');

