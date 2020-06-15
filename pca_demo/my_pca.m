%% My PCA working

clear variables; clc; close all;
load('pca_demo/mnist_train.mat');

X = train_X;

% Principal Component Analysis
% best guess explanation :)
% mean shift data then get the covariance matrix of the data
% then calculate the eigenvectors of the covariance matrix
% then use them to transform the data into the eigen-space

[m, n] = size(X) ;
mean = sum(X) / m ;
X = X - mean ;
[W, V] = eig( X' * X / (m-1) ) ; 
T = X * W ; % get new coordinates

coeff = W; scores = T; latent = V;

% matlab sorts eigenvalues/vectors in ascending order from left to right
s1=scores(:,784-0);
s2=scores(:,784-1);

% Simple Plot
% plot(s1(:),s2(:),'.');

% Pretty Plot
i1=find(train_labels==1);
i2=find(train_labels==2);
i3=find(train_labels==3);
i4=find(train_labels==4);
i5=find(train_labels==5);

figure;
hold on;
plot(s1(i1),s2(i1),'.');
plot(s1(i2),s2(i2),'.');
plot(s1(i3),s2(i3),'.');
plot(s1(i4),s2(i4),'.');
plot(s1(i5),s2(i5),'.');
hold off;
xlabel('PC1'); ylabel('PC2'); title('MNIST Data Transformed to 2D Principal Component Space');

% % What percentage of the data variance is accounted for by the first two principal components?
% sum(latent(1:2))/sum(latent)*100
% % 16.8006%

% Show Eigen Images?
A = {};
for n=1:100
    A{n} = imcomplement(reshape(W(:,784-n),[28,28]));
    % used imcomplement because the images were all dark
end

figure;
montage(A)