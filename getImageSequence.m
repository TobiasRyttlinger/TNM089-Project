

function [exposures, images] = getImageSequence(sequenceNumber)

   test = 0;

if sequenceNumber == 1
    directory = 'HDR/';
    exposures = {1/4000, 1/3000, 1/2000, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/6, 1/3, 2/3, 4/3};
    fileType = '*.tiff';
    file = '.tiff';
    test = 1;
    
elseif sequenceNumber == 2
    directory = 'bildserie2/';
    fileType = '*.jpg';
    file = '.jpg';
elseif sequenceNumber == 3
    directory = 'bildserie3/';
    fileType = '*.jpg';
    file = '.jpg';
    

elseif sequenceNumber == 4
    directory = 'bildserie4/';
    exposures = {1/0.03125, 1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1, 1/2, 1/4, 1/8, 1/16, 1/32, 1/64, 1/128, 1/256, 1/512, 1/1024};
    fileType = '*.jpg';
    file = '.jpg';
    test =1;
    
elseif sequenceNumber == 5
    directory = 'bildserie5/';
    fileType = '*.jpg';
    file = '.jpg';
    
elseif sequenceNumber == 6
    directory = 'bildserie6/';
    fileType = '*.tif';
    file = '.tif';
    exposures = {1/120, 1/30, 1/8, 1/2};
    test =1;
elseif sequenceNumber == 7
    directory = 'bildserie7/';
    fileType = '*.jpg';
    file = '.jpg';
    
elseif sequenceNumber == 8
    directory = 'bildserie8/';
    fileType = '*.jpg';
    file = '.jpg';
   
 elseif sequenceNumber == 9
    directory = 'bildserie9/';
    fileType = '*.jpg';
    file = '.jpg';   
    
 elseif sequenceNumber == 10
    directory = 'bildserie10/';
    fileType = '*.jpg';
    file = '.jpg'; 
    
elseif sequenceNumber == 11
    directory = 'bildserie11/';
    fileType = '*.jpg';
    file = '.jpg'; 


elseif sequenceNumber == 12
    directory = 'bildserie12/';
    fileType = '*.jpg';
    file = '.jpg'; 
    exposures ={1/2500,1/1600, 1/800, 1/400, 1/200, 1/100, 1/50, 1/25, 1/13, 1/6, 1/3, 1, 2};
    test = 1;
end


filePattern = fullfile(directory, fileType);
tiffFiles = dir(filePattern);

for i = 1:length(tiffFiles)
  firstLetters = strcat('Img',num2str(i),file);
  completeName = fullfile(directory, firstLetters);
  images{i} = imread(completeName);
  images{i} =im2uint8(images{i});
  
  if test == 0
    imageInfo = imfinfo(strcat('Img',num2str(i),file));
    exposures{i} = imageInfo.DigitalCamera.ExposureTime;
  end
  
end

%montage(images);




end