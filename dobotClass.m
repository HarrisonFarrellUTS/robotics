classdef dobotClass < handle
    properties
        model;
        simulation; 
        workspace = [-0.5 0.5 -0.5 0.5 -0.7814 0.5]; 
        qNeutral = [0,deg2rad(45),deg2rad(90),deg2rad(45),0];
        qSimulation = [0,deg2rad(45),deg2rad(90),deg2rad(45)];
    end
    methods    
%% Constructor
    function self = dobotClass(location)
        CreateDobot(self,location)        
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
function plotModel3d(self, location)
    for linkIndex = 0:self.model.n
        [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri');
        self.model.faces{linkIndex + 1} = faceData;
        self.model.points{linkIndex + 1} = vertexData;
    end
        self.model.base = location; 
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
function plotSimulation3d(self, location)
    for linkIndex = 0:self.simulation.n
        [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri');
        self.simulation.faces{linkIndex + 1} = faceData;
        self.simulation.points{linkIndex + 1} = vertexData;
    end

        self.simulation.base = location; 
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
%% Dobot Requirement
function requirement(self)    
    location = transl(0,0,0); 
    self.CreateDobot(location); 
    plotSimulation3d(self, location)
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
%% goto Point
function goTo(self,location,steps)  
    
    a2 = 0.1393;
    a3 = 0.16193;
    x = location(1,4)
    y = location(2,4)
    z = location(3,4)    
    
    robotJoints = self.model.getpos()  
    ikconJoints = self.model.ikcon(location); 

    l = sqrt(x^2 + y^2); 
    d = sqrt(l^2 + z^2);
    
    t1 = atan(z/l); 
    t2 = acos(( (a2^2) + (d^2) - (a3^2) )/(2*d*a2));
    
    a = t1 + t2;
    b = acos((a2^2) + (a3^2) - (d^2)/(2*a2*a3));
    
    q1REAL = atan2(y,x);
    q2REAL = pi/2 - a;
    q3REAL = pi - (a + b);
    q4REAL = pi/2 - (q3REAL);
    q5 = 0;
    
    q3MODEL = pi/2 - q2REAL + q3REAL; 
    q4MODEL = pi - (q2REAL + q3MODEL);
        
    newJointsREAL = [q1REAL,q2REAL,q3REAL,q4REAL,q5];
    newJointsMODEL = [q1REAL, q2REAL, q3MODEL, q4MODEL, q5];
    real = rad2deg(newJointsREAL)
    model = rad2deg(newJointsMODEL)
    ikcon = rad2deg(ikconJoints)
end 
    end
end

