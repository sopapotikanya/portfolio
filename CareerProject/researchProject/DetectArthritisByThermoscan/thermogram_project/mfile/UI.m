function varargout = UI(varargin)
% UI M-file for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 03-Jul-2015 09:22:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
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


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;
set(handles.slider1, 'min', 0);
set(handles.slider1, 'max', 1);
set(handles.slider1, 'Value', 0); 

set(handles.slider2, 'min', 0);
set(handles.slider2, 'max', 1);
set(handles.slider2, 'Value', 0);

contents =get(handles.slider1,'Value');
contents2 =get(handles.slider2,'Value');

%sets=contents(get(handles.slider1,'Value'));
set(handles.showtxt,'String',contents);
set(handles.showtxt2,'String',contents2);

%set(handles.showtxt,'String',)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in searchbtn.
function searchbtn_Callback(hObject, eventdata, handles)
% hObject    handle to searchbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [filename,pathname]=uigetfile({'*.mat';'*.*'},'Pick an Image File');
    load (filename);
    [pathstr, name, ext, versn] = fileparts(filename);
    img_ori = eval(name);

    I = img_ori./(max(max(img_ori)));

    Imax=max(max(I));
    Imin=min(min(I));
    range = Imax-Imin;

    mmin=ones(size(I))*Imin;
    I = I-mmin;

    I2=I/range;

    axes(handles.axes1);
    hold on
    imshow(I2);
    handles.I2 = I2;
    
    
    axes(handles.axes2);
    
    %[counts,x] = imhist(I2);
    %plot(x,counts);
    imhist(I2);
    
    guidata(hObject,handles);
    
    
% --- Executes on button press in finishbtn.
function finishbtn_Callback(hObject, eventdata, handles)
% hObject    handle to finishbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    th =get(handles.slider1,'Value');
    %sets=contents(get(handles.slider1,'Value'));
    set(handles.showtxt,'String',th);
    
    I2=handles.I2;
    
    range = 1-th;

    TH=ones(size(I2))*th;
    I3 = I2-TH;

    I3=I3/range;

    axes(handles.axes3);
    hold on
    imshow(I3);    
    %hold off
    
    %cla(handles.axes2);    
    axes(handles.axes2);
    %imhist(I2);
    line('XData', [th th ], 'YData', [0 2000], 'LineStyle', '-', 'LineWidth', 2, 'Color','m')
    
    guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    th =get(handles.slider2,'Value');
    %sets=contents(get(handles.slider1,'Value'));
    set(handles.showtxt2,'String',th);
    
    I4=handles.I4;
    
    range = 1-th;

    TH=ones(size(I4))*th;
    I6 = I4-TH;

    I6=I6/range;

    axes(handles.axes6);
    hold on
    imshow(I6);    
    %hold off
    
    %cla(handles.axes5);    
    axes(handles.axes5);
    %imhist(I6);
    line('XData', [th th ], 'YData', [0 2000], 'LineStyle', '-', 'LineWidth', 2, 'Color','m')
    
    guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in seachbtn2.
function seachbtn2_Callback(hObject, eventdata, handles)
% hObject    handle to seachbtn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [filename2,pathname2]=uigetfile({'*.mat';'*.*'},'Pick an Image File');
    load (filename2);
    [pathstr2, name2, ext2, versn2] = fileparts(filename2);
    img_ori2 = eval(name2);

    I3 = img_ori2./(max(max(img_ori2)));

    Imax3=max(max(I3));
    Imin3=min(min(I3));
    range3 = Imax3-Imin3;

    mmin3=ones(size(I3))*Imin3;
    I3 = I3-mmin3;

    I4=I3/range3;

    axes(handles.axes4);
    hold on
    imshow(I4);
    handles.I4 = I4;
    
    
    axes(handles.axes5);
    
    %[counts,x] = imhist(I4);
    %plot(x,counts);
    imhist(I4);
    
    guidata(hObject,handles);
