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
%% running the requirement movements
dobot = dobotClass();
dobot.plotSimulation3d();
dobot.requirement();
%% drawing a box
dobot = dobotClass();
dobot.plotModel3d();
environment(dobot.model.base());

for i = 0:1:3
    dobot.drawBox(); 
end

%% 

% location = transl(0,0,0); 
% dobot = dobotClass(location); 
% point = transl(0.2,-0.2,0); 
%  
% dobot.plotModel3d(location);
% safety = environment(location);
% dobot.model.teach();
% %dobot.goTo(point)