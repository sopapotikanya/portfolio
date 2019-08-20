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

% Last Modified by GUIDE v2.5 02-Jun-2019 14:17:59

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
minStep = 5;
maxStep = 35;
numSteps = maxStep - minStep + 1;

default_boxW = 10;
set(handles.slider_boxW, 'Min', minStep);
set(handles.slider_boxW, 'Max', maxStep);
set(handles.slider_boxW, 'Value', default_boxW);
set(handles.slider_boxW, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);
set(handles.text_valueBoxW, 'String', num2str(default_boxW));

default_boxH = 10;
set(handles.slider_boxH, 'Min', minStep);
set(handles.slider_boxH, 'Max', maxStep);
set(handles.slider_boxH, 'Value', default_boxH);
set(handles.slider_boxH, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);
set(handles.text_valueBoxH, 'String', num2str(default_boxH));

default_Th = 0.8;
numSteps = 50;
set(handles.slider_Th, 'Min', 0);
set(handles.slider_Th, 'Max', 1);
set(handles.slider_Th, 'Value', default_Th);
set(handles.slider_Th, 'SliderStep', [1/(numSteps) , 1/(numSteps) ]);
set(handles.text_valueTh, 'String', num2str(default_Th));

addpath('../');
addpath('../my_function/');
set(handles.button_new,'Enable','off')
set(handles.togglebutton_objectDraw,'Enable','off')
set(handles.togglebutton_mirrorDraw,'Enable','off')
set(findall(handles.uipanel_detectMark, '-property', 'enable'), 'enable', 'off')
set(handles.togglebutton_removeOutlier,'Enable','off')
set(handles.pushbutton_matchPoint,'Enable','off')
set(handles.pushbutton_calLocalMirror,'Enable','off')
% Choose default command line output for GUI
handles.output = hObject;

handles.boxH = default_boxH;
handles.boxW = default_boxW;
handles.Th = default_Th;

handles.mark_all = [];
handles.mousePos = [];
handles.mirrorPos = [];
handles.objectPos = [];
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

%% ------------------------ Camera Calibration ------------------------- %%
% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.button_new,'Enable','off')
set(handles.togglebutton_objectDraw,'Enable','off')
set(handles.togglebutton_mirrorDraw,'Enable','off')
set(findall(handles.uipanel_detectMark, '-property', 'enable'), 'enable', 'off')
set(handles.togglebutton_removeOutlier,'Enable','off')
set(handles.pushbutton_matchPoint,'Enable','off')
set(handles.pushbutton_calLocalMirror,'Enable','off')

[file,path] = uigetfile('../../*.*','Select Calibration Images Set','MultiSelect', 'on');
calibrateImageFileNames = fullfile(path,file);

squareSize = str2double(get(handles.edit_squareSize,'String'));
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(calibrateImageFileNames);
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

for i=1:size(imagesUsed,1)
    if imagesUsed(i) == 1
        calibrate_no = i;
        break;
    end
end
% Calibrate the camera.
I = imread(calibrateImageFileNames{calibrate_no});
imageSize = [size(I, 1), size(I, 2)];
cameraParams = estimateCameraParameters(imagePoints, worldPoints, 'ImageSize', imageSize);
[rotationMatrix, translationVector] = extrinsics(imagePoints(:,:,1),worldPoints,cameraParams);
[worldOrientation,worldLocation] = estimateWorldCameraPose(imagePoints(:,:,1),[worldPoints,zeros(size(worldPoints,1),1)],cameraParams);

set(handles.button_new,'Enable','on')

% Update handles structure
handles.cameraParams = cameraParams;
handles.rotationMatrix = rotationMatrix;
handles.translationVector = translationVector;
handles.worldOrientation = worldOrientation;
handles.worldLocation = worldLocation;
guidata(hObject, handles);


function edit_squareSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_squareSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_squareSize as text
%        str2double(get(hObject,'String')) returns contents of edit_squareSize as a double


% --- Executes during object creation, after setting all properties.
function edit_squareSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_squareSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% ---------------------------- New Image ----------------------------- %%
% --- Executes on button press in button_new.
function button_new_Callback(hObject, eventdata, handles)
% hObject    handle to button_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set default
default_boxW = 10;
set(handles.slider_boxW, 'Value', default_boxW);
set(handles.text_valueBoxW, 'String', num2str(default_boxW));

default_boxH = 10;
set(handles.slider_boxH, 'Value', default_boxH);
set(handles.text_valueBoxH, 'String', num2str(default_boxH));

default_Th = 0.8;
set(handles.slider_Th, 'Value', default_Th);
set(handles.text_valueTh, 'String', num2str(default_Th));

handles.boxH = default_boxH;
handles.boxW = default_boxW;
handles.Th = default_Th;
handles.mark_all = [];
handles.mousePos = [];
handles.mirrorPos = [];
handles.objectPos = [];

set(handles.togglebutton_objectDraw,'Enable','on')
set(handles.togglebutton_mirrorDraw,'Enable','on')
set(findall(handles.uipanel_detectMark, '-property', 'enable'), 'enable', 'on')
set(handles.togglebutton_removeOutlier,'Enable','off')
set(handles.pushbutton_matchPoint,'Enable','off')
set(handles.pushbutton_calLocalMirror,'Enable','off')
    
% --- open file --- %
cameraParams = handles.cameraParams;
[file,path] = uigetfile('../../*.*','Select an image file');
I = imread([path file]);
[orig_img, newOrigin] = undistortImage(I, cameraParams, 'OutputView', 'full');
axes(handles.axes_image);
hImage = imshow(orig_img);
set(hImage, 'ButtonDownFcn', @axesImage_mouseClick_callback)

% Update handles structure
handles.orig_img = orig_img;
guidata(hObject, handles);

%% ------------------------- Corner Detection -------------------------- %%
% --- Executes on selection change in popupmenu_type.
function popupmenu_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_type


% --- Executes during object creation, after setting all properties.
function popupmenu_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_boxW_Callback(hObject, eventdata, handles)
% hObject    handle to slider_boxW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
boxW = get(hObject,'Value');
set(handles.text_valueBoxW, 'String', num2str(boxW));

% Update handles structure
handles.boxW = boxW;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_boxW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_boxW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_boxH_Callback(hObject, eventdata, handles)
% hObject    handle to slider_boxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
boxH = get(hObject,'Value');
set(handles.text_valueBoxH, 'String', num2str(boxH));
% Update handles structure
handles.boxH = boxH;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_boxH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_boxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_Th_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Th = get(hObject,'Value');
set(handles.text_valueTh, 'String', num2str(Th));
handles.Th = Th;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_Th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton_detectCorner.
function pushbutton_detectCorner_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_detectCorner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
orig_img = handles.orig_img;
mirrorPos = handles.mirrorPos;
objectPos = handles.objectPos;
boxH = round(handles.boxH);
boxW = round(handles.boxW);

Th = handles.Th;
box = [boxH, boxW];
cornerType = get(handles.popupmenu_type,'value');
if cornerType == 1
    cornerShape = 6;
elseif cornerType == 2
    cornerShape = 4;
end
mark = detectTriangleboardPoints(orig_img,box,cornerShape,Th);
mark(:,3) = ones(size(mark,1),1)*2;
axes(handles.axes_image);
imshow(orig_img);
hold on
mark = markROI(orig_img,mark,objectPos,mirrorPos);
[h_object,h_mirror] = drawMark(orig_img,mark,objectPos,mirrorPos);
    
% Update handles structure
handles.mark_all = mark;
guidata(hObject, handles);

%% --------------------- Drawing Mirror & Object ----------------------- %%
% --- Executes on button press in togglebutton_mirrorDraw.
function togglebutton_mirrorDraw_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_mirrorDraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_mirrorDraw
set(handles.togglebutton_removeOutlier,'Enable','on')
set(handles.pushbutton_matchPoint,'Enable','on')
set(handles.pushbutton_calLocalMirror,'Enable','off')

orig_img = handles.orig_img;
mark = handles.mark_all;
axes(handles.axes_image);
hImage = imshow(orig_img);
hold on, 
if get(hObject,'Value')
    mirrorPos = [];
    if isempty(handles.objectPos), objectPos = handles.mousePos;
    else, objectPos = handles.objectPos; end
    mark = markROI(orig_img,mark,objectPos,mirrorPos);
    [~,~] = drawMark(orig_img,mark,objectPos,mirrorPos);
    % Setup callback function for mouse events on the image
    set(hImage, 'ButtonDownFcn', @axesImage_roi_callback);
    set(handles.togglebutton_objectDraw,'Value',0);
else
    mirrorPos = handles.mousePos;
    objectPos = handles.objectPos;
    mark = markROI(orig_img,mark,objectPos,mirrorPos);
    [~,~] = drawMark(orig_img,mark,objectPos,mirrorPos);
end
handles.mark_all = mark;
handles.mousePos = [];
handles.mirrorPos = mirrorPos;
handles.objectPos = objectPos;
guidata(hObject, handles);

% --- Executes on button press in togglebutton_objectDraw.
function togglebutton_objectDraw_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_objectDraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_objectDraw
set(handles.togglebutton_removeOutlier,'Enable','on')
set(handles.pushbutton_matchPoint,'Enable','on')
set(handles.pushbutton_calLocalMirror,'Enable','off')
orig_img = handles.orig_img;
mark = handles.mark_all;
axes(handles.axes_image);
hImage = imshow(orig_img);
hold on, 
if get(hObject,'Value')
    objectPos = [];
    if isempty(handles.mirrorPos),mirrorPos = handles.mousePos;
    else, mirrorPos = handles.mirrorPos; end
    mark = markROI(orig_img,mark,objectPos,mirrorPos);
    [~,~] = drawMark(orig_img,mark,objectPos,mirrorPos);
    % Setup callback function for mouse events on the image
    set(hImage, 'ButtonDownFcn', @axesImage_roi_callback);
    set(handles.togglebutton_mirrorDraw,'Value',0);
else
    objectPos = handles.mousePos;
    mirrorPos = handles.mirrorPos;
    mark = markROI(orig_img,mark,objectPos,mirrorPos);
    [~,~] = drawMark(orig_img,mark,objectPos,mirrorPos);
end
handles.mark_all = mark;
handles.mousePos = [];
handles.mirrorPos = mirrorPos;
handles.objectPos = objectPos;
guidata(hObject, handles);

% --- Executes on mouse press over axes background.
function axesImage_roi_callback(hObject, eventdata)
% hObject    handle to axes_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
handles = guidata(hObject);
pos = get(handles.axes_image, 'currentpoint');
plot(pos(1,1),pos(1,2),'xb','LineWidth',2);
handles.mousePos = cat(1,handles.mousePos,pos(1,1:2));
guidata(hObject, handles);

%% --------------------- Remove outlier mark ----------------------- %%
% --- Executes on button press in togglebutton_removeOutlier.
function togglebutton_removeOutlier_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_removeOutlier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_removeOutlier
orig_img = handles.orig_img;
mark = handles.mark_all;
axes(handles.axes_image);
imshow(orig_img);
hold on,  
if get(hObject,'Value')
    if get(handles.togglebutton_objectDraw,'Value')
        mirrorPos = handles.mirrorPos;
        objectPos = handles.mousePos;
        set(handles.togglebutton_objectDraw,'Value',0);
        mark = markROI(orig_img,mark,objectPos,mirrorPos);
    elseif get(handles.togglebutton_mirrorDraw,'Value')
        mirrorPos = handles.mousePos;
        objectPos = handles.objectPos;
        set(handles.togglebutton_mirrorDraw,'Value',0);
        mark = markROI(orig_img,mark,objectPos,mirrorPos);
    else
        mirrorPos = handles.mirrorPos;
        objectPos = handles.objectPos;
    end
    
    [h_object,h_mirror] = drawMark(orig_img,mark,objectPos,mirrorPos);
    % Setup callback function for mouse events on the image
    set(h_object, 'ButtonDownFcn', @axesImage_selectOutlier_callback);
    set(h_mirror, 'ButtonDownFcn', @axesImage_selectOutlier_callback);
    
    set(handles.togglebutton_objectDraw,'Enable','off')
    set(handles.togglebutton_mirrorDraw,'Enable','off')
    set(findall(handles.uipanel_detectMark, '-property', 'enable'), 'enable', 'off')
    set(handles.pushbutton_matchPoint,'Enable','off')
    
    handles.mousePos = [];
    handles.mark_all = mark;
    handles.mirrorPos = mirrorPos;
    handles.objectPos = objectPos;
    guidata(hObject, handles);
else
    mirrorPos = handles.mirrorPos;
    objectPos = handles.objectPos;
 
    [h_object,h_mirror] = drawMark(orig_img,mark,objectPos,mirrorPos);

    set(handles.togglebutton_objectDraw,'Enable','on')
    set(handles.togglebutton_mirrorDraw,'Enable','on')
    set(findall(handles.uipanel_detectMark, '-property', 'enable'), 'enable', 'on')
    set(handles.pushbutton_matchPoint,'Enable','on')
end

% --- Executes on mouse press over axes background.
function axesImage_selectOutlier_callback(hObject, eventdata)
% hObject    handle to axes_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
handles = guidata(hObject);
mark = handles.mark_all;

pos = get(handles.axes_image, 'currentpoint');
dist_min = 999999;
idx = 0;
for i=1:size(mark,1)
    distance = norm(mark(i,1:2) - pos(1,1:2));
    if distance <= dist_min
        idx = i;
        dist_min = distance;
    end
end
mark(idx,3) = 3;
% drawMark(orig_img,mark,objectPos,mirrorPos);
plot(mark(idx,1),mark(idx,2),'xc','LineWidth',2);  

% handles.mousePos = cat(1,handles.mousePos,pos(1,1:2));
handles.mark_all = mark;
guidata(hObject, handles);

%% ------------------------ Indicate type mark ------------------------- %%
function mark = markROI(orig_img,mark,objectPos,mirrorPos)
[m,n,~] = size(orig_img);
mirror_BW = zeros(m,n);
object_BW = zeros(m,n);
if ~isempty(mirrorPos)
    mirror_BW = poly2mask(mirrorPos(:,1),mirrorPos(:,2),m,n);
end
if ~isempty(objectPos)
    object_BW = poly2mask(objectPos(:,1),objectPos(:,2),m,n);
end     
if ~isempty(mark)
    for i=1:size(mark,1)
        if ~mirror_BW(round(mark(i,2)),round(mark(i,1))) && object_BW(round(mark(i,2)),round(mark(i,1)))
            mark(i,3) = 0; % object
        elseif mirror_BW(round(mark(i,2)),round(mark(i,1))) && ~object_BW(round(mark(i,2)),round(mark(i,1)))
            mark(i,3) = 1; % mirror
        else
            mark(i,3) = 2; % outlier
        end
    end
end

function [h_object,h_mirror] = drawMark(orig_img,mark,objectPos,mirrorPos)

if ~isempty(mirrorPos)
    patch(mirrorPos(:,1),mirrorPos(:,2),'b','FaceAlpha',0.5); 
end
if ~isempty(objectPos)
    patch(objectPos(:,1),objectPos(:,2),'g','FaceAlpha',0.5); 
end     
if ~isempty(mark)
    error_mark = mark(mark(:,3) ~= 0 & mark(:,3) ~= 1,1:2);
    object_mark = mark(mark(:,3) == 0,1:2);
    mirror_mark = mark(mark(:,3) == 1,1:2);
    plot(mark(:,1),mark(:,2),'oy','LineWidth',2);  
    plot(error_mark(:,1),error_mark(:,2),'xr','LineWidth',2);
    h_object = plot(object_mark(:,1),object_mark(:,2),'xg','LineWidth',2);
    h_mirror = plot(mirror_mark(:,1),mirror_mark(:,2),'xb','LineWidth',2);
else
    h_object = null;
    h_mirror = null;
end

%% ------------------------ mark matching ------------------------- %%
% --- Executes on button press in pushbutton_matchPoint.
function pushbutton_matchPoint_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_matchPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mark = handles.mark_all;
select_mark = mark(mark(:,3) <= 1,:);

SVMModel = fitcsvm(select_mark(:,1:2),select_mark(:,3));
gradient_mark = [select_mark,SVMModel.Gradient];
object_mark = gradient_mark(gradient_mark(:,3) == 0,:);
mirror_mark = gradient_mark(gradient_mark(:,3) == 1,:);

object_mark = sortrows(object_mark,4,'ascend');
mirror_mark = sortrows(mirror_mark,4,'ascend');

axes(handles.axes_image);
hold on,  

if size(mirror_mark,1) < size(object_mark,1)
    pair_mark = [];
    for m=1:size(mirror_mark,1)
        norm_mark = [];
        for o=1:size(object_mark,1)
            norm_mark(o,:) = norm(object_mark(o,1:2) - mirror_mark(m,1:2));
        end
        [~,idx] = min(norm_mark);
        pair = [object_mark(idx,1:2),mirror_mark(m,1:2)];
        pair_mark = cat(1,pair_mark,pair);
        object_mark(idx,:) = [];
        plot(pair(1:2:4),pair(2:2:4),'-','LineWidth',2);
    end
else
    pair_mark = [];
    for m=1:size(object_mark,1)
        norm_mark = [];
        for o=1:size(mirror_mark,1)
            norm_mark(o,:) = norm(mirror_mark(o,1:2) - object_mark(m,1:2));
        end
        [~,idx] = min(norm_mark);
        pair = [object_mark(m,1:2),mirror_mark(idx,1:2)];
        pair_mark = cat(1,pair_mark,pair);
        mirror_mark(idx,:) = [];
        plot(pair(1:2:4),pair(2:2:4),'-','LineWidth',2);
    end
end
hold off

set(handles.pushbutton_calLocalMirror,'Enable','on')
handles.pair_mark = pair_mark;
% Update handles structure
guidata(hObject, handles);

%% ------------------------ Calculate Mirror ------------------------- %%
% --- Executes on button press in pushbutton_calLocalMirror.
function pushbutton_calLocalMirror_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calLocalMirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cameraParams = handles.cameraParams;
rotationMatrix = handles.rotationMatrix;
translationVector = handles.translationVector;
worldOrientation = handles.worldOrientation;
worldLocation = handles.worldLocation;
pair_mark = handles.pair_mark;
orig_img = handles.orig_img;

% ------ point to world coordinate ------
obj_img = pair_mark(:,1:2);
mirror_img = pair_mark(:,3:4);
obj_world = pointsToWorld(cameraParams,rotationMatrix, translationVector,obj_img);
obj_world = [obj_world,zeros(size(obj_world,1),1)];

[m, n, ch] = size(orig_img);
ImEdges = [1,1; n,1; n,m; 1,m];
edges_world = pointsToWorld(cameraParams,rotationMatrix, translationVector,ImEdges);
edges_world = [edges_world,zeros(size(edges_world,1),1)];

% ------ convert to center in camera ------
T = worldLocation;
% R = inv(worldOrientation);
camLocation = (worldLocation - T)/worldOrientation;
camOrientation = worldOrientation/worldOrientation;
objPoints_w = (obj_world - T)/worldOrientation;
edgesPoints_w = (edges_world - T)/worldOrientation;

% ------ image plane from EDGE ------
imagePlane_depth = 160; % mm
edgesVect = zeros(4,3);
for i=1:4
    edgesVect(i,:) = edgesPoints_w(i,:)./norm(edgesPoints_w(i,:));
end
ImagePlaneEdge = imagePlane_depth*edgesVect./edgesVect(:,3);

movingPoints = ImEdges;
fixedPoints = ImagePlaneEdge(:,1:2);
transformationType = 'projective';
tform = fitgeotrans(movingPoints,fixedPoints,transformationType);

mirrorPoints_i = [pair_mark(:,3:4),ones(size(pair_mark,1),1)] * tform.T;
mirrorPoints_i = mirrorPoints_i./mirrorPoints_i(:,3);
mirrorPoints_i(:,3) = imagePlane_depth;

% ------ Calculate local mirror position ------
Oc = [0;0;0];
mirrorDistances = [];
mirrorPoints_w = [];
mirrorNormalVectors = [];
for i=1:size(mirrorPoints_i,1)
    Q = mirrorPoints_i(i,:)';
    P = objPoints_w(i,:)';
    OcQ_vect = Q./norm(Q);
    ObjectiveFunction = @(s) mirrorDistance_objective(s,Oc,P,OcQ_vect); % define constant values
    s0 = 200;   % Starting point
    [S,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,s0);
    M = OcQ_vect*S;
    Np = cross(P,Q);
    Nm = cross(OcQ_vect - (M - P)/norm(M - P),Np);
    Nm = Nm/norm(Nm);

    mirrorDistances = cat(1,mirrorDistances,S);
    mirrorPoints_w = cat(1,mirrorPoints_w,M');
    mirrorNormalVectors = cat(1,mirrorNormalVectors,Nm');
end
% ------ show 3D (center in camera) ------
axes(handles.axes_result)
plotCamera('Location',camLocation,'Orientation',camOrientation,'Size',20);
hold on
pcshow(objPoints_w, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',50);
scatter3(edgesPoints_w(:,1),edgesPoints_w(:,2),edgesPoints_w(:,3),'filled');
scatter3(mirrorPoints_i(:,1),mirrorPoints_i(:,2),mirrorPoints_i(:,3),'filled','MarkerFaceColor','b');
scatter3(mirrorPoints_w(:,1),mirrorPoints_w(:,2),mirrorPoints_w(:,3),'filled');
for i=1:4
    plot3([0;edgesPoints_w(i,1)],[0;edgesPoints_w(i,2)],[0;edgesPoints_w(i,3)])
end
fill3(ImagePlaneEdge(:,1), ImagePlaneEdge(:,2),ImagePlaneEdge(:,3),[1 1 0],'FaceAlpha',0.5,'EdgeColor','none');
grid on
axis equal
