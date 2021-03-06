% For more detail lower the step variable


% Initialize
clear all; clc; close all;

% Get projection matrices
P_Mat = get_projection_matrices();

% Make masks
fprintf("\nMaking masks. Camera: ");
for i = 1:36
    fprintf("%d ", i);

    f = sprintf('dino/dino%02d.jpg',i-1);
    im = imread(f);
    % get parts of the image that have more red than blue
    BW = im(:,:,1) > im(:,:,3);
    BW = imclearborder(BW);
    masks{i} = BW;
    
    % View masks
    montage({im BW});
end



% Create a rectangular block surrounding the dinosaur
% and remove voxels whose 2D projection lies outside of the dinosaur

% step variable
% lower = more detail, slower
% higher = less detail, faster
step = 2;

% Make the 3D space
xlim = -180:step:90;
ylim = -80:step:70;
zlim = 20:step:460;

[X, Y, Z] = meshgrid(xlim,ylim,zlim);
Voxels = [ 
    reshape(X, [1, numel(X)]); 
    reshape(Y, [1, numel(X)]); 
    reshape(Z, [1, numel(X)]); 
    ones(1, numel(X));
];


fprintf("\nRemoving voxels. Camera: ");
for i = 1:36
    fprintf("%d ", i);
    BW = masks{i};
    [h,w] = size(BW);

    
    % Get pixels which correspond to the voxels
    P = P_Mat(:,:,i);
    p = P * Voxels;
    xy = p(1:2,:) ./ p(3,:);
    x = xy(1,:);
    y = xy(2,:);

    % Remove voxel if the corresponding pixel is outside the mask
    inside = find( 1 <= x & x <= w & 1 <= y & y <= h );
    ind = sub2ind( [h,w], round(y(inside)), round(x(inside)) );
    outside = inside(BW(ind) == 0);
    Voxels(4,outside) = 0;
    
end  

V = reshape(Voxels(4,:), size(X));

% Flip vertical
sizeZ = size(Z,3);
for i=1:floor(sizeZ/2)
    bottom = V(:,:,i);
    top = V(:,:,sizeZ+1-i);
    
    V(:,:,i) = top;
    V(:,:,sizeZ+1-i) = bottom;
end
    
% View
figure('Position',[100 100 600 700]);
isosurface( X, Y, Z, V, 0.5 )
set(gca,'DataAspectRatio',[1 1 1]);


% Explanation of Method
% Make a box of Voxels with each position having a value of 1. 
% For each camera 
% project all of the voxels onto a 2D plane of pixels so one voxel corresponds to 
% one pixel. This uses the projection matrices, one for each camera vantage
% point.  
% For each pixel, find out if it lies outside of the dinosaur in the appropriate image.
% Remove voxels whose corresponding pixel is outside of the dinosaur.

% I don't know what magic was conjured to get the projection matrices
% More detail: https://blogs.mathworks.com/loren/2009/12/16/carving-a-dinosaur/

% pixels = (projection matrix) * Voxels
 


%% Segmentation
% The dinosaur is red and the background is blue

f = sprintf('dino/dino%02d.jpg',1);
im = imread(f);

[R,G,B] = imsplit(im);
figure; montage({R G B});
figure; montage({imbinarize(R) imbinarize(B)})

%% More View Settings
figure('Position',[100 100 600 700]);

ptch = patch( isosurface( X, Y, Z, V, 0.5 ) );
isonormals( X, Y, Z, V, ptch )
set( ptch, 'FaceColor', 'g', 'EdgeColor', 'none' );

set(gca,'DataAspectRatio',[1 1 1]);

view(-140,22)
lighting( 'gouraud' )
camlight( 'right' )
axis( 'tight' )

set(gca,'Position',[-0.2 0 1.4 0.95])
title( 'Result after 36 carvings' )


%% Given Notes

% The box containing the dinosaur in world coordinates has the following coordinates:
% 
% min x: -180
% max x:   90
% min y:  -80
% max y:   70
% min z:   20
% max z:  460


% Given a voxel in real space, we want to project it onto the image seen by a
%  specific camera to find out which pixel sees that voxel.
% 
% Let the voxel v have world-coordinates (a, b, c), and the corresponding 
% pixel p have image-coordinates (x, y) which we want to derive.  Let P be 
% the 3 x 4 projection matrix for that particular camera.
% 
% Then:
% 
% v = [a, b, c, 1];
% 
% p = P * v;
% 
% [x, y] = p(1:2) ./ p(3);

