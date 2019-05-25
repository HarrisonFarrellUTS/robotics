%%%%%%%%%%%%%%%%%%%%%
%%NOTES
    %Bench Size is (BxWxH) (1.81x0.9x0.7814)
    %Fence Size is (BxWxH) (2.05x0.4x1.217)
%%NOTES
%%%%%%%%%%%%%%%%%%%%%
%% 
clear
clc
close all;
hold on;
%% Ploting the robots
%%%%%%%%%%%%%%%%%%%%%
%creation of the one robot
location = transl(0,0,0); 
dobot = dobotClass(location); 
point = transl(0.2,0.1,0); 
%dobot.requirement(); 
dobot.plotModel3d(location);
safety = environment(location);
dobot.model.teach();
dobot.goTo(point)

%% 

