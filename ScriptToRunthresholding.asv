

clc
close all
clear all


maskedImagePlayer = vision.VideoPlayer;
binaryImagePlayer = vision.VideoPlayer;   
erodeImagePlayer = vision.VideoPlayer;
dilateImagePlayer = vision.VideoPlayer;

imgur = ImageThreshold;
disp('starting Loop');



while(true)
    
image  = imgur.takeSnapshot();
newimage = imgur.thresholdImage(image);

processsedImage = imgur.erodeAndDilate(newimage);

maskedImagePlayer(image);
binaryImagePlayer(newimage);
erodeImagePlayer(processsedImage);

end




%%


