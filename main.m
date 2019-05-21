%%%%%%%%%%%%%%%%%%%%%
%%NOTES


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

%% 
dobot.PlotAndColourRobot(location);
%dobot.PlotRobot(location);
dobot.model.teach();
camlight();
