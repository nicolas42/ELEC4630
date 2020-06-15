clear all; clc; close all;

%% Demo

[file,path]=uigetfile({'*.bmp'}, 'Select file');
filename = fullfile(path, file);

[im, map] = imread(filename);
actualIm = ind2rgb(im, map);      
query = actualIm;

matching_filename = match_image(filename);
[im, map] = imread(matching_filename);
actualIm = ind2rgb(im, map);      
match = actualIm;

montage({query match});


%% Test All
% 1/1<x>.bmp should map to eig/1a.bmp
% 2/2<x>.bmp should map to eig/2a.bmp and so on

% for f in `find Faces -name '*.bmp'`; do printf "\'$f\' " ; done
test_files = {'Faces/1/1a.bmp' 'Faces/1/1b.bmp' 'Faces/1/1c.bmp' 'Faces/1/1d.bmp' 'Faces/1/1e.bmp' 'Faces/1/1f.bmp' 'Faces/1/1g.bmp' 'Faces/2/2a.bmp' 'Faces/2/2b.bmp' 'Faces/2/2c.bmp' 'Faces/2/2d.bmp' 'Faces/3/3a.bmp' 'Faces/3/3b.bmp' 'Faces/3/3c.bmp' 'Faces/3/3d.bmp' 'Faces/3/3e.bmp' 'Faces/3/3f.bmp' 'Faces/3/3g.bmp' 'Faces/3/3h.bmp' 'Faces/3/3i.bmp' 'Faces/3/3j.bmp' 'Faces/4/4a.bmp' 'Faces/4/4b.bmp' 'Faces/4/4c.bmp' 'Faces/4/4d.bmp' 'Faces/5/5a.bmp' 'Faces/5/5b.bmp' 'Faces/5/5c.bmp' 'Faces/5/5d.bmp' 'Faces/6/6a.bmp' 'Faces/6/6b.bmp' 'Faces/6/6c.bmp' 'Faces/6/6d.bmp' };
for i=1:length(test_files)

%     [file,path]=uigetfile({'*.bmp'}, 'Select file');
%     filename = fullfile(path, file);

    filename = test_files{i};
    [im, map] = imread(filename);
    actualIm = ind2rgb(im, map);      
    query = actualIm;

    matching_filename = match_image(filename);
    [im, map] = imread(matching_filename);
    actualIm = ind2rgb(im, map);      
    match = actualIm;

%     montage({query match});

    fprintf("query: %s match: %s\n", filename, matching_filename);
end

%% Train
% for f in `find . -name '*.bmp'`; do ffmpeg -i $f ${f%.*}.pgm ; done

% [im, map] = imread('1a.bmp');
% actualIm = rgb2gray(ind2rgb(im, map));

clear all; clc; close all;
training_files = { 'Faces/eig/1a.bmp' 'Faces/eig/2a.bmp' 'Faces/eig/3A.bmp' 'Faces/eig/4A.bmp' 'Faces/eig/5A.bmp' 'Faces/eig/6A.bmp' };

H=128;W=128;N=6;

% get the training images
training_images = zeros(H*W,N);
for i = 1:N
    [im, map] = imread(training_files{i});
    actualIm = rgb2gray(ind2rgb(im, map));
    training_images(:,i) = reshape(actualIm,H*W,1);
end

% mean shift
mean_image = sum(training_images,2)/N;
training_images = training_images - repmat(mean_image,1,N);

% get eigenfaces
% can use pca svd or eig here
[eigenvectors,lambda] = eig(training_images'*training_images);
eigenfaces = training_images * eigenvectors;

% project onto eigenfaces
projections = eigenfaces' * training_images;

% % show eigenfaces
% for i=1:size(eigenfaces,2)
%     im = reshape(eigenfaces(:,i),[H W]);
%     im = im - min(min(im));
%     m{i} = imcomplement(im / max(max(im)));
% end
% figure;
% montage(m);

% Test One

test_image_filename = 'Faces/1/1b.bmp';
[im, map] = imread(test_image_filename);
actualIm = rgb2gray(ind2rgb(im, map));

im = reshape(actualIm,H*W,1);
im = double(im) - mean_image;

% projection of the test face on the eigenfaces
projection = eigenfaces' * im;

% find minimum distance
distances = repmat(projection,1,N) - projections;
index = 1;
for i=1:N
    if norm(distances(:,i)) < norm(distances(:,index))
        index = i;
    end
end

% fprintf("%d ", index);
figure;
montage({actualIm imread(training_files{index})});






%% Test All
% for f in `find Faces -name '*.bmp'`; do printf "\'$f\' " ; done

test_files = {'Faces/1/1a.bmp' 'Faces/1/1b.bmp' 'Faces/1/1c.bmp' 'Faces/1/1d.bmp' 'Faces/1/1e.bmp' 'Faces/1/1f.bmp' 'Faces/1/1g.bmp' 'Faces/2/2a.bmp' 'Faces/2/2b.bmp' 'Faces/2/2c.bmp' 'Faces/2/2d.bmp' 'Faces/3/3a.bmp' 'Faces/3/3b.bmp' 'Faces/3/3c.bmp' 'Faces/3/3d.bmp' 'Faces/3/3e.bmp' 'Faces/3/3f.bmp' 'Faces/3/3g.bmp' 'Faces/3/3h.bmp' 'Faces/3/3i.bmp' 'Faces/3/3j.bmp' 'Faces/4/4a.bmp' 'Faces/4/4b.bmp' 'Faces/4/4c.bmp' 'Faces/4/4d.bmp' 'Faces/5/5a.bmp' 'Faces/5/5b.bmp' 'Faces/5/5c.bmp' 'Faces/5/5d.bmp' 'Faces/6/6a.bmp' 'Faces/6/6b.bmp' 'Faces/6/6c.bmp' 'Faces/6/6d.bmp' };
for i=1:length(test_files)
% test image
test_image_filename = test_files{i};
[im, map] = imread(test_image_filename);
actualIm = rgb2gray(ind2rgb(im, map));

im = reshape(actualIm,H*W,1);
im = double(im) - mean_image;

% projection of the test face on the eigenfaces
projection = eigenfaces' * im;

% find minimum distance
distances = repmat(projection,1,N) - projections;
index = 1;
for i=1:N
    if norm(distances(:,i)) < norm(distances(:,index))
        index = i;
    end
end

fprintf("%d ", index);
% want 1 1 1 1 1 1 1 2 2 2 2 3 3 5 3 3 3 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6
end

%% UI Callback

% Button pushed function: LoadImageButton
function LoadImageButtonPushed(app, event)
      [file,path]=uigetfile({'*bmp'}, 'Select file');
      filename = fullfile(path, file);
      [im, map] = imread(filename);
      actualIm = ind2rgb(im, map);      
      app.Image.ImageSource = actualIm;

      matching_filename = match_image(filename);
      [im, map] = imread(matching_filename);
      actualIm = ind2rgb(im, map);      
      app.Image2.ImageSource = actualIm;
end