classdef pathFinder < handle
    
    properties
        loadedImage = []
        coordStack = []
        previouslyChecked = []
        
    end
    
    methods        
%         function self = loadImage(image)
% %             self.loadedImage = image;
%         end
        
        function loadimage(self,image)
        self.loadedImage = image    
        end
        
        
        function findPath(self)
            [height, width, ~] = size(self.loadedImage);
            self.coordStack = [];
            self.previouslyChecked = zeros(height,width);
            for i = 2: height-1
                for  j = 2: width-1
                    if(self.previouslyChecked(i,j) == 0)
                        if(checkcell(i,j))
                            self.coordStack = [self.coordStack; i,j];
                            checkSurronding(i,j);
                        end
                        self.previouslyChecked(i,j) = 1;
                    end
                end
            end
            self.previouslyChecked
            self.coordStack
        end
        function result = checkcell(self,i,j)
            image =self.loadedImage;
            current = [image(i-1,j-1),image(i-1,j),image(i-1,j+1);...
                image(i,j-1), image(i,j),image(i,j+1);...
                image(i+1,j-1), image(i+1,j), image(i+1,j+1)];
            result = 0;
            if mean(current) > 141
                result = 1;
            end
            
            
            function checkSurronding(self,i,j)
                path = 0;
                x = i-1;
                y = j-1;
                if(self.previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                x = i-1;
                y = j;
                if(self.previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                
                x = i-1;
                y = j+1;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                x = i;
                y = j-1;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                
                x = i;
                y = j+1;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                
                x = i+1;
                y = j-1;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                x = i+1;
                y = j;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end
                x = i+1;
                y = j+1;
                if(previouslychecked(x,y) == 0)
                    if(checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                    end
                    checkSurronding(x,y)
                end                
                if path == 0
                    self.coordStack = [self.coordStack ; [999 999]];
                end                
            end
        end
    end
end
