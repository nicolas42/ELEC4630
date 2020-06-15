function matched_image = match_image(test_image_filename)

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

% Test One
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

matched_image = training_files{index};
