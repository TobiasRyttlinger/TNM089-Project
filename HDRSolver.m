function [R,G,B] = HDRSolver(images)
%GSOLVER Summary of this function goes here
%   Detailed explanation goes here

    nrOfImages = 14;
    
    for i =1:nrOfImages
        R{i} = images{i}(:,:,1);
        G{i} = images{i}(:,:,2);
        B{i} = images{i}(:,:,3);
    end
    
    
    Rcell = [R(:,1:nrOfImages)];
    Gcell = [G(:,1:nrOfImages)];
    Bcell = [B(:,1:nrOfImages)];
    
    R = cell2mat(Rcell);
    G = cell2mat(Gcell);
    B = cell2mat(Bcell);
end
