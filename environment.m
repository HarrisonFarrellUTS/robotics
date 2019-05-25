classdef environment < handle
    properties      
        % A cell structure of models
        model;  
        % Dimensions of the workspace
        workspaceDimensions;
        % Ply file data of each environment
        faceData = [];
        vertexData = [];
        plyData = [];
    end
    methods
      %% Creating loading the correct parts into there place  
        function self = environment(environmentNum,location)
            %coordinates of object are set when constructing object
            self.model = self.GetModel(['environment',num2str(environmentNum)],environmentNum);
            self.model.base = location;
            self.model.plot3d(0);
            camlight;
        end     
        
        %% GetModel
        function model = GetModel(self,name,environmentNum)
            if isempty(self.faceData) || isempty(self.vertexData) || isempty(self.plyData)
                [self.faceData,self.vertexData,self.plyData] = plyread(['EnvironmentPart',num2str(environmentNum),'.ply'],'tri');
                %ply file data of environments is stored for each environment
            end
            L1 = Link('alpha',0,'a',1,'d',0,'offset',0);
            model = SerialLink(L1,'name',name);
            %1 link robot used to simulate environments for simplicity
            model.faces = {self.faceData,[]};
            model.points = {self.vertexData,[]}; 
        end
        
    end    
end
