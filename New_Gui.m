function varargout = New_Gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @New_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @New_Gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



function New_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
   
handles.GoToX = 0;
handles.GoToY = 0;
handles.GoToZ = 0;
handles.MoveRate = 0.01;

handles.q1 = 0
handles.q2 = 45
handles.q3 = 90 

handles.dobot = DobotClass();
axes(handles.axes1)
handles.dobot.PlotModel3d();
% environment(handles.dobot.model.base());
image = imread('image1.jpeg');
axes(handles.axes2)
imshow(image)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Joint_1_Slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function Joint_2_Slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function Joint_3_Slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function X_Coord_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Y_Coord_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Z_Coord_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Outputs from this function are returned to the command line.
function varargout = New_Gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on slider movement.
function Joint_1_Slider_Callback(hObject, eventdata, handles)
handles.q1 = get(hObject, 'Value');
q1 = deg2rad(handles.q1);
q2 = deg2rad(handles.q2);
q3 = deg2rad(handles.q3);

handles.dobot.moveBothJoints(q1,q2,q3);
guidata(hObject, handles);

% --- Executes on slider movement.
function Joint_2_Slider_Callback(hObject, eventdata, handles)
handles.q2 = get(hObject, 'Value');
q1 = deg2rad(handles.q1);
q2 = deg2rad(handles.q2);
q3 = deg2rad(handles.q3);


handles.dobot.moveBothJoints(q1,q2,q3);
guidata(hObject, handles);

% --- Executes on slider movement.
function Joint_3_Slider_Callback(hObject, eventdata, handles)
handles.q3 = get(hObject, 'Value');
q1 = deg2rad(handles.q1);
q2 = deg2rad(handles.q2);
q3 = deg2rad(handles.q3);

handles.dobot.moveBothJoints(q1,q2,q3);
guidata(hObject, handles);


function X_Coord_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of X_Coord as text
%        str2double(get(hObject,'String')) returns contents of X_Coord as a double

function Y_Coord_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Y_Coord as text
%        str2double(get(hObject,'String')) returns contents of Y_Coord as a double

function Z_Coord_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Z_Coord as text
%        str2double(get(hObject,'String')) returns contents of Z_Coord as a double





% --- Executes on button press in Go_To_Pose.
function Go_To_Pose_Callback(hObject, eventdata, handles)
% hObject    handle to Go_To_Pose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.X_Coord,'String'));
y = str2double(get(handles.Y_Coord,'String'));
z = str2double(get(handles.Z_Coord,'String'));

handles.GoToX = x;
handles.GoToY = y;
handles.GoToZ = z;

handles.dobot.GoTo(x,y,100,0);
guidata(hObject, handles);


% --- Executes on button press in Pos_X.
function Pos_X_Callback(hObject, eventdata, handles)
handles.GoToX =  handles.GoToX + handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);


% --- Executes on button press in Neg_X.
function Neg_X_Callback(hObject, eventdata, handles)
handles.GoToX = handles.GoToX -handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Neg_Y.
function Neg_Y_Callback(hObject, eventdata, handles)
handles.GoToY = handles.GoToY - handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Pos_Y.
function Pos_Y_Callback(hObject, eventdata, handles)
handles.GoToY = handles.GoToY + handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Pos_Z.
function Pos_Z_Callback(hObject, eventdata, handles)
handles.GoToZ = handles.GoToZ + handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Neg_Z.
function Neg_Z_Callback(hObject, eventdata, handles)
handles.GoToZ = handles.GoToZ - handles.MoveRate;
handles.dobot.GoTo(handles.GoToX,handles.GoToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Estop.
function Estop_Callback(hObject, eventdata, handles)
disp('stopping robot');
handles.dobot.eStop = true;
guidata(hObject, handles);

% --- Executes on button press in eStop_Reset.
function eStop_Reset_Callback(hObject, eventdata, handles)
disp('ROBOT RESET');
handles.dobot.eStop = false;
guidata(hObject, handles);
