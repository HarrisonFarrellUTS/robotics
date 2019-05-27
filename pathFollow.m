classdef pathFollow < handle
    %Takes a coord stack, width, height and dobot
    properties
        coordStack
        Width
        Height
        previouslyDrawn
        Dobot
    end
    
    methods
        function self = pathFollow(self,Stack,Width,Height,Dobot)
            self.coordStack = Stack;
            self.previouslyDrawn = zeros(Height,Width);
            self.Dobot = Dobot;
        end
        function drawStack(self)
            for i = 1:height(self.coordStack)
                %                 dobotDraw = 1
                [x,y] = self.coordStack(i,:);
                if(x = 999 & y = 999)
                    %                     draw = 0
                end

                if(1)%draw = 1)
                    if(self.previouslyDrawn(x,y) == 0)
                        %robot Goto xy
                        setSurrondingCells(x,y)
                    end
                end
                
            end
        end
        
        function setSurrondinngCells(self,x,y)
            self.previouslyDrawn(x,y) = 1;
            if(x>=2)
                self.previouslyDrawn(x-1,y) = 1;
                if(y>=2)
                    self.previouslyDrawn(x-1,y-1) = 1;
                    self.previouslyDrawn(x,y-1) = 1;
                end
                if(y<self.Width)
                    self.previouslyDrawn(x-1,y+1) = 1;
                    self.previouslyDrawn(x,y+1) = 1;
                end
            end
            if(x<self.Height)
                self.previouslyDrawn(x+1,y) = 1;
                if(y>=2)
                    self.previouslyDrawn(x+1,y-1) = 1;
                end
                if(y<self.Width)
                    self.previouslyDrawn(x+1,y+1) = 1;
                end
            end
        end
    end
end

