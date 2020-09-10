function [a, b] = findLowestIntensity(images)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    lowImg = images{14};
    
    grayImg = rgb2gray(lowImg);
    

    [a,b]=minmat(grayImg);
    

end

