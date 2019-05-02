classdef dobotClass
    properties
        model;
        %simulation environment size
        workspace = [-0.5 2 -0.5 -0.5 2]; 
    end
    
    methods    
%% Creating the Dobot and plotting into the workspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function self = DobotModel(location)
        self.CreateDobot(); 
        self.PlotRobot(location); 
    end

%% Creating the Dobot with all the links
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function CreateDobot(self)
        pause(0.001); 
    name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')];
    L1 = Link('d',0.15185,'a',0,'alpha',pi/2,'offset',0,'qlim', deg2rad([-135,135]));
    L2 = Link('d',0,'a',-0.24355,'alpha',0,'offset',-pi/2, 'qlim', deg2rad([5,80])); 
    L3 = Link('d',0,'a',-0.2132,'alpha',0,'offset',0, 'qlim', deg2rad([15,170])); %pi/2 –q2 actual offset
    L4 = Link('d',0.11235,'a',0,'alpha',pi/2,'offset',0, 'qlim', [-pi/2,pi/2]); 
    L5 = Link('d',0.08535,'a',0,'alpha',-pi/2,'offset',0, 'qlim', deg2rad([-85,85]));
    self.model = SerialLink([L1 L2 L3 L4 L5], 'name', name);
    end 

%% Plotting the Robot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function PlotRobot(self,location)
    self.model.base = location; 
    self.model.plot(self.qNeutral,'workspace',self.workspace,'noarrow','scale',0.1);
    end

%% goto Point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gotoPoint(self,location,steps)     
    robotJoints = self.model.getpos()                               %getting the pose of the robot
    newJoints = self.model.ikcon(location)                          %getting the pose of the robot  
    jointMatrix = self.CalculateTrajectory(robotJoints, newJoints, steps); %creating a matrix of steps from current to endpoint
    self.TransformLog(robotJoints,newJoints);                     %log robot's transform

    for i = 1:steps                                                 %iterating throught the matrix
       self.model.animate(jointMatrix(i,:)); 
       pause(0.02); 
    end
end  

    end
end

