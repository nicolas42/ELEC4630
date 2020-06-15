images = cell(1);
for index = 1:1:8
    % make a gray image then edge detect with canny
    filename = sprintf("car%d.jpg", index);    
    image=imread(filename);
    image = imgaussfilt(image,3);
    image = rgb2gray(image);
    image = edge(image, "Canny", 0.2);
    image = imfill(image,"holes");
    images{index} = image;
end

montage(images)
