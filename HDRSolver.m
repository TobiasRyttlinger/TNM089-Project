function [radianceMap] = HDRSolver(images, dt, weights, gRed, gGreen, gBlue)
%GSOLVER Summary of this function goes here
%   Detailed explanation goes here

nrOfImages = size(images,2);
 

radianceMap = zeros(size(images{1}));

numPixels = size(images{1},1)*size(images{1},2);

%create empty matrix for exposure
eRed = zeros(numPixels,nrOfImages);
eGreen = zeros(numPixels,nrOfImages);
eblue = zeros(numPixels,nrOfImages);

% create one long matrix of all images

[rLarge, gLarge, bLarge] = reshapeFun(images);
for i=1:nrOfImages
    for m = 1:256
    for n = 1:nrOfImages
       
    end
end

end


end
