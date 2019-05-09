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
            self.input = startCamera(self);
            self.maskedImagePlayer = vision.VideoPlayer
            self.binaryImagePlayer = vision.VideoPlayer
        end
        
        function TakeSnapshot(self)
            self.image = takeSnapshot(self.input);
        end
        
        %% start camera
        function feed = startCamera(self)
            camlist = webcamlist;
            cam = webcam(1)
            feed = cam;
            % start(feed);
            preview(feed);
        end
        
        %% take snapshot
        function im = takeSnapshot(vid)
            im = snapshot(vid);
        end
        
        function binaryImage = thresholdImage(image, maskedImagePlayer, binaryImagePlayer)
            
            I = image;
            
            channel1Min = 100.000;
            channel1Max = 255.000;
            
            % Define thresholds fora channel 2 based on histogram settings
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
            maskedRGBImage(repmat(BW,[1 1 3])) = 1;
            
            pause
            maskedImagePlayer(maskedRGBImage)
            
            binaryImage = maskedRGBImage;
            
            
            % if not black make white
            
            %
            %  im = im2double(image);
            %  [r c p] = size(im);
            %  imR = squeeze(im(:,:,1));
            %  imG = squeeze(im(:,:,2));
            %  imB = squeeze(im(:,:,3));
            %  imbinaryR = im2bw(imR,graythresh(imR));
            %  imbinaryG = im2bw(imG,graythresh(imG));
            %  imbinaryB = im2bw(imB,graythresh(imB));
            %
            %  binaryImage = imcomplement(imbinaryR&imbinaryG&imbinaryB);
            %  binaryImagePlayer(binaryImage);
            
            
        end
        
        
        
        
    end
    
end

