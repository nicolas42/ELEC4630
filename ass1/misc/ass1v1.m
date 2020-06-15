image=imread("car1.jpg");
% imshow(image);

image = imgaussfilt(image,3);
image = rgb2gray(image);

image = edge(image, "Canny", 0.1);
image = imfill(image,"holes");



s=regionprops(image,"Area");
centroids = cat(1,s.Area);
image = bwpropfilt(image,"Area",[300 600*800]);
%figure(1)


imshow(image);






% imopen(image,se) se shape   closes off small segments
% imclose()  two shapes combining when you don't want them to
% imopen(image, shape)  two shapes when you want one shape
% bwpropfilter "Bounding Box"

