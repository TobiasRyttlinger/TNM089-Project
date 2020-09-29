function [zRed,zGreen, zBlue] = sampleRGB(images)
    %code based on debevec
    %number of pixels in one image and number of exposures(images)
    numPixels = size(images{1},1)*size(images{1},2);
    numExposures = size(images,2);
    
    
    numSamples = ceil(255*2 / (numExposures - 1)) * 2;
    
    % create a random sampling matrix
    % using ceil fits the indices into the range [1,numPixels+1],
    
    step = numPixels / numSamples;
    sampleIndices = floor((1:step:numPixels));
    sampleIndices = sampleIndices';
    
    
    zRed = zeros(numSamples, numExposures);
    zGreen = zeros(numSamples, numExposures);
    zBlue = zeros(numSamples, numExposures);
    
    
    for i=1:numExposures
        
        image = images{i};
        redChannel = image(:,:,1);
        tempRed = redChannel(sampleIndices);
    
        greenChannel = image(:,:,2);
        tempGreen = greenChannel(sampleIndices);
    
        blueChannel = image(:,:,3);
        tempBlue = blueChannel(sampleIndices);
        
        
        zRed(:,i) = tempRed;
        zGreen(:,i) = tempGreen;
        zBlue(:,i) = tempBlue;
    end
    
   
end

