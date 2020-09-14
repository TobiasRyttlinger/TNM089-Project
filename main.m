
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

exposures = {1/4000, 1/3000, 1/2000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/6, 1/3, 2/3, 4/3};
%% HDR solver

[R,G,B] = HDRSolver(images, exposures);
imshow(R)

%imshow(G)

%imshow(B)

%%


for j = 1:(size(exposures, 2))

    LogExposures{j} = log(exposures{j})
end

