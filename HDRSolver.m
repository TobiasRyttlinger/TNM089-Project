function [HDRImage] = HDRSolver(images, dt, weights, gRed, gGreen, gBlue)

imSize = size(images{1}, 1) * size(images{1}, 2);
heightIm = size(images{1},1);
widthIm = size(images{1},2);

% Adding each channel of the images to an array.
for i = 1:size(images,2)
    R(:,i) = reshape(images{i}(:,:,1), [imSize, 1]);
    G(:,i) = reshape(images{i}(:,:,2), [imSize, 1]);
    B(:,i) = reshape(images{i}(:,:,3), [imSize, 1]);
end

% Making the radiance map

normSumR = zeros(1,size(R,1));
normSumG = zeros(1,size(R,1));
normSumB = zeros(1,size(R,1));
nrOfImages = size(images,2);
for n = 1:nrOfImages
    for m = 1:256
 
        % equation 5 
        Exp_R(find(R(:,n) == m-1),n) = (weights(m)*(gRed(m)-dt(n)))/weights(m);
        Exp_G(find(G(:,n) == m-1),n) = (weights(m)*(gGreen(m)-dt(n)))/weights(m);
        Exp_B(find(B(:,n) == m-1),n) = (weights(m)*(gBlue(m)-dt(n)))/weights(m);
         
    end
end
normSumR = sum(Exp_R')/nrOfImages;
normSumG = sum(Exp_G')/nrOfImages;
normSumB = sum(Exp_B')/nrOfImages;


% reshape back to an image from vectorzed image
radianceMapR = reshape(normSumR,[heightIm,widthIm]);
radianceMapG = reshape(normSumG,[heightIm,widthIm]);
radianceMapB = reshape(normSumB,[heightIm,widthIm]);
   
HDRImage= cat(3,radianceMapR, radianceMapG, radianceMapB);

HDRImage=(HDRImage-min(HDRImage(:)))/(max(HDRImage(:))-min(HDRImage(:)));

%normalized image [0,1]

end
