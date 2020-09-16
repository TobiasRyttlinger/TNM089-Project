function [R, G, B] = reshapeFun(images)

nrImages = size(images,2)

for i =1:14
    R{i} = images{i}(:,:,1);
    G{i} = images{i}(:,:,2);
    B{i} = images{i}(:,:,3);
end


R = cell2mat([R(:,1:nrImages)]);
G = cell2mat([G(:,1:nrImages)]);
B = cell2mat([B(:,1:nrImages)]);
end

