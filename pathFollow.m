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
        function self = pathFollow(Stack,Width,Height,dobot)
            self.coordStack = Stack;
            self.previouslyDrawn = zeros(Width,Height);
            self.Dobot = dobot;
        end
        function drawStack(self)
            sz = size(self.coordStack);
            
            for i = 1:sz(1)
                if(self.previouslyDrawn(x,y) == 0)
                    
                    Z = self.coordStack(i,:);
                    x = Z(1);
                    y = Z(2);
                    if(x == 999 && y == 999)
                        self.Dobot.draw = 0;
                        self.Dobot.lift(true);
                    end
                    if(self.Dobot.draw == 1)
                        pos = transl(x/1000,y/1000, 0);
                        self.Dobot.goto(pos,2);
                        self.setSurrondinngCells(x,y)
                    end
                    
                    if (self.Dobot.draw == 0)
                        self.Dobot.draw = 1;
                        self.Dobot.lift(false);
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

