function varargout = New_Gui(varargin)
% NEW_GUI MATLAB code for New_Gui.fig
%      NEW_GUI, by itself, creates a new NEW_GUI or raises the existing
%      singleton*.
%
%      H = NEW_GUI returns the handle to a new NEW_GUI or the handle to
%      the existing singleton*.
%
%      NEW_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_GUI.M with the given input arguments.
%
%      NEW_GUI('Property','Value',...) creates a new NEW_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before New_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to New_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help New_Gui

% Last Modified by GUIDE v2.5 01-Jun-2019 13:58:04

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before New_Gui is made visible.
function New_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to New_Gui (see VARARGIN)
    
handles.goToX = 0;
handles.goToY = 0;
handles.goToZ = 0;
handles.MoveRate = 0.01;

handles.dobot = dobotClass();
axes(handles.axes1)
handles.dobot.plotModel3d();
% environment(handles.dobot.model.base());
image = imread('image1.jpeg');
axes(handles.axes2)
imshow(image)

% Choose default command line output for New_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes New_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = New_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Joint_1_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Joint_1_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Joint_1_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_1_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Joint_2_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Joint_2_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Joint_2_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_2_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Joint_3_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Joint_3_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Joint_3_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_3_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Joint_4_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Joint_4_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Joint_4_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_4_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function X_Coord_Callback(hObject, eventdata, handles)
% hObject    handle to X_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_Coord as text
%        str2double(get(hObject,'String')) returns contents of X_Coord as a double


% --- Executes during object creation, after setting all properties.
function X_Coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_Coord_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_Coord as text
%        str2double(get(hObject,'String')) returns contents of Y_Coord as a double


% --- Executes during object creation, after setting all properties.
function Y_Coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_Coord_Callback(hObject, eventdata, handles)
% hObject    handle to Z_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_Coord as text
%        str2double(get(hObject,'String')) returns contents of Z_Coord as a double


% --- Executes during object creation, after setting all properties.
function Z_Coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_Coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Go_To_Pose.
function Go_To_Pose_Callback(hObject, eventdata, handles)
% hObject    handle to Go_To_Pose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(handles.X_Coord,'String'));
y = str2double(get(handles.Y_Coord,'String'));
z = str2double(get(handles.Z_Coord,'String'));

handles.goToX = x;
handles.goToY = y;
handles.goToZ = z;
handles.dobot.goto(x,y,100,0);
guidata(hObject, handles);


% --- Executes on button press in Pos_X.
function Pos_X_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.goToX =  handles.goToX + handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);


% --- Executes on button press in Neg_X.
function Neg_X_Callback(hObject, eventdata, handles)
% hObject    handle to Neg_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.goToX = handles.goToX -handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Neg_Y.
function Neg_Y_Callback(hObject, eventdata, handles)
% hObject    handle to Neg_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.goToY = handles.goToY - handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Pos_Y.
function Pos_Y_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.goToY = handles.goToY + handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Pos_Z.
function Pos_Z_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.goToZ = handles.goToZ + handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Neg_Z.
function Neg_Z_Callback(hObject, eventdata, handles)
% hObject    handle to Neg_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.goToZ = handles.goToZ - handles.MoveRate;
handles.dobot.goto(handles.goToX,handles.goToY,2,0);
guidata(hObject, handles);

% --- Executes on button press in Estop.
function Estop_Callback(hObject, eventdata, handles)
% hObject    handle to Estop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('stopping robot')

dobot.eStop = true;
% dobot.stopcheck;

