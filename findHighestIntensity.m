function [a, b] = findHighestIntensity(images)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    lowImg = images{1};
    
    grayImg = rgb2gray(lowImg);
    

    [a,b]=maxmat(grayImg);
    
end

