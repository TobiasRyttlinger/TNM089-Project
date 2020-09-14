function [R_sub,G,B] = HDRSolver(images, exposures)
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
   
% Sample rgb 
    
    x = round(683*rand);
    %[x, ~] = size(images{1});
    sample = randperm(size(R,1),x);


 for j=1:x
     R_sub(j,:) = R(sample(j),:);
     G_sub(j,:) = G(sample(j),:);
     B_sub(j,:) = B(sample(j),:);
 end
 
 
 exposures = log(exposures)
end
