%%
clc; clear all; close all;
cameras = loadcameradata( 'DinosaurData' );

for c=1:numel(cameras)

    im = cameras(c).Image;
    [h,w,d] = size(im);

    % Initial segmentation based on more red than blue
    S = im(:,:,1) > (im(:,:,3)-2);

    % Remove regions touching the border or smaller than 10% of image area
    S = imclearborder(S);
    S = bwareaopen(S, ceil(h*w/10));

    % Now remove holes < 1% image area
    S = ~bwareaopen(~S, ceil(h*w/100));
    
    cameras(c).Silhouette = S;

%     cameras(c).Silhouette = getsilhouette( cameras(c).Image );
end

%%

[xlim,ylim,zlim] = findmodel( cameras );

voxels = makevoxels( xlim, ylim, zlim, 5000000 );
starting_volume = numel( voxels.XData );

for ii=1:numel(cameras)
    voxels = carve( voxels, cameras(ii) );
end

figure('Position',[100 100 600 700]);
showsurface(voxels)
set(gca,'Position',[-0.2 0 1.4 0.95])
axis off
title( 'Result after 36 carvings' )

final_volume = numel( voxels.XData );
fprintf( 'Final volume is %d (%1.2f%%)\n', ...
    final_volume, 100 * final_volume / starting_volume )


%% Get real values
% We ideally want much higher resolution, but would run out of memory.
% Instead we can use a trick and assign real values to each voxel instead
% of a binary value. We do this by moving all voxels a third of a square in
% each direction then seeing if they get carved off. The ratio of carved to
% non-carved for each voxel gives its score (which is roughly equivalent to
% estimating how much of the voxel is inside).
offset_vec = 1/3 * voxels.Resolution * [-1 0 1];
[off_x, off_y, off_z] = meshgrid( offset_vec, offset_vec, offset_vec );

num_voxels = numel( voxels.Value );
num_offsets = numel( off_x );
scores = zeros( num_voxels, 1 );
for jj=1:num_offsets
    keep = true( num_voxels, 1 );
    myvoxels = voxels;
    myvoxels.XData = voxels.XData + off_x(jj);
    myvoxels.YData = voxels.YData + off_y(jj);
    myvoxels.ZData = voxels.ZData + off_z(jj);
    for ii=1:numel( cameras )
        [~,mykeep] = carve( myvoxels, cameras(ii) );
        keep(setdiff( 1:num_voxels, mykeep )) = false;
    end
    scores(keep) = scores(keep) + 1;
end
voxels.Value = scores / num_offsets;
figure('Position',[100 100 600 700]);
showsurface( voxels );
set(gca,'Position',[-0.2 0 1.4 0.95])
axis off
title( 'Result after 36 carvings with refinement' )


%% Final Result
% For online galleries and the like we would colour each voxel from the
% image with the best view (i.e. nearest normal vector), leading to a
% colour 3D model. This makes zero difference to the volume estimate (which
% was the main purpose of the demo), but does look pretty!
figure('Position',[100 100 600 700]);
ptch = showsurface( voxels );
colorsurface( ptch, cameras );
set(gca,'Position',[-0.2 0 1.4 0.95])
axis off
title( 'Result after 36 carvings with refinement and colour' )

