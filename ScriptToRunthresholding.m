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
    
image  = imgur.TakeSnapshot();
newimage = imgur.ThresholdImage(image);

processsedImage = imgur.ErodeAndDilate(newimage);

maskedImagePlayer(image);
binaryImagePlayer(newimage);
erodeImagePlayer(processsedImage);

imwrite(processsedImage,'image1.jpeg')
pause

end




%%


