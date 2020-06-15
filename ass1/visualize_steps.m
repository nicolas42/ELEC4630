%% Step by step visualization
filename = "car7.jpg"

image=imread(filename);
blurred = imgaussfilt(image,3);
BW = rgb2gray(blurred);

edges = edge(BW, "Canny", 0.1);
filled = imfill(edges,"holes");

montage({image, blurred, BW, edges, filled});

%s=regionprops(image,"Area");
%centroids = cat(1,s.Area);
%image = bwpropfilt(image,"Area",[300 600*800]);

%figure(1)
%imshow(image)