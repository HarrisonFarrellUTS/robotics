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
%% e-stop test
point = transl(0.1,0.2,0); 
dobot.goto(point, 200);

point = transl(0.1,-0.2,0); 
dobot.goto(point, 200); 
point = transl(0.2,-0.2,0);
dobot.goto(point, 200);
point = transl(0.2,0.2,0);
dobot.goto(point, 200);
%% e-stop test
dobot.eStop = true; 

