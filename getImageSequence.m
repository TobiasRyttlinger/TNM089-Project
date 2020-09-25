
function [exposures, images] = getImageSequence(sequenceNumber)


if sequenceNumber == 1
    directory = 'HDR/';
    exposures = {1/4000, 1/3000, 1/2000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/6, 1/3, 2/3, 4/3};
    fileType = '*.tiff';
    file = '.tiff';
    
elseif sequenceNumber == 2
    directory = 'bildserie2/';
    %exposures = {1/4000, 1/2000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30};
    fileType = '*.jpg';
    file = '.jpg';
elseif sequenceNumber == 3
    directory = 'bildserie3/';
    %exposures = {1/24000, 1/12000, 1/6000, 1/3000, 1/1500, 1/750, 1/350};
    fileType = '*.jpg';
    file = '.jpg';

elseif sequenceNumber == 4
    directory = 'bildserie4/';
    exposures = {1/350, 1/180, 1/90};
    fileType = '*.jpg';
    file = '.jpg';
end


if ~isfolder(directory)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', directory);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(directory, fileType);
tiffFiles = dir(filePattern);
for i = 1:length(tiffFiles)
  firstLetters = strcat('Img',num2str(i),file);
  completeName = fullfile(directory, firstLetters);
  im{i} = imread(completeName);
  images{i} = im{i};
  imageInfo = imfinfo(strcat('Img',num2str(i),file));
  exposures{i} = imageInfo.DigitalCamera.ExposureTime;
end

%montage(images);




end