%% from comp4702, takes a while, draws 2D image of ???
% mnist data is 28x28 pixel BW images of the hand written symbols 0-9
% so there's 784 dimensions but this demo shows that 2 dimensions
% can account for 16% of the variability.

% A particular basis vector is a 28x28 BW image.  The idea
% is that a linear combination of these images can produce all the training
% data with some degree of accuracy.

clear variables; clc; %close all;
load('pca_demo/mnist_train.mat');

% Do Principal Component Analysis on the training data 
[coeff, scores, latent]=pca(train_X);
% Principal component coefficients, returned as a p-by-p matrix. Each column of coeff contains coefficients for one principal component. The columns are in the order of descending component variance, latent.
% Principal component scores, returned as a matrix. Rows of score correspond to observations, and columns to components.
% Principal component variances, that is the eigenvalues of the covariance matrix of X, returned as a column vector.


% Graph 2 most significant dimensions of MNIST Data
% pc1=coeff(:,1);
% pc2=coeff(:,2);

s1=scores(:,1);
s2=scores(:,2);

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

% What percentage of the data variance is accounted for by the first two principal components?
sum(latent(1:2))/sum(latent)*100
% 16.8006%


%% My PCA

clear variables; clc;
load('pca_demo/mnist_train.mat');

X = train_X;

% My algorithm
[m n]=size(X);
X=X-sum(X)/m; % mean shift
[W V]=eig(X'*X/(m-1));

% reverse columns so the first column is most significant
W = W(:,length(W):-1:1); % reverse columns of new basis
V = diag(V);
V = V(length(V):-1:1); % reverse eigenvalues

T = X*W; % get new coordinates

coeff = W; scores = T; latent = V;



% Graph 2 most significant dimensions of MNIST Data
s1=scores(:,1);
s2=scores(:,2);

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

% What percentage of the data variance is accounted for by the first two principal components?
sum(latent(1:2))/sum(latent)*100
% 16.8006%

