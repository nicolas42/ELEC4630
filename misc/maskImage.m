function [BW,maskedImage] = maskImage(X)
%segmentImage Segment image using auto-generated code from imageSegmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the imageSegmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 21-Apr-2020
%----------------------------------------------------


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
end
