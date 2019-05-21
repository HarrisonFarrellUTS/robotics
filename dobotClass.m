classdef dobotClass < handle
    properties
        model;
        %simulation environment size
        workspace = [-0.5 0.5 -0.5 0.5 -0.5 0.5]; 
        qNeutral = [0,deg2rad(45),deg2rad(90),deg2rad(45),0];
    end
    
    methods    
%% Creating the Dobot and plotting into the workspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function self = dobotClass(location)
        self.CreateDobot(); 
        %self.PlotRobot(location); 
    end

%% Creating the Dobot with all the links
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function CreateDobot(self)
        pause(0.001); 
        name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')];
        %Base Angle = q1
        %Rear Arm Angle = q2
        %Fore Arm Angle = q3
        %N/A 
        %Servo Angle = q5
        L1 = Link('d',0.137,'a',0,'alpha',-pi/2,'offset',0,'qlim', deg2rad([-135 135]));
        L2 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2, 'qlim', deg2rad([5 80]));     
        L3 = Link('d',0,'a',0.16193,'alpha',0,'offset',0, 'qlim', deg2rad([15 170])); %pi/2 –q2 actual offset    
        L4 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2, 'qlim', [-pi/2 pi/2]);     
        L5 = Link('d',0,'a',0,'alpha',0,'offset',0, 'qlim', deg2rad([-85 85]));
        
        self.model = SerialLink([L1 L2 L3 L4 L5], 'name', name);
    end 

%% Plotting the Robot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function PlotRobot(self,location)
    self.model.base = location; 
    self.model.plot(self.qNeutral); 
    %self.model.plot(self.qNeutral,'workspace',self.workspace,'noarrow','scale',0.1);
    end
%% PlotAndColourRobot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given a robot index, add the glyphs (vertices and faces) and
% colour them in if data is available 
function PlotAndColourRobot(self, location)%robot,workspace)
    for linkIndex = 0:self.model.n
        [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
        self.model.faces{linkIndex + 1} = faceData;
        self.model.points{linkIndex + 1} = vertexData;
    end
        % Display robot
        self.model.base = location; 
        self.model.plot3d(self.qNeutral,'noarrow','workspace',self.workspace); %zeros(1,self.model.n)
        if isempty(findobj(get(gca,'Children'),'Type','Light'))
            camlight
        end  
    self.model.delay = 0;
    % Try to correctly colour the arm (if colours are in ply file data)
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
%% goto Point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gotoPoint(self,location,steps)     
    robotJoints = self.model.getpos()                               %getting the pose of the robot
    % finding the q1
    l = sqrt(x^2+y^2); %the lenght to the endpoint in 2D space
    theta = atan(y/x); %the rotation angle
    % finding the q2 & q3
    l = sqrt(x^2+y^2); %the lenght to the endpoint in 2D space
    d = sqrt(x^2+y^2); %the lenght to the endpoint in 3D space
    t1 = atan(z/l); %The angle between line D and sideTwo
    t2 = acos((sideTwo^2 + d^2 - sideThree^2)/ 2*sideTwo*sideThree)
end 
%% Calculate Trajectory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function angleMatrix = CalculateTrajectory(self,robotA_q1,robotB_q2,steps)
            scalar = lspb(0,1,steps);           
            angleMatrix = nan(steps,6);        
    for i = 1:steps
        angleMatrix(i,:) = (1-scalar(i))*robotA_q1 + scalar(i)*robotB_q2;
    end
end
    end
end

