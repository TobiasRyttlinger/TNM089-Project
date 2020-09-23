%% bildserie 1

% Read in pictures from folder
HDRbilderna = 'HDR/';

if ~isfolder(HDRbilderna)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', HDRbilderna);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(HDRbilderna, '*.tiff');
tiffFiles = dir(filePattern);
for i = 1:length(tiffFiles)
  firstLetters = strcat('Img',num2str(i),'.tiff');
  completeName = fullfile(HDRbilderna, firstLetters);
  im{i} = imread(completeName);
  images{i} = im{i};
end

%montage(images);

exposures = {1/4000, 1/3000, 1/2000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/6, 1/3, 2/3, 4/3};



%% 1. Compute the camera response curve g
%sample


[zRed, zGreen, zBlue] = sampleRGB(images);


%% B, shutter speed used in gsolve, logarithm of exposure time

logExp = {};
for e = 1:size(exposures,2)
    logExp{e} = log(exposures{e});
end

dt = zeros(size(zRed,1)*size(zRed,2), size(exposures,2));
for b=1:size(exposures,2)
    dt(:,b) = logExp{b};
end


%% weighting
weight = zeros(255,1);

for k = 1:256
    weight(k) = weights(k);
end
%plot(weight)

%% gsolver, camera response function g

l=100;

[gRed,lERed]=gSolver(zRed, dt, l, weight);

[gGreen,lEGreen]=gSolver(zGreen, dt, l, weight);

[gBlue,lEBlue]=gSolver(zBlue, dt, l, weight);



plot(gBlue,'b')
hold on
plot(gRed,'r')
hold on
plot(gGreen,'g')

%hold off
%plot(zBlue','x')

title('Camera response function')
ylabel('Log exposure')
xlabel('Pixel value')

save('gMat.mat', 'gBlue', 'gRed', 'gGreen');

%% 2. Recover radiance map
% HDR solver

[HDR] = HDRSolver(images, dt, weight, gRed, gGreen, gBlue);
%% 3.1 ldr tonemapping
% local reinhard method
saturation = 0.5;
eps = 0.5;
phi = 8;
[ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(HDR, saturation, eps, phi);

imshow(ldrLocal);
%% 3.2 global reainhard method

a = 0.97;
saturation = 0.65;
[ldrGlobal, ldrLuminanceMap ] = reinhardGlobal( HDR, a, saturation);
imshow(ldrGlobal)
%% 3.3 gamma correction

Dmax = max(max(ldrGlobal));
D = ldrLocal;
D(:,:,1) = Dmax(:,:,1)*((D(:,:,1)/Dmax(:,:,1)).^(1/2.1));
D(:,:,2) = Dmax(:,:,2)*((D(:,:,2)/Dmax(:,:,2)).^(1/2.4));
D(:,:,3) = Dmax(:,:,3)*((D(:,:,3)/Dmax(:,:,3)).^(1/1.8));

imshow(D)