classdef dobotClass < handle
    properties
        model;
        simulation; 
        toolOffset = transl(0.06,0,0.065); 
        workspace = [-0.5 0.5 -0.5 0.5 -0.7814 0.5]; 
        qNeutral = [0,deg2rad(45),deg2rad(90),deg2rad(45),0];
        qSimulation = [0,deg2rad(45),deg2rad(90),deg2rad(45)];
    end
    methods    
%% Constructor
function self = dobotClass()
    location = transl(0,0,0);
    CreateDobot(self,location);    
end
%% Creating the Dobot both model with attachment and simulation
    function CreateDobot(self, location)
        
        pause(0.001); 
        
        name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')];
        L1 = Link('d',0.137,'a',0,'alpha',-pi/2,'offset',0,'qlim', deg2rad([-135 135]));
        L2 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2, 'qlim', deg2rad([5 80]));     
        L3 = Link('d',0,'a',0.16193,'alpha',0,'offset',0, 'qlim', deg2rad([15 170])); %pi/2 –q2 actual offset    
        L4 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2, 'qlim', [-pi/2 pi/2]);     
        L5 = Link('d',0,'a',0,'alpha',0,'offset',0, 'qlim', deg2rad([-85 85]));       
        self.model = SerialLink([L1 L2 L3 L4 L5], 'name', name);
        
        pause(0.001);
        
        name = ['DobotMovementSimulation'];
        L1 = Link('d',0.137,'a',0,'alpha',-pi/2,'offset',0,'qlim', deg2rad([-135 135]));
        L2 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2, 'qlim', deg2rad([5 80]));     
        L3 = Link('d',0,'a',0.16193,'alpha',0,'offset',0, 'qlim', deg2rad([15 170])); %pi/2 –q2 actual offset 
        L4 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2, 'qlim', [-pi/2 pi/2]); 
        self.simulation = SerialLink([L1 L2 L3 L4], 'name', name);
        
        self.model.base = location;
        self.simulation.base = location; 
        
    end 

%% Plot Stick figure of the robot 
    function PlotRobot(self,location)
    self.model.base = location; 
    self.model.plot(self.qNeutral); 
    end
%% Plot 3D model with attachment 
function plotModel3d(self)
    for linkIndex = 0:self.model.n
        [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri');
        self.model.faces{linkIndex + 1} = faceData;
        self.model.points{linkIndex + 1} = vertexData;
    end
        self.model.plot3d(self.qNeutral,'noarrow','workspace',self.workspace);
        if isempty(findobj(get(gca,'Children'),'Type','Light'))
            camlight
        end  
    self.model.delay = 0;
    for linkIndex = 0:self.model.n
        handles = findobj('Tag', self.model.name);
        h = get(handles,'UserData');
        try 
            h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                          , plyData{linkIndex+1}.vertex.green ...
                                                          , plyData{linkIndex+1}.vertex.blue]/255;
            h.link(linkIndex+1).Children.FaceColor = 'interp';
        catch ME_1
            disp(ME_1);
            continue;
        end
    end
end 
%% Plot 3D simulation Dobot - no attachments 
function plotSimulation3d(self)
    for linkIndex = 0:self.simulation.n
        [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri');
        self.simulation.faces{linkIndex + 1} = faceData;
        self.simulation.points{linkIndex + 1} = vertexData;
    end 
        self.simulation.plot3d(self.qSimulation,'noarrow','workspace',self.workspace);
        if isempty(findobj(get(gca,'Children'),'Type','Light'))
            camlight
        end  
    self.simulation.delay = 0;
    for linkIndex = 0:self.simulation.n
        handles = findobj('Tag', self.simulation.name);
        h = get(handles,'UserData');
        try 
            h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                          , plyData{linkIndex+1}.vertex.green ...
                                                          , plyData{linkIndex+1}.vertex.blue]/255;
            h.link(linkIndex+1).Children.FaceColor = 'interp';
        catch ME_1
            disp(ME_1);
            continue;
        end
    end
end 
%% Calculate Trajectory
function angleMatrix = CalculateTrajectory(self,initial_q,final_q,steps)
            scalar = lspb(0,1,steps);           
            angleMatrix = nan(steps,self.model.n);   
            
    for i = 1:steps
        angleMatrix(i,:) = (1-scalar(i))*initial_q + scalar(i)*final_q;
    end
end
%% Move Robot
function goto(self,location,steps)     
    location = location * self.toolOffset;
    robotJoints = self.model.getpos()   
    newJoints = self.model.ikcon(location) 
    jointMatrix = self.CalculateTrajectory(robotJoints, newJoints, steps); 

    for i = 1:steps                                                
       jointMatrix(i,5) = 0; 
       self.model.animate(jointMatrix(i,:)); 
       pause(0.02); 
    end
end  
%% Dobot Requirement
function requirement(self)     
    load dobot_q
    for i = 1:338
        q1REAL = dobot_q(i,1);
        q2REAL = dobot_q(i,2);
        q3REAL = dobot_q(i,3);
        q4REAL = pi - (q2REAL + q3REAL);
        
        q3MODEL = pi/2 - q2REAL + q3REAL; 
        q4MODEL = pi - (q2REAL + q3MODEL); 
        
        qMove = [q1REAL,q2REAL,q3MODEL,q4MODEL]; 
       self.simulation.animate(qMove);
       drawnow();
       pause(0.05); 
    end
end
%% draw box
function drawBox(self)  
for i = -0.2:0.005:0.2
    point = transl(0.1,i,0); 
    point = point * self.toolOffset;  
    newJoints = self.model.ikcon(point);
    self.model.animate(newJoints);
    pause(0.02);
end
for i = 0.1:0.005:0.2
    point = transl(i,0.2,0); 
    point = point * self.toolOffset;   
    newJoints = self.model.ikcon(point); 
    self.model.animate(newJoints);
    pause(0.02);
end

for i = 0.2:-0.005:-0.2
    point = transl(0.2,i,0); 
    point = point * self.toolOffset;   
    newJoints = self.model.ikcon(point); 
    self.model.animate(newJoints);
    pause(0.02);
end

for i = 0.2:-0.005:0.1
    point = transl(i,-0.2,0); 
    point = point * self.toolOffset;  
    newJoints = self.model.ikcon(point); 
    self.model.animate(newJoints);
    pause(0.02);
end
end
%% lift & lower
function lift(self,boolean)     
    if(boolean == true)
        movement = transl(0,0,0.05);
    end
    if(boolean == false)
        movement = transl(0,0,-0.05);
    end    
        jointAngles = self.model.getpos()
        endEffector = self.model.fkine(jointAngles)
        endEffector = endEffector * movement; 
        NewjointAngles = self.model.ikcon(endEffector);
        jointMatrix = self.CalculateTrajectory(jointAngles, NewjointAngles, 75);
        
    for i = 1:75                                                
       jointMatrix(i,5) = 0; 
       self.model.animate(jointMatrix(i,:)); 
       pause(0.02); 
    end           
end 

    end
end
