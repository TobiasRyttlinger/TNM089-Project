function [HDRImage] = HDRSolver(images, dt, weights, gRed, gGreen, gBlue)

imSize = size(images{1}, 1) * size(images{1}, 2);
imgDims = images{1};
% Adding each channel of the images to an array.
for i = 1:size(images,2)
    R(:,i) = reshape(images{i}(:,:,1), [imSize, 1]);
    G(:,i) = reshape(images{i}(:,:,2), [imSize, 1]);
    B(:,i) = reshape(images{i}(:,:,3), [imSize, 1]);
end

% Making the radiance map

sumR = 0;
sumG = 0;
sumB = 0;
nrOfImages = size(images,2);
for n = 1:nrOfImages
    for m = 1:256
 
        % equation 5 
        Exp_R(find(R(:,n) == m-1),n) = (gRed(m)-dt(n));
        Exp_G(find(G(:,n) == m-1),n) = (gGreen(m)-dt(n));
        Exp_B(find(B(:,n) == m-1),n) = (gBlue(m)-dt(n));
         
    end
end

for c = 1:nrOfImages
% Add the color channels for each image.
    sumR = sumR + Exp_R(:,c);
    sumG = sumG + Exp_G(:,c);
    sumB = sumB + Exp_B(:,c);  
end

% takes the mean for each pixel of each image in each channel and reshapes
% them from a single row to an image again
radianceMapR = reshape(sumR/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
radianceMapG = reshape(sumG/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
radianceMapB = reshape(sumB/nrOfImages,[size(imgDims,1),size(imgDims,2)]);
   
HDRImage= cat(3,radianceMapR, radianceMapG, radianceMapB);

HDRImage=(HDRImage-min(HDRImage(:)))/(max(HDRImage(:))-min(HDRImage(:)));

%Normalising based on the max and min radiance to [0,1]

end
