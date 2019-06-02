classdef PathFinder < handle
    
    properties
        loadedImage = []
        coordStack = []
        previouslyChecked
        ImageHeight
        ImageWidth
        
    end
    
    methods
        
        function Loadimage(self,image)
            self.loadedImage = image;
            [self.ImageHeight, self.ImageWidth, ~] = size(self.loadedImage);
            self.coordStack = [];
            self.previouslyChecked = zeros(self.ImageHeight,self.ImageWidth);
        end
             
        function FindPath(self)
            
            for i = 2:1:(self.ImageHeight-1)
                for  j = 2:1:(self.ImageWidth-1)
                    if(self.previouslyChecked(i,j) == 0)
                        if(self.Checkcell(i,j))
                            self.coordStack = [self.coordStack ; i,j];
                            self.CheckSurronding(i,j);
                        end
                        self.previouslyChecked(i,j) = 1;
                    end
                end
            end
            self.previouslyChecked;
        end
        
        function result = Checkcell(self,i,j)
            if (~((i<2)||(i>self.ImageHeight)||(j<2)||(j>self.ImageWidth)))
                image =self.loadedImage;
                current = [image(i-1,j-1),image(i-1,j),image(i-1,j+1);...
                    image(i,j-1), image(i,j),image(i,j+1);...
                    image(i+1,j-1), image(i+1,j), image(i+1,j+1)];
                result = 0;
                if mean(current) > 141
                    result = 1;
                end
            else
                result = 0;
            end
            
        end
        
        function CheckSurronding(self,i,j)
            path = 0;
            self.previouslyChecked(i,j) = 1;
            if(i>1)
                if(j>1)
                    x = i-1;
                    y = j-1;
                    if(self.previouslyChecked(x,y) == 0)
                        if(self.Checkcell(x,y))
                            self.coordStack = [self.coordStack; x,y];
                            path = 1;
                            self.CheckSurronding(x,y)
                        end
                        
                    end
                end
                x = i-1;
                y = j;
                if(self.previouslyChecked(x,y) == 0)
                    if(self.Checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                        self.CheckSurronding(x,y)
                    end
                end
                if(j>self.ImageWidth-1)
                    x = i-1;
                    y = j+1;
                    if(self.previouslyChecked(x,y) == 0)
                        if(self.Checkcell(x,y))
                            self.coordStack = [self.coordStack; x,y];
                            path = 1;
                            self.CheckSurronding(x,y)
                        end
                    end
                end
            end
            if(j>1)
                x = i;
                y = j-1;
                if(self.previouslyChecked(x,y) == 0)
                    if(self.Checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                        self.CheckSurronding(x,y)
                    end
                end
            end
            
            if(j>self.ImageWidth-1)
                x = i;
                y = j+1;
                if(self.previouslyChecked(x,y) == 0)
                    if(self.Checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                        self.CheckSurronding(x,y)
                    end
                end
            end
            
            if(i<self.ImageHeight-1)
                if(j>1)
                    x = i+1;
                    y = j-1;
                    if(self.previouslyChecked(x,y) == 0)
                        if(self.Checkcell(x,y))
                            self.coordStack = [self.coordStack; x,y];
                            path = 1;
                            self.CheckSurronding(x,y)
                        end
                    end
                end
                
                x = i+1;
                y = j;
                if(self.previouslyChecked(x,y) == 0)
                    if(self.Checkcell(x,y))
                        self.coordStack = [self.coordStack; x,y];
                        path = 1;
                        self.CheckSurronding(x,y)
                    end
                end
                if(j < self.ImageWidth-1)
                    x = i+1;
                    y = j+1;
                    if(self.previouslyChecked(x,y) == 0)
                        if(self.Checkcell(x,y))
                            self.coordStack = [self.coordStack; x,y];
                            path = 1;
                            self.CheckSurronding(x,y)
                        end
                    end                
                end
            end
            if(path == 0)
                self.coordStack = [self.coordStack ; [999 999]];
            end
        end
        
    end
end
