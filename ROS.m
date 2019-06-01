% ROS commands
rosinit('http://localhost:11311');

%% Set the cartesian Position of the end effector
% Setup Varibles
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
% create and populate service request (x,y,z,r, all in metres)
cartmsg_.TargetPoints=[0.2,0,-0.1,0];
cartsvc_.call(cartmsg_)
%% Set Joint Angles
% Setup Variables
jangsvc_ = rossvcclient('/dobot_magician/PTP/set_joint_angles');
jangmsg_ = rosmessage(jangsvc_);
% Send robot to joint positions (in radians)
jangmsg_.TargetPoints = [-0.2, 0.8, 0.6, -0.4 ];
jangsvc_.call(jangmsg_);
%% Create a subscriber to view the current state of each joint
sub = rossubscriber('/dobot_magician/joint_states');
pause(1);
%receive and print latest state message
disp 'Receiving and printing latest state message ...'
statemsg_ = receive(sub,10); %timeout after 10 seconds
disp (statemsg_.Position)



%% Setup of simulation and ROS
clear
clc
close all;
hold on;
%dobot = dobotClass();
%dobot.plotModel3d();
%environment(dobot.model.base());
%dobot.drawingSpace(); 

% ros setup varibles
rosinit('http://localhost:11311');
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);

jangsvc_ = rossvcclient('/dobot_magician/PTP/set_joint_angles');
jangmsg_ = rosmessage(jangsvc_);

sub = rossubscriber('/dobot_magician/joint_states');
pause(1);

%% paper Calibration
% top left point
%dobot.goto(transl(0.31,0.105,0), 100, false); 
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
cartmsg_.TargetPoints=[0.2,0,-0.08,0];
cartsvc_.call(cartmsg_)
% top right point
%dobot.goto(transl(0.31, -0.095, 0), 100, true); 
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
cartmsg_.TargetPoints=[0.31,-0.095,-0.08,0];
cartsvc_.call(cartmsg_)
%pause;
% bottom left point
%dobot.goto(transl(0.165, 0.105, 0), 100, true); 
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
cartmsg_.TargetPoints=[0.165,0.105,-0.08,0];
cartsvc_.call(cartmsg_)
%pause();
% bottom right point
%dobot.goto(transl(0.165, -0.095, 0), 100, true); 
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
cartmsg_.TargetPoints=[0.165,-0.095,-0.08,0];
cartsvc_.call(cartmsg_)
%pause();
cartsvc_ = rossvcclient('/dobot_magician/PTP/set_cartesian_pos');
cartmsg_ = rosmessage(cartsvc_);
cartmsg_.TargetPoints=[0.31,0.105,-0.08,0];
cartsvc_.call(cartmsg_)