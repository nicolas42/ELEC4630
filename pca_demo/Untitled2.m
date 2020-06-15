%% My PCA working

clear variables; clc; close all;
load('pca_demo/mnist_train.mat');

X = train_X; % row vectors

[m, n] = size(X) ;
mean = sum(X) / m ;
X = X - mean ;
[W, V] = eig( X' * X / (m-1) ) ; 
T = X * W ; % get new coordinates

coeff = W; scores = T; latent = V;

% matlab sorts eigenvalues/vectors in ascending order from left to right

% Show Eigen Images
A = {};
for n=1:100
    A{n} = imcomplement(reshape(W(:,784-n),[28,28]));
    % used imcomplement because the images were all dark
end

figure;
montage(A)