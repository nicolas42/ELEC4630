%% interesting looking
% https://au.mathworks.com/matlabcentral/answers/183142-fill-a-circle-enclosed-by-it-s-circumference-of-type-double-with-white

%%
close all; clc; clear all;
%%
figure; hold on; 
for index = 1:16
    filename = sprintf("images/MRI1_%02.0f.png", index);
    original = imread(filename);
    X = original;
    disp(filename);

    % Create empty mask.
    BW = false(size(X,1),size(X,2));
    % Draw ROIs
    xPos = [159.4615 159.4615 390.8462 390.8462];
    yPos = [232.5000 472.5000 472.5000 232.5000];
    m = size(BW, 1);
    n = size(BW, 2);
    addedRegion = poly2mask(xPos, yPos, m, n);
    BW = BW | addedRegion;
    % Create masked image.
    maskedImage = X;
    maskedImage(~BW) = 0;
    X = maskedImage;
    
    % Graph cut
    foregroundInd = 196919 ;
          
    backgroundInd = [119888 122719 139421 219341 266143 271029];
    L = superpixels(X,2206);
    BW = lazysnapping(X,L,foregroundInd,backgroundInd);

    % Active contour
    iterations = 100;
    BW = activecontour(X, BW, iterations, 'Chan-Vese');

    % Close mask with disk
    radius = 50;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imclose(BW, se);

    E = edge(BW);
    rp = regionprops(E, "Area");
    original(E) = 255;
    
    areas(index) = rp.Area;
    imshow(original);
end

figure;
plot([1:length(areas)]', areas'); 

title('Left Ventricle Inner Cross-sectional Area over time'); 
ylabel('Cross-sectional area (pixels)'); xlabel('Time (frames)');


%%
close all; clc; clear all;
%%
    filename = sprintf("images/MRI1_%02.0f.png", 1);
    original = imread(filename);
%%    
figure; hold on; 
for index = 1:5
    filename = sprintf("images/MRI1_%02.0f.png", index);
    original = imread(filename);
    X = original;
    disp(filename);
    
    % Graph cut
    foregroundInd = [196181 196902 ];
    backgroundInd = [28164 28884 42415 43135 382223 382224 388138 ];
    L = superpixels(X,2206);
    BW = lazysnapping(X,L,foregroundInd,backgroundInd);

    % Active contour
    iterations = 100;
    BW = activecontour(X, BW, iterations, 'Chan-Vese');

    % Close mask with disk
    radius = 50;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imclose(BW, se);

    % Create masked image.
    maskedImage = X;
    maskedImage(~BW) = 0;
    
    E = edge(BW);
    E = bwpropfilt(E,"Eccentricity", 1);

    rp = regionprops(E, "Area");

%     disp(rp.Area);
    original(E) = 255;
    
    areas(index) = rp.Area;
    figure;
    imshow(original);
end

figure;
plot([1:length(areas)]', areas'); 
title('Left Ventricle Inner Cross-sectional Area over time'); 
ylabel('Cross-sectional area (pixels)'); xlabel('Time (frames)');


