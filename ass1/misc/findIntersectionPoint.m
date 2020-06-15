function [x_pos y_pos] = findIntersectionPoint(line1, line2)

x1 = line1.point1(1);
y1 = line1.point1(2);
x2 = line1.point2(1);
y2 = line1.point2(2);

% y = ax+b  y = cx+d

a = (y2 - y1) / (x2 - x1);
b = y1 - a*x1;

x1 = line2.point1(1);
y1 = line2.point1(2);
x2 = line2.point2(1);
y2 = line2.point2(2);

% y = ax+b  y = cx+d

c = (y2 - y1) / (x2 - x1);
d = y1 - c*x1;

x_pos = (d - b) / (a - c);
y_pos = a*x1 + b;

%  hold on
%  plot(x_pos,y_pos,'ro')
 
end
