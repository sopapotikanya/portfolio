function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 02-Jun-2019 23:42:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)
addpath('../');
addpath('../my_function/');
cameraOrientation = [1     0     0;
                     0     0    -1;
                     0     1     0];
cameraLocation = [0 0 0];
plotCamera('Location',cameraLocation,'Orientation',cameraOrientation,'Opacity',0,'Size',10,'Parent',handles.axes_simulate);
grid(handles.axes_simulate,'on')
set(findall(handles.uipanel_sphere, '-property', 'enable'), 'enable', 'off')
% Choose default command line output for GUI
handles.output = hObject;
handles.cameraLocation = cameraLocation;
handles.cameraOrientation = cameraOrientation;
handles.objectPoints = [];
handles.mirrorType = 'flat';
handles.startpointMirror = [0;150;0];
handles.normalMirror = [0;-1;0];
handles.centerSphere = [0;150;0];
handles.radiusSphere = 50;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu_mirrorType.
function popupmenu_mirrorType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mirrorType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mirrorType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mirrorType
contents = cellstr(get(hObject,'String'));
if strcmp(contents{get(hObject,'Value')},'Flat Mirror')
    set(findall(handles.uipanel_plane, '-property', 'enable'), 'enable', 'on')
    set(findall(handles.uipanel_sphere, '-property', 'enable'), 'enable', 'off')
    mirrorType = 'flat';
else
    set(findall(handles.uipanel_sphere, '-property', 'enable'), 'enable', 'on')
    set(findall(handles.uipanel_plane, '-property', 'enable'), 'enable', 'off')
    mirrorType = 'sphere';
end
handles.mirrorType = mirrorType;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_mirrorType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mirrorType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Sx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Sx as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Sx as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Sx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Sx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Gx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Gx as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Gx as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Gx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Ex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Ex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Ex as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Ex as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Ex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Ex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Sy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Sy as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Sy as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Sy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Sy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Gy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Gy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Gy as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Gy as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Gy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Gy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Ey_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Ey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Ey as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Ey as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Ey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Ey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Sz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Sz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Sz as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Sz as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Sz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Sz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Gz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Gz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Gz as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Gz as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Gz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Gz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_Ez_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_Ez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_Ez as text
%        str2double(get(hObject,'String')) returns contents of edit_point_Ez as a double


% --- Executes during object creation, after setting all properties.
function edit_point_Ez_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_Ez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Px_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Px as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Px as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Px_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Py_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Py as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Py as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Py_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Pz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Pz as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Pz as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Pz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Nz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Nz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Nz as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Nz as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Nz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Nz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Ny_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Ny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Ny as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Ny as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Ny_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Ny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plane_Nx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plane_Nx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plane_Nx as text
%        str2double(get(hObject,'String')) returns contents of edit_plane_Nx as a double


% --- Executes during object creation, after setting all properties.
function edit_plane_Nx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plane_Nx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sphere_Cz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sphere_Cz as text
%        str2double(get(hObject,'String')) returns contents of edit_sphere_Cz as a double


% --- Executes during object creation, after setting all properties.
function edit_sphere_Cz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sphere_Cy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sphere_Cy as text
%        str2double(get(hObject,'String')) returns contents of edit_sphere_Cy as a double


% --- Executes during object creation, after setting all properties.
function edit_sphere_Cy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sphere_Cx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sphere_Cx as text
%        str2double(get(hObject,'String')) returns contents of edit_sphere_Cx as a double


% --- Executes during object creation, after setting all properties.
function edit_sphere_Cx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sphere_Cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_palne_gen.
function pushbutton_palne_gen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_palne_gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cameraLocation = handles.cameraLocation;
cameraOrientation = handles.cameraOrientation;
Nx = str2double(get(handles.edit_plane_Nx,'String'));
Ny = str2double(get(handles.edit_plane_Ny,'String'));
Nz = str2double(get(handles.edit_plane_Nz,'String'));
Pmx = str2double(get(handles.edit_plane_Px,'String'));
Pmy = str2double(get(handles.edit_plane_Py,'String'));
Pmz = str2double(get(handles.edit_plane_Pz,'String'));
Nm  = [Nx; Ny; Nz];
mp = [Pmx; Pmy; Pmz];

handles.startpointMirror = mp;
handles.normalMirror = Nm;
guidata(hObject, handles);
plotSimulate(handles)
% --- Executes on button press in pushbutton_sphere_gen.
function pushbutton_sphere_gen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sphere_gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cameraLocation = handles.cameraLocation;
cameraOrientation = handles.cameraOrientation;
Cx = str2double(get(handles.edit_sphere_Cx,'String'));
Cy = str2double(get(handles.edit_sphere_Cy,'String'));
Cz = str2double(get(handles.edit_sphere_Cz,'String'));
radiusSphere = str2double(get(handles.edit_radius,'String'));
centerSphere  = [Cx; Cy; Cz];

handles.centerSphere = centerSphere;
handles.radiusSphere = radiusSphere;
guidata(hObject, handles);
plotSimulate(handles)

% --- Executes on button press in pushbutton_addPoints.
function pushbutton_addPoints_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Sx = str2double(get(handles.edit_point_Sx,'String'));
Gx = str2double(get(handles.edit_point_Gx,'String'));
Ex = str2double(get(handles.edit_point_Ex,'String'));
Sy = str2double(get(handles.edit_point_Sy,'String'));
Gy = str2double(get(handles.edit_point_Gy,'String'));
Ey = str2double(get(handles.edit_point_Ey,'String'));
Sz = str2double(get(handles.edit_point_Sz,'String'));
Gz = str2double(get(handles.edit_point_Gz,'String'));
Ez = str2double(get(handles.edit_point_Ez,'String'));

P_all=[];
for pz = Sz:Gz:Ez
    for py= Sy:Gy:Ey
        for px= Sx:Gx:Ex
            P_all = cat(1,P_all,[px,py,pz]);
        end
    end
end

handles.objectPoints = cat(1,handles.objectPoints,P_all);

guidata(hObject, handles);
plotSimulate(handles)

% --- Executes on button press in pushbutton_clearPoints.
function pushbutton_clearPoints_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clearPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.objectPoints = [];
guidata(hObject, handles);

plotSimulate(handles)

% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cameraLocation = handles.cameraLocation;
cameraOrientation = handles.cameraOrientation;
mirrorType = handles.mirrorType;
startpointMirror = handles.startpointMirror;
normalMirror = handles.normalMirror;
centerSphere = handles.centerSphere;
radius = handles.radiusSphere;
objectPoints = handles.objectPoints;
if strcmp(mirrorType,'flat')            % flat mirror
    [pointMirror,localNormal] = reflexPoint(objectPoints,mirrorType,normalMirror,startpointMirror);
elseif strcmp(mirrorType,'sphere')      % sphere mirror
    [pointMirror,localNormal] = reflexPoint(objectPoints,mirrorType,centerSphere,radius);
end
axes(handles.axes_simulate);
hold on
plot3(pointMirror(:,1),pointMirror(:,2),pointMirror(:,3),'*')
hold off

focus = 10;
point_img = zeros(size(pointMirror));
for i=1:size(pointMirror,1)
    point_img(i,:) = focus*pointMirror(i,:)/pointMirror(i,2);
end

axes(handles.axes_image);
scatter(point_img(:,1),point_img(:,3))
hold on
Sx = str2double(get(handles.edit_point_Sx,'String'));
Gx = str2double(get(handles.edit_point_Gx,'String'));
Ex = str2double(get(handles.edit_point_Ex,'String'));
Sy = str2double(get(handles.edit_point_Sy,'String'));
Gy = str2double(get(handles.edit_point_Gy,'String'));
Ey = str2double(get(handles.edit_point_Ey,'String'));
nLinesx = floor((Ex - Sx)/Gx) +1;
nLinesy = floor((Ey - Sy)/Gy) +1;
for i=1:nLinesy
    % spline
    x = point_img((i-1)*nLinesx+1:(i)*nLinesx,1);
    y = point_img((i-1)*nLinesx+1:(i)*nLinesx,3);
    sp(i) = spline(x,y);
    xx = linspace(min(x),max(x),100);
    yy_sp = csapi(x,y,xx);
    plot(xx,yy_sp,'k-')

    % B-spline
    Bsp(i)=fn2fm(sp(i),'B-');
    yy_Bsp=fnval(Bsp(i),x);

    % diff B-spline
    Bsp_diff(i) = fnder(Bsp(i));
    yy_Bsp_diff=fnval(Bsp_diff(i),x);

    % 2n diff B-spline
    Bsp_diff2(i) = fnder(Bsp_diff(i));
    yy_Bsp_diff2=fnval(Bsp_diff2(i),x);
end
hold off

cla(handles.axes_1diff)
axes(handles.axes_1diff)
hold on
for i=1:6
    fnplt(Bsp_diff(i));
end
hold off

cla(handles.axes_2diff)
axes(handles.axes_2diff)
hold on
for i=1:6
    fnplt(Bsp_diff2(i));
end
hold off



function plotSimulate(handles)
cameraLocation = handles.cameraLocation;
cameraOrientation = handles.cameraOrientation;
mirrorType = handles.mirrorType;
startpointMirror = handles.startpointMirror;
normalMirror = handles.normalMirror;
centerSphere = handles.centerSphere;
radius = handles.radiusSphere;
objectPoints = handles.objectPoints;

axes(handles.axes_simulate);
plotCamera('Location',cameraLocation,'Orientation',cameraOrientation,'Opacity',0,'Size',10,'Parent',handles.axes_simulate);
hold on
if strcmp(mirrorType,'flat')
    plotMirror(startpointMirror,normalMirror,-100:100,-100:100);
elseif strcmp(mirrorType,'sphere')
    plotSphere(centerSphere,radius)
end
if ~isempty(objectPoints)
    plot3(objectPoints(:,1),objectPoints(:,2),objectPoints(:,3),'*');
end
hold off
grid on
axis equal
