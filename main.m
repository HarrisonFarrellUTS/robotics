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
dobot = dobotClass();
dobot.plotModel3d();
environment(dobot.model.base());
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

image = imread('image1.jpeg');

[width,height,~] = size(image);

PathFinder = pathFinder();

PathFinder.loadimage(image);

PathFinder.findPath;

stack = PathFinder.coordStack;

%dobot.goto(0.1,0.1,5,0);

PathFollwer = pathFollow(stack, width, height, dobot);

PathFollwer.drawStack();

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
hold on;
% dobot = dobotClass();


New_Gui


