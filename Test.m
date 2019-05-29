function setSurrondinngCells(self,x,y)
if y>2
    self.previouslyDrawn(x,y-1) = 1;
    self.previouslyDrawn(x,y+1) = 1;
    self.previouslyDrawn(x,y+2) = 1;
    
    self.previouslyDrawn(x+1,y-1) = 1;
    self.previouslyDrawn(x+1,y) = 1;
    self.previouslyDrawn(x+1,y+1) = 1;
    self.previouslyDrawn(x+1,y+2) = 1;
    
    self.previouslyDrawn(x+2,y-1) = 1;
    self.previouslyDrawn(x+2,y) = 1;
    self.previouslyDrawn(x+2,y+1) = 1;
    self.previouslyDrawn(x+2,y+2) = 1;
    
end
if y>3
    self.previouslyDrawn(x,y-2) = 1;
    self.previouslyDrawn(x+1,y-2) = 1;
    self.previouslyDrawn(x+2,y-2) = 1;
end

if (x>2)
    if y>2
        self.previouslyDrawn(x-1,y-1) = 1;
        self.previouslyDrawn(x-1,y) = 1;
        self.previouslyDrawn(x-1,y+1) = 1;
        self.previouslyDrawn(x-1,y+2) = 1;
        if y>3
            self.previouslyDrawn(x-1,y-2) = 1;
        end
    end
end

if (x>3)
    if y>2
        self.previouslyDrawn(x-2,y-1) = 1;
        self.previouslyDrawn(x-2,y) = 1;
        self.previouslyDrawn(x-2,y+1) = 1;
        self.previouslyDrawn(x-2,y+2) = 1;
        if y>3
            self.previouslyDrawn(x-2,y-2) = 1;
        end
    end
end
end