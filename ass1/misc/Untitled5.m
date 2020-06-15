%%

filename = sprintf("car%d.jpg", 3);  
I=imread(filename); originalImage = I;
I = imgaussfilt(I,3);
I = rgb2gray(I);

Ix = imfilter(I, [-1 0 1]);
Iy = imfilter(I, [-1 0 1]');


imshowpair(imbinarize(Ix), imbinarize(Iy), "montage");