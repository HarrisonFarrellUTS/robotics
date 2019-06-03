%% run required movements
clear
clc
close all;
hold on;
dobot = dobotClass();
dobot.plotSimulation3d();
dobot.requirement();
%% Clear & build robot in environment
clear
clc
close all;
hold on;
dobot = DobotClass();
dobot.PlotModel3d();
Environment(dobot.model.base());
dobot.drawingSpace(); 
%dobot.model.teach()
%% lift & lower the arm
dobot.lift(true);
pause(0.5); 
dobot.lift(false); 
%% drawing a box
dobot.drawBox(); 

%%

dobot = dobotClass();
% dobot.plotSimulation3d();

image = imread('image2.jpeg');

[width,height,~] = size(image);

pathFinder = PathFinder();

pathFinder.Loadimage(image);

pathFinder.FindPath;

stack = pathFinder.coordStack;

pathFollwer = PathFollow(stack, width, height, dobot);

pathFollwer.DrawStack();

%%
url = 'https://172.19.118.81:8080/shot.jpg';
ss  = imread(url);
fh = image(ss);
while(1)
    ss  = imread(url);
    set(fh,'CData',ss);
    drawnow;
end

%% GUI implementation

clear
clc
close all;

New_Gui;


