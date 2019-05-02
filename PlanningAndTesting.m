%% dobot class -------------------------------
y = rand(2,1,3)

z = squeeze(y)
%% create robot 


%% ikine

%% plot in sim 
%option to plot coloured or normal

%% move to (coords x,y,z)


%% end dbot class --------------------------------------------------------
%% draw object(drawingMatix)
% for i = 1:size(drawingmatrix)
%     if(drawingmatrix(1,1) == -1)
%       move to new object
%   else
%     dotbot.movetodraw([drawingmatrix(1,1) 0])
%   end
% 
%   drawingmatrix(1,:) = []
% end

%% outputs
%scanned image
%processed image
%drawn


%% process image
%detect colour 
%
%

%%set threshold
%r [0 255]
%g [0 0]
%b [0 0]


%% move to new object to draw
%lift, move, drop
% x, y ,(z = 1)
% dobot.move

%% add to vector of stacks

a = [1 2 ; 3 4 ; 5 6]

a(1,:) = []

z = [-1 -1]

b = [7 8; 9 10; 11 12]

c = [a;z;b]

c = [c ; a]

