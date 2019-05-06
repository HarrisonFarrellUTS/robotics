clc
close all
clear all
clear
closepreview

imaqhwinfo ('winvideo')
input = startCamera();
maskedImagePlayer = vision.VideoPlayer;
binaryImagePlayer = vision.VideoPlayer;


while(1)
    
image = takeSnapshot(input);
binaryImage = thresholdImage(image, maskedImagePlayer, binaryImagePlayer);
end

%% start camera
function feed = startCamera
cam = webcam(2);
feed = cam;
preview(feed);
end

%% take snapshot
function im = takeSnapshot(vid)
% disp('Press a key to snapshot !')  % Press a key here.You can see the message 'Paused: Press any key' in        % the lower left corner of MATLAB window.
% pause;
% closepreview(vid);
im = snapshot(vid);
% stop(vid)
% delete(vid)
% figure, imshow(im);
end

function binaryImage = thresholdImage(image, maskedImagePlayer, binaryImagePlayer)
channel1Min = 100.000;
channel1Max = 255.000;
% Define thresholds fora channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 100.000;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 100.000;
sliderBW = (image(:,:,1) >= channel1Min ) & (image(:,:,1) <= channel1Max) & ...
    (image(:,:,2) >= channel2Min ) & (image(:,:,2) <= channel2Max) & ...
    (image(:,:,3) >= channel3Min ) & (image(:,:,3) <= channel3Max);
BW = sliderBW; 
% Initialize output masked image based on input image.
maskedRGBImage = image;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
maskedRGBImage(repmat(BW,[1 1 3])) = 255;
maskedImagePlayer(maskedRGBImage);

maskedRGBImage = imfill(maskedRGBImage);
binaryImagePlayer(maskedRGBImage);

binaryImage = maskedRGBImage;
end

%% class stuff
% classdef ImageThreshold < handle
%     properties
%         
%     end
%     methods
%         
%     end
%     
% end