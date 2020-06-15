clear all
close all
clc

% True if you want to display the results.
% WARNING:If the number of line segments is high, display might take too long.
is_show = true;

%% SPEED TEST

% Randomly generate line segments.
n_line = 20;

XY1 = rand(n_line,4);
XY2 = rand(n_line,4);

out = lineSegmentIntersect(XY1,XY2);

if is_show

    % Show the intersection points.

    figure('Position',[10 100 500 500],'Renderer','zbuffer');
    
    axes_properties.box             = 'on';
    axes_properties.XLim            = [0 1];
    axes_properties.YLim            = [0 1];
    axes_properties.DataAspectRatio = [1 1 1];
    axes_properties.NextPlot        = 'add';
    
    axes(axes_properties,'parent',gcf);
    
    line([XY1(:,1)';XY1(:,3)'],[XY1(:,2)';XY1(:,4)'],'Color','r');
    line([XY2(:,1)';XY2(:,3)'],[XY2(:,2)';XY2(:,4)'],'Color','k');
    
    scatter(out.intMatrixX(:),out.intMatrixY(:),[],'r');

    title('Intersection Points');
    
    % Show the parallel lines.

    figure('Position',[20 90 500 500],'Renderer','zbuffer');
    
    axes(axes_properties,'parent',gcf);

    [I,J] = find(out.parAdjacencyMatrix);
    
    hL1 = line([XY1(I,1)';XY1(I,3)'],[XY1(I,2)';XY1(I,4)'],'Color','r');
    hL2 = line([XY2(J,1)';XY2(J,3)'],[XY2(J,2)';XY2(J,4)'],'Color','k');

    title('Parallel Line Segments');

    % Show the coincident lines.

    figure('Position',[30 80 500 500],'Renderer','zbuffer');
    
    axes(axes_properties,'parent',gcf);

    [I,J] = find(out.coincAdjacencyMatrix);
    
    line([XY1(I,1)';XY1(I,3)'],[XY1(I,2)';XY1(I,4)'],'Color','r');
    line([XY2(J,1)';XY2(J,3)'],[XY2(J,2)';XY2(J,4)'],'Color','k');

    title('Coincident Line Segments');
    
end
