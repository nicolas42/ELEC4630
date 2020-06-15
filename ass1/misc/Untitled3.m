%%
images = cell(1);
for index = 1:1:8
filename = sprintf("car%d.jpg", index);  
%% Locate one number plate
I=imread(filename); originalImage = I;
% I = imgaussfilt(I,3);
% I = rgb2gray(I);
% I = edge(I, "Canny");
% I = imbinarize(I);


redChannel = I(:,:,1); % Red channel
greenChannel = I(:,:,2); % Green channel
blueChannel = I(:,:,3); % Blue channel

allBlack = zeros(size(I, 1), size(I, 2), 'uint8');
% Create color versions of the individual color channels.
% Recombine the individual color channels to create the original RGB image again.
recombinedRGBImage = cat(3, redChannel, greenChannel, allBlack);

imshow(recombinedRGBImage);


% read the original image
I = imread(filename);
% call createMask function to get the mask and the filtered image
[BW,maskedRGBImage] = createMask(I);

% plot the original image, mask and filtered image all in one figure
% subplot(1,3,1);imshow(I);title('Original Image');
% subplot(1,3,2);imshow(BW);title('Mask');
% subplot(1,3,3);imshow(maskedRGBImage);title('Filtered Image');

images{index} = maskedRGBImage;

% images = {
% I(:,:,1); % Red channel
% I(:,:,2); % Green channel
% I(:,:,3); % Blue channel
% }

% fill in closed regions
%I = imfill(I,"holes");
% images{index} = I;

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

end

figure()
montage(images)

