function [m c] = calculateLineParameters(XY1,XY2)

% x1 = lines.point1(1);
% y1 = lines.point1(2);
% 
% x2 = lines.point2(1);
% y2 = lines.point2(2);

% x1 = XY1(1);
% y1 = XY1(2);
% 
% x2 = XY2(1);
% y2 = XY2(2);

m = (y2 - y1) / (x2 - x1);
c = y1 - a*x1;

end

