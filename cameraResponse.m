function [dt, gRed, gGreen, gBlue] = cameraResponse(images, exposures)

%random samples of the images
[zRed, zGreen, zBlue] = sampleRGB(images);


%B, shutter speed used in gsolve, logarithm of exposure time

logExp = {};
for e = 1:size(exposures,2)
    logExp{e} = log(exposures{e});
end

dt = zeros(size(zRed,1)*size(zRed,2), size(exposures,2));
for b=1:size(exposures,2)
    dt(:,b) = logExp{b};
end


%weighting
weight = zeros(255,1);

for k = 1:256
    weight(k) = weights(k);
end


l=100;

[gRed,~]=gSolver(zRed, dt, l, weight);

[gGreen,~]=gSolver(zGreen, dt, l, weight);

[gBlue,~]=gSolver(zBlue, dt, l, weight);



end

