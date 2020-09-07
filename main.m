%% test 1
test = imread('HDR/IMG_5178.jpg');
tes1 = imread('HDR/IMG_5177.jpg');
tes2 = imread('HDR/IMG_5176.jpg');
tes3 = imread('HDR/IMG_5175.jpg');
tes4 = imread('HDR/IMG_5174.jpg');
tes5 = imread('HDR/IMG_5173.jpg');

files = {'HDR/IMG_5178.jpg','HDR/IMG_5177.jpg','HDR/IMG_5176.jpg',
         'HDR/IMG_5175.jpg','HDR/IMG_5174.jpg','HDR/IMG_5173.jpg'};
expTimes = [0.0333 0.1000 0.3333 0.6250 1.3000 4.0000];
montage(files)

hdr = makehdr(files,'RelativeExposure',expTimes./expTimes(1));
rgb = tonemap(hdr);
imshow(rgb)

%% bildserie 1

for i= 1:13 %read all images in sequance
    
    seq1{i} = im2double(imread(['HDR/Img' int2str(i) '.tiff']));
    imshow(seq{i})
end
    
