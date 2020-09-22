function [E_normR,E_normG,E_normB] = HDRSolver(images, dt, weights, gRed, gGreen, gBlue)

imgSizeOneDim = size(images{1}, 1) * size(images{1}, 2);
imgDims = images{1};
% Adding each channel of the images to an array.
for nrImages = 1:size(images,2)
    R(:,nrImages) = reshape(images{nrImages}(:,:,1), [imgSizeOneDim, 1]);
    G(:,nrImages) = reshape(images{nrImages}(:,:,2), [imgSizeOneDim, 1]);
    B(:,nrImages) = reshape(images{nrImages}(:,:,3), [imgSizeOneDim, 1]);
end

% Making the radiance map

sum_R = 0;
sum_G = 0;
sum_B = 0;
nrOfImages = size(images,2);
for m = 1:256
    for n = 1:nrOfImages
        %Finding all the color values in the channel (0-255) and return the
        %index
        indices_R = find(R(:,n) == m-1);
        indices_G = find(G(:,n) == m-1);
        indices_B = find(B(:,n) == m-1);
        
        % Responsefunction minus exposure in that
        % equation 5 in the paper. "Radiance value"
        Exp_R(indices_R,n) = gRed(m)-dt(n);
        Exp_G(indices_G,n) = gGreen(m)-dt(n);
        Exp_B(indices_B,n) = gBlue(m)-dt(n);
    end
end

for c = 1:nrOfImages
% Add the color channels for each image.
    sum_R = sum_R + Exp_R(:,c);
    sum_G = sum_G + Exp_G(:,c);
    sum_B = sum_B + Exp_B(:,c);  
end

% takes the mean for each pixel of each image in each channel and reshapes
% them from a single row to an image again
radiance_mapR = reshape(sum_R/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
radiance_mapG = reshape(sum_G/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
radiance_mapB = reshape(sum_B/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
   

minE = min([min(radiance_mapR(:)),min(radiance_mapG(:)),min(radiance_mapB(:))]);
maxE = max([max(radiance_mapR(:)),max(radiance_mapG(:)),max(radiance_mapB(:))]);

%Normalising based on the max and min radiance to [0,1]
for i = 1:size(imgDims,1) 
   for j = 1:size(imgDims,2)
         E_normR(i,j) = (radiance_mapR(i,j)-minE)/(maxE-minE);
         E_normG(i,j) = (radiance_mapG(i,j)-minE)/(maxE-minE);
         E_normB(i,j) = (radiance_mapB(i,j)-minE)/(maxE-minE);
   end
end
end
