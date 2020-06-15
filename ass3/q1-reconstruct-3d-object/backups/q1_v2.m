clear all; clc; close all;

P_Mat = get_projection_matrices();

% Make dinosaur masks
for i=0:35
    f = sprintf('dino/dino%02d.jpg',i);
    im = imread(f);
%     [h,w,d] = size(im);

    % get parts of the image that are more red than blue
    BW = im(:,:,1) > im(:,:,3);
    BW = imclearborder(BW);
%     S = imrotate( S, 180);
%     imshow(S);
    masks{i+1} = BW;
%     S = bwareaopen(S, ceil(h*w/10));

end
close;

step = 5;
% make the 3D space
xlim = -180:step:90;
ylim = -80:step:70;
zlim = 20:step:460;

[X, Y, Z] = meshgrid(xlim,ylim,zlim);
% V = ones(1, numel(X));

Voxels = [ reshape(X, [1, numel(X)]); reshape(Y, [1, numel(X)]); reshape(Z, [1, numel(X)]); ones(1, numel(X)); ];




for index = 1:36

BW = masks{index};
[h,w] = size(BW);

% Find corresponding pixels
% Apply projection matrix to filled voxel [x,y,z,1] to get coordinate of
% corresponding pixel
P = P_Mat(:,:,index);
p = P * Voxels;
xy = p(1:2,:) ./ p(3,:);
x = xy(1,:);
y = xy(2,:);


outside = find( 1 >= x & x >= w & 1 >= y & y >= h );
Voxels(4,outside) = 0;

inside = find( 1 <= x & x <= w & 1 <= y & y <= h );
ind = sub2ind( [h,w], round(y(inside)), round(x(inside)) );
outside = inside(BW(ind) == 0);
Voxels(4,outside) = 0;


end

disp('done')

V = reshape(Voxels(4,:), size(X));


ptch = patch( isosurface( X, Y, Z, V, 0.5 ) );
isonormals( X, Y, Z, V, ptch )
set( ptch, 'FaceColor', 'g', 'EdgeColor', 'none' );

set(gca,'DataAspectRatio',[1 1 1]);
view(-140,22)
lighting( 'gouraud' )
camlight( 'right' )
axis( 'tight' )


%%





v = Voxels(:,inside);





XData = v(1,:);
YData = v(2,:);
ZData = v(3,:);
Value = v(4,:);

% First grid the data
ux = unique(XData);
uy = unique(YData);
uz = unique(ZData);

% Convert to a grid
[X,Y,Z] = meshgrid( ux, uy, uz );

% Create an empty voxel grid, then fill only those elements in voxels
V = zeros( size( X ) );
N = numel( XData );
for ii=1:N
    ix = (ux == XData(ii));
    iy = (uy == YData(ii));
    iz = (uz == ZData(ii));
    V(iy,ix,iz) = Value(ii);
end







% Now draw it
ptch = patch( isosurface( X, Y, Z, V, 0.5 ) );
isonormals( X, Y, Z, V, ptch )
set( ptch, 'FaceColor', 'g', 'EdgeColor', 'none' );

set(gca,'DataAspectRatio',[1 1 1]);
xlabel('X');
ylabel('Y');
zlabel('Z');
view(-140,22)
lighting( 'gouraud' )
camlight( 'right' )
axis( 'tight' )




%%
[x y z] = meshgrid(unique(v(1,:)),unique(v(2,:)),unique(v(3,:)));
vals = zeros(size(x));

for i=1:size(v,2)
    vals(v(1,i),v(2,i),v(3,i)) = 1;
end




%%
close;
[x,y,z,v] = flow;
isosurface(x,y,z,v,-3);
% isonormals(x,y,z,v,p)
% p.FaceColor = 'red';
% p.EdgeColor = 'none';
% daspect([1 1 1])
% view(3); 
% axis tight
% camlight 
% lighting gouraud


%%
close all;
xlim = -180:90;
ylim = -80:70;
zlim = 20:460;
[x,y,z] = ndgrid(-180:90,-80:70,20:460);
v = zeros(size(x));
v(inside) = 1;
isosurface(v,1/2)


%% isosurface graph
[x,y,z,v] = flow;
p = patch(isosurface(x,y,z,v,-3));
isonormals(x,y,z,v,p)
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud



% Given Notes

% The box containing the dinosaur in world coordinates has the following coordinates:
% 
% min x: -180
% max x:   90
% min y:  -80
% max y:   70
% min z:   20
% max z:  460

% x = -180:90;
% y = -80:70;
% z = 20:460;
% 
% [X,Y,Z] = meshgrid(x,y,z);

%

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


%% Demo segmentation
% or the background is blue.

i=1
f = sprintf('dino/dino%02d.jpg',i);
im = imread(f);

[R,G,B] = imsplit(im);
% montage({R G B});
montage({imbinarize(R) imbinarize(B)})
