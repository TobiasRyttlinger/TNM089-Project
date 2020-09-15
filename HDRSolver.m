function [radianceMap, wij] = HDRSolver(images, dt, weights, gRed, gGreen, gBlue)
%GSOLVER Summary of this function goes here
%   Detailed explanation goes here

nrOfImages = size(images,2);
radianceMap =1;



for i=1:nrOfImages
    image = double(images{i});
    %wij = w(image + 1);

end


end
