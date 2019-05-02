clc
close all
clear all
clear
closepreview

imaqhwinfo ('winvideo')
input = startCamera();
while(1)
    
image = takeSnapshot(input);
binaryImage = thresholdImage(image);

end

%% start camera
function feed = startCamera
camlist = webcamlist;

cam = webcam(2)
feed = cam;
% start(feed);
preview(feed);
end

%% take snapshot
function im = takeSnapshot(vid)
disp('Press a key to snapshot !')  % Press a key here.You can see the message 'Paused: Press any key' in        % the lower left corner of MATLAB window.
pause;
% closepreview(vid);
im = snapshot(vid);
% stop(vid)
% delete(vid)
figure, imshow(im);
end

function binaryImage = thresholdImage(image)

I = image;

channel1Min = 100.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 100.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 100.000;

sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW; 

% Initialize output masked image based on input image.
maskedRGBImage = image;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;


figure, imshow(maskedRGBImage)
binaryImage = maskedRGBImage;
% im = im2double(image);
% [r c p] = size(im);
% imR = squeeze(im(:,:,1));
% imG = squeeze(im(:,:,2));
% imB = squeeze(im(:,:,3));
% imbinaryR = im2bw(imR,graythresh(imR));
% imbinaryG = im2bw(imG,graythresh(imG));
% imbinaryB = im2bw(imB,graythresh(imB));
% 
% binaryImage = imcomplement(imbinaryR&imbinaryG&imbinaryB);


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