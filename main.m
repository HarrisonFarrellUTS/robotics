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
point = transl(0.15,0.15,0); 
dobot.requirement(); 

%% 
%     load dobot_q
%     for i = 1:338
%         q1 = dobot_q(i,1);
%         q2 = dobot_q(i,2);
%         q3 = dobot_q(i,3);
%         q4 = pi - (q2 + q3); 
%         qMove = [q1,q2,q3,q4]; 
%        dobot.simulation.animate(qMove);
%        drawnow();
%        pause(0.08); 
%     end
