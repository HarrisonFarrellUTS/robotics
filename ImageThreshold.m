classdef ImageThreshold < handle
    properties
        input;
        maskedImagePlayer;
        binaryImagePlayer;
        image;
    end
    methods
        function self = ImageThreshold
            imaqhwinfo ('winvideo');
            self.input = self.startCamera();
        end
        
        %% start camera
        function feed = startCamera(self)
            camlist = webcamlist;
            cam = webcam(2);
            feed = cam;
            preview(feed);
        end
        %% take snapshot
        function im = takeSnapshot(self)
            im = snapshot(self.input);
        end
        %% binarise Image
        function binaryImage = thresholdImage(self, image)
            I = rgb2lab(image);
            % Define thresholds for channel 1 based on histogram settings
            channel1Min = 0.000;
            channel1Max = 100.000;
            % Define thresholds for channel 2 based on histogram settings
            channel2Min = 5.553;
            channel2Max = 50.390;
            % Define thresholds for channel 3 based on histogram settings
            channel3Min = 9.863;
            channel3Max = 45.189;
            % Create mask based on chosen histogram thresholds
            sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
                (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
                (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
            BW = sliderBW;
            % Initialize output masked image based on input image.
            maskedRGBImage = image;
            % Set background pixels where BW is false to zero.
            maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
            maskedRGBImage(repmat(BW,[1 1 3])) = 255;
            % output the image
            binaryImage = maskedRGBImage;
            
        end
        %% Errode and dilate image
        function processedImage = erodeAndDilate(self, image)
%            SE = strel('square',2);
%             image = imerode(image,SE);
            
            SE = strel('square',5);
            processedImage = imdilate(image,SE);
            
%             SE = strel('square',5);
%             processedImage = imerode(image,SE);
%             
%             SE = strel('disk',2,4);
%             processedImage = imdilate(image,SE);
        end
        
    end
    
end

