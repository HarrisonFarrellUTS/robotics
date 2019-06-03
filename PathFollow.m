classdef PathFollow < handle
    %Takes a coord stack, width, height and dobot
    properties
        coordStack
        Width
        Height
        previouslyDrawn
        Dobot
    end
    
    methods
        function self = PathFollow(Stack,Width,Height,dobot)
            self.coordStack = Stack;
            self.previouslyDrawn = zeros(Width,Height);
            self.Dobot = dobot;
            self.Width = Width;
            self.Height = Height;
        end
        
        function DrawStack(self)
            sz = size(self.coordStack)
            for i = 1:sz(1)
                z = self.coordStack(i,:);
                x = z(1);
                y = z(2);
                if(x == 999 && y == 999)
                    self.Dobot.draw = 0;
                    %                     self.Dobot.lift(true);
                else
                    if(self.previouslyDrawn(x,y) == 0)
                                        disp(i);

                        
                        % Size of a4 page 0.105m x 0.1485m
                        % Size fo camera  480  x  640
                        y1 = y * 0.105/480;
                        y1 = y1 - 0.15;
                        
                        x1 = x * 0.1485/640;
                        x1 = x1+0.18;
                        
                        %                         self.Dobot.goto(x1,y1,4,0);
                        self.Dobot.GotoREAL(x1,y1);
                        self.SetSurrondinngCells(x,y);
                        if(self.Dobot.draw == 0)
                            self.Dobot.draw = 1;
                            %                             self.Dobot.lift(false);
                        end
                    end
                end
            end
        end
        function SetSurrondinngCells(self,x,y)
            if y>2
                self.previouslyDrawn(x,y-1) = 1;
                self.previouslyDrawn(x,y+1) = 1;
                self.previouslyDrawn(x,y+2) = 1;
                self.previouslyDrawn(x,y+3) = 1;
                
                self.previouslyDrawn(x+1,y-1) = 1;
                self.previouslyDrawn(x+1,y) = 1;
                self.previouslyDrawn(x+1,y+1) = 1;
                self.previouslyDrawn(x+1,y+2) = 1;
                self.previouslyDrawn(x+1,y+3) = 1;
                
                self.previouslyDrawn(x+2,y-1) = 1;
                self.previouslyDrawn(x+2,y) = 1;
                self.previouslyDrawn(x+2,y+1) = 1;
                self.previouslyDrawn(x+2,y+2) = 1;
                self.previouslyDrawn(x+2,y+3) = 1;
                
                self.previouslyDrawn(x+3,y-1) = 1;
                self.previouslyDrawn(x+3,y) = 1;
                self.previouslyDrawn(x+3,y+1) = 1;
                self.previouslyDrawn(x+3,y+2) = 1;
                self.previouslyDrawn(x+3,y+3) = 1;
                
                
            end
            if y>3
                self.previouslyDrawn(x,y-2) = 1;
                self.previouslyDrawn(x+1,y-2) = 1;
                self.previouslyDrawn(x+2,y-2) = 1;
                self.previouslyDrawn(x+3,y-2) = 1;    
            end
            
            if y>4
                self.previouslyDrawn(x,y-3) = 1;
                self.previouslyDrawn(x+1,y-3) = 1;
                self.previouslyDrawn(x+2,y-3) = 1;
                self.previouslyDrawn(x+3,y-3) = 1;
            end
              
            if (x>2)
                if y>2
                    self.previouslyDrawn(x-1,y-1) = 1;
                    self.previouslyDrawn(x-1,y) = 1;
                    self.previouslyDrawn(x-1,y+1) = 1;
                    self.previouslyDrawn(x-1,y+2) = 1;
                    self.previouslyDrawn(x-1,y+3) = 1;
                    if y>3
                        self.previouslyDrawn(x-1,y-2) = 1;
                        if y>4
                            self.previouslyDrawn(x-1,y-3) = 1;
                        end
                    end
                end
            end          
            if (x>3)
                if y>2
                    self.previouslyDrawn(x-2,y-1) = 1;
                    self.previouslyDrawn(x-2,y) = 1;
                    self.previouslyDrawn(x-2,y+1) = 1;
                    self.previouslyDrawn(x-2,y+2) = 1;
                    self.previouslyDrawn(x-2,y+3) = 1;
                    if y>3
                        self.previouslyDrawn(x-2,y-2) = 1;
                        if y>4
                            self.previouslyDrawn(x-2,y-3) = 1;
                        end
                    end
                end
            end
            if (x>4)
                if y>2
                    self.previouslyDrawn(x-3,y-1) = 1;
                    self.previouslyDrawn(x-3,y) = 1;
                    self.previouslyDrawn(x-3,y+1) = 1;
                    self.previouslyDrawn(x-3,y+2) = 1;
                    self.previouslyDrawn(x-3,y+3) = 1;
                    if y>3
                        self.previouslyDrawn(x-3,y-2) = 1;
                        if y>4
                            self.previouslyDrawn(x-3,y-3) = 1;
                        end
                    end
                end
            end
        end
    end
end

