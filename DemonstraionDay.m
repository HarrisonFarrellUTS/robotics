%% Demonstration
clear                                                                       % clears the workspace
clc                                                                         % clears the command window
close all;                                                                  % closes all
hold on;                                                                    % holds all figures

url = 'http://172.19.118.81:8080/shot.jpg';                                 % loads the webcam data from IP webcamm (android app)
ss  = imread(url);                                                          % loads the URL image into matlab
fh = image(ss);

flag =1;                                                                    % a check flag to see if the image is finished
counter = 0;                                                                % a counter for an action inside the loop

while(flag)
    
        ss  = imread(url);                                                  
        set(fh,'CData',ss);
        drawnow;                                                            % displays the image to the user
        
    if(counter == 50)
        counter = 0;
        prompt = 'Is the picture finished? Y/N: ';                          % asks the user if the image is completed 
        str = input(prompt,'s');
        if isempty(str)
            str = 'Y';
        end
        
        if(str == 'Y' || str == 'y')
            flag = 0;
        end               
    end
    
    counter = counter + 1;
end

close all;                                                                  % closes all
hold on;                                                                    % holds all figures

rosinit('http://localhost:11311');                                          % creates the required ros node

dobot = dobotClass();                                                       % constructor for the dobot class
dobot.plotModel3d();                                                        % plots the 3D model of the dobot
environment(dobot.model.base());                                            % plots the environment using the dobot base and the centre point
dobot.drawingSpace();                                                       % creates the page for the dobot simulation to write on

[width,height,~] = size(image);                                             % sets the size of the image
pathFinder = PathFinder();                                                  % constructor for the path finder
pathFinder.LoadImage(image);                                                % loading the image into the path finder class
pathFinder.FindPath;                                                        % find the path
stack = pathFinder.coordStack;                                              % creating the stack of points to travel to 
pathFollwer = PathFollow(stack, width, height, dobot);                      % constructor of the path follower 
pathFollwer.DrawStack();                                                    % draws the image