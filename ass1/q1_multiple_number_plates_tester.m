%% image 6

clear all; clc; close all;
I=imread("car1.jpg"); originalImage = I;
I = rgb2gray(I);
I = edge(I);
se = strel('line', 10,1); % Structuring element for dilation
I = imdilate(I, se); % Dilating the image
I = imfill(I,"holes");
stats = regionprops('table',I,'Centroid','Area','MajorAxisLength','MinorAxisLength')
imshow(I);

%%
% I = bwareaopen(I, 100);

I = imfill(I,"holes");
% stats = regionprops('table',I,'Centroid','Area','MajorAxisLength','MinorAxisLength')
SE = strel("disk",2)
I = imerode(I,SE);
I = imdilate(I,SE);
I = bwpropfilt(I,"Area",1);

% Show bounding box of predicted number plate
imshow(originalImage);
s = regionprops(I, "BoundingBox");
rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);

%% image 6

clear all; clc; close all;
I=imread("car6.jpg"); originalImage = I;
I = rgb2gray(I);
I = edge(I);

% I = bwareaopen(I, 100);

I = imfill(I,"holes");
I = bwpropfilt(I,"Area",1);

% stats = regionprops('table',I,'Centroid','Area','MajorAxisLength','MinorAxisLength')
SE = strel("disk",2)
I = imerode(I,SE);
I = imdilate(I,SE);

% Show bounding box of predicted number plate
imshow(originalImage);
s = regionprops(I, "BoundingBox");
rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);


%%
close all; clc; clear all;
images = cell(1);
for index = 1
    filename = sprintf("car%d.jpg", index);  

    I=imread(filename); originalImage = I;
    I = rgb2gray(I);
    I = edge(I);

    % fill in closed regions
    I = imfill(I,"holes");

    images{index} = I;
%     % remove objects with area less than 5% of total image size;
%     [x, y] = size(I); 
%     I = bwpropfilt(I,"Area",[0.05*x*y, x*y]);

%     % Show bounding box of predicted number plate
%     imshow(originalImage);
%     s = regionprops(I, "BoundingBox");
%     rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);    


end
montage(images)




%%
% figure()
% imshow(I);

% remove objects with area less than 1% of total image size;
% [x, y] = size(I); 
% I = bwpropfilt(I,"Area",[0.05*x*y, x*y]);
% 
% % Show bounding box of predicted number plate
% figure()
% imshow(originalImage);
% s = regionprops(I, "BoundingBox");
% rectangle("Position", s.BoundingBox,'EdgeColor','r', 'LineWidth',3);

I = imdilate(I, strel('disk',1));
% [x, y] = size(BW); 
% BW = bwpropfilt(BW,"Area",[0.01*x*y, x*y]);


%% Show all original images

close all; clc; clear all;
images = cell(1)
for index = 1:1:8
    filename = sprintf("car%d.jpg", index);  
    I=imread(filename); originalImage = I;
    images{index} = I;

end
montage(images)