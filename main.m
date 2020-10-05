
clear
clc
%% Select image sequence by choosing sequence number 1,2,3 etc

[exposures, images] = getImageSequence(12);


%montage(images)
%%
%figure
%montage(images)


%% 1. Compute the camera response curve g

[dt, gRed, gGreen, gBlue] = cameraResponse(images, exposures);
% 
% plot(gBlue,'b')
% hold on
% plot(gRed,'r')
% hold on
% plot(gGreen,'g')
% 
% 
% title('Camera response function')
% ylabel('Log exposure')
% xlabel('Pixel value')



%% 2. Recover radiance map
% HDR solver
[HDR] = HDRSolver(images, dt, gRed, gGreen, gBlue);
%size(HDR)


hdr_r=log10(HDR(:,:,1));
hdr_g=log10(HDR(:,:,2));
hdr_b=log10(HDR(:,:,3));

imagesc(hdr_r);
colorbar; 
colormap jet;
%imshow(HDR);

%% 3.1 ldr tonemapping
% local reinhard method
% saturation = 0.6;
% eps = 0.05;
% phi = 14;
% [ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(HDR, saturation, eps, phi);
% 
% imshow(ldrLocal);

%% 3.2 global reinhard method

%a = 0.65;
a = 2.2;
saturation = 0.6;
[ldrGlobal, ldrLuminanceMap] = reinhardGlobal( HDR, a, saturation);
figure
imshow(ldrGlobal)

%% 3.3 Our own tonemap

%[ToneMap] = globalToneMap(HDR);

%imshow(ToneMap)

% montage({ldrGlobal, ToneMap})
%% 4. Quality measures

%SSIM
%H = fspecial('Gaussian',[11 11],1.5);
%A = imfilter(ldrGlobal,H,'replicate');
%[ssimval,ssimmap] = ssim(GlobalToneMap,ldrGlobal);

%imshow(ssimmap,[])
%ssimval