
%% plot 
load('HDR/gfun.mat'); %This function characterizes the relation between pixel values, exposure time and irradiance (one curve for the R, G and the B channel).

plot(gfun)
hold on
plot(2.^gfun)



title('Plot of gfun and their exponential')
legend('gfun', '2^{gfun}')
%% bildserie 1
im1 = imread('HDR/Img1.tiff');
im2 = imread('HDR/Img2.tiff');
im3 = imread('HDR/Img3.tiff');
im4 = imread('HDR/Img4.tiff');
im5 = imread('HDR/Img5.tiff');
im6 = imread('HDR/Img6.tiff');
im7 = imread('HDR/Img7.tiff');
im8 = imread('HDR/Img8.tiff');
im9 = imread('HDR/Img9.tiff');
im10 = imread('HDR/Img10.tiff');
im11 = imread('HDR/Img11.tiff');
im12 = imread('HDR/Img12.tiff');
im13 = imread('HDR/Img13.tiff');
im14 = imread('HDR/Img14.tiff');

images = {im1, im2, im3, im4,im5, im6, im7, im8, im9, im10, im11, im12, im13, im14};
montage(images)


%% find lowest intensty

[a, b] = findLowestIntensity(images);

%% find highest intensity
[a1, b1] = findHighestIntensity(images);

imshow(im1)
axis on
hold on;
% Plot cross at row 100, column 50
plot(b1,a1, 'r+', 'MarkerSize', 10, 'LineWidth', 1);
%% find gray

lowImg = images{9};
grayImg = rgb2gray(im2double(lowImg));
[height, width] = size(grayImg);

[globaMinIndexes,y] = Gray_point(grayImg);

imshow(grayImg)
axis on
hold on;
% Plot cross at row 100, column 50
plot(y,globaMinIndexes, 'r+', 'MarkerSize', 10, 'LineWidth', 1);

%% Find the common matrices for highest, lowest and median gray point.

for i = 1: 14

    tempImage = double(images{i});
    mat(1,i) = tempImage(a,b);
    mat(2,i) = tempImage(a1,b1);
    mat(3,i) = tempImage(y,globaMinIndexes);

end
loglog(mat(1,:))
hold on
loglog(mat(2,:))
hold on
loglog(mat(3,:))


%% 

ExposureTimes = zeros(1,14);

for i = 1:6
       tempImage = rgb2gray(images{i});
       ExposureTimes(1,i) = 1/2*i;
       
       ExposureImages = ExposureTimes(1,i)*tempImage;
       imshow(ExposureImages)
end

%%
[hdr, rgb, logE, points] = HDR(images)

















