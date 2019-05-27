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
            self.Width = Width;
            self.Height = Height;
        end
        function drawStack(self)
            sz = size(self.coordStack);
            for i = 1:sz(1)
                z = self.coordStack(i,:);
                x = z(1);
                y = z(2);
                if(x == 999 && y == 999)
                    self.Dobot.draw = 0;
                    self.Dobot.lift(true);
                else
                    if(self.previouslyDrawn(x,y) == 0)
                        disp('nextPoint');
                        disp(x);
                        disp(y);
                        if(self.Dobot.draw == 0)
                            self.Dobot.draw = 1;
                            self.Dobot.lift(false);
                        end
                        % Size of a4 page 0.21mx 0.297m
                        % Size fo camera  480  x  640
                        x1 = x * 0.21/480;
                        y1 = y * 0.297/640;
                        pos = transl(x1,y1,0);
                        self.Dobot.goto(pos,2);
                        self.setSurrondinngCells(x,y);
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

