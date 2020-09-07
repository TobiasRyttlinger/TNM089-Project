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

files = {im1, im2, im3, im4,im5, im6, im7, im8, im9, im10, im11, im12, im13, im14};
expTimes = [0.0333 0.1000 0.3333 0.6250 1.3000 4.0000];
montage(files)

%hdr = makehdr(files,'RelativeExposure',expTimes./expTimes(1));
%rgb = tonemap(hdr);
%imshow(rgb)


    
