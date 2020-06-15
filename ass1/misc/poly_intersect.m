    %line1
x1  = [hlines(i).point1(1), hlines(i).point2(1)];
y1  = [hlines(i).point1(2), hlines(i).point2(2)];
%line2
x2  = [vlines(1).point1(1), vlines(1).point2(1)];
y2  = [vlines(1).point1(2), vlines(1).point2(2)];
%fit linear polynomial
p1 = polyfit(x1,y1,1);
p2 = polyfit(x2,y2,1);
%calculate intersection
x_intersect = fzero(@(x) polyval(p1-p2,x),3);
y_intersect = polyval(p1,x_intersect);
% line(x1,y1);
% hold on;
% line(x2,y2);
% plot(x_intersect,y_intersect,'r*')