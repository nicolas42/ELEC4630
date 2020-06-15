%% make a gray image then edge detect with canny
filename = "car2.jpg";
image=imread(filename);
image = imgaussfilt(image,3);
image = rgb2gray(image);
image = edge(image, "Canny", 0.2);
imshow(image);
%%
image = imfill(image,"holes");

[x, y] = size(image);
image = bwpropfilt(image,"Area",[400 x*y]);

s = regionprops(image, "Area", "BoundingBox");
%centroids = cat(1,s.Area);



figure(1)
imshow(image);


for k = 1 : length(s)
  thisBB = s(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end
