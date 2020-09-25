%% Select imge sequence by choosing sequence number 1,2,3 etc

[exposures, images] = getImageSequence(1);



%%
info = imfinfo('bildserie3/Img2.jpg')
info.DigitalCamera.ExposureTime;

info.Format

%% 1. Compute the camera response curve g

[dt, gRed, gGreen, gBlue] = cameraResponse(images, exposures);

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



%% 2. Recover radiance map
% HDR solver
[HDR] = HDRSolver(images, dt, gRed, gGreen, gBlue);
%size(HDR)
%imshow(HDR);


%% 3.1 ldr tonemapping
% local reinhard method
saturation = 0.6;
eps = 0.05;
phi = 14;
[ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(HDR, saturation, eps, phi);

imshow(ldrLocal);

%% 3.2 global reinhard method

a = 0.7;
saturation = 0.7;
[ldrGlobal, ldrLuminanceMap ] = reinhardGlobal( HDR, a, saturation);
imshow(ldrGlobal)

%% 3.3 gamma correction

gamma = 0.7;
A = 1;

EgammaR = A*ldrGlobal(:,:,1).^gamma;
EgammaG = A*ldrGlobal(:,:,2).^gamma;
EgammaB = A*ldrGlobal(:,:,3).^gamma;

imageGamma = cat(3,EgammaR,EgammaG,EgammaB);
imshow(imageGamma);

%%
%rgb = tonemap(HDR);