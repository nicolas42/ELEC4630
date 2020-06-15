function image = image_read(filename)

[~,~,ext] = fileparts(filename);
if ext == '.bmp'
    disp('BMP!')
    [im, map] = imread(filename);
    image = ind2rgb(im, map);      
else
    image = imread(filename);
end
