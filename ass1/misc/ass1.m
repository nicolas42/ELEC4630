images = cell(1);
for index = 1:1:8

    filename = sprintf("car%d.jpg", index);
    
    image=imread(filename);
    image = imgaussfilt(image,3);
    image = rgb2gray(image);

    image = edge(image, "Canny", 0.1);
    image = imfill(image,"holes");
    s = regionprops(image, "Area", "BoundingBox");
    %centroids = cat(1,s.Area);
    [x, y] = size(image);
    image = bwpropfilt(image,"Area",[200 x*y]);

    %figure(1)
    
    images{index} = image;
end

montage(images)
