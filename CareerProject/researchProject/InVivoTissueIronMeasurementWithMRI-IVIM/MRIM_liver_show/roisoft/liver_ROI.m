function varargout = liver_ROI(varargin)
% LIVER_ROI MATLAB code for liver_ROI.fig
%      LIVER_ROI, by itself, creates a new LIVER_ROI or raises the existing
%      singleton*.
%
%      H = LIVER_ROI returns the handle to a new LIVER_ROI or the handle to
%      the existing singleton*.
%
%      LIVER_ROI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIVER_ROI.M with the given input arguments.
%
%      LIVER_ROI('Property','Value',...) creates a new LIVER_ROI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before liver_ROI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to liver_ROI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help liver_ROI

% Last Modified by GUIDE v2.5 13-Jul-2015 12:18:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @liver_ROI_OpeningFcn, ...
    'gui_OutputFcn',  @liver_ROI_OutputFcn, ...
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


% --- Executes just before liver_ROI is made visible.
function liver_ROI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to liver_ROI (see VARARGIN)

% Choose default command line output for liver_ROI
handles.output = hObject;
index_posimg=0;
index_posimg2=0;
handles.index_posimg=index_posimg;
handles.index_posimg2=index_posimg2;
save_ref_posit=[];
save_ref_posit2=[];
handles.save_ref_posit=save_ref_posit;
handles.save_ref_posit2=save_ref_posit2;
% v_status=get(handles.popup_axis,'Value');
% s_status=get(handles.popup_axis,'String');
% status=char(s_status(v_status));
status=get(handles.popup_axis,'Value');
status2=get(handles.popup_axis2,'Value');
mode=get(handles.popup_mode,'Value');

handles.mode=mode;
handlesArray = [handles.text6,      handles.cur_pos,        handles.confirm_normal_btn, ...
    handles.refresh_normal_btn,     handles.popup_axis,     handles.text7,  ...
    handles.text8,handles.text9,    handles.text10,         handles.ref_pos_1, ...
    handles.ref_pos_2,              handles.ref_pos_3,      handles.ref_pos_4, ...
    handles.text16,                 handles.cur_pos2,       handles.confirm_dicom_btn, ...
    handles.refresh_dicom_btn,      handles.popup_axis2,    handles.text17, ...
    handles.text18,                 handles.text19,         handles.text20, ...
    handles.ref2_pos_1,             handles.ref2_pos_2,     handles.ref2_pos_3, ...
    handles.ref2_pos_4,             handles.manual_process_btn];

if(mode==1)
    set(handlesArray, 'Visible', 'off');
elseif(mode==2)
    set(handlesArray, 'Visible', 'on');
end

path=pwd;
handles.savepathn=path;
handles.savepathd=path;
handles.status=status;
handles.status2=status2;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes liver_ROI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = liver_ROI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;

%% get click position
% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    status=handles.status;
    status2=handles.status2;
    normal_img=handles.normal_img;
    dicom_img=handles.dicom_img;
    cur_pos=get(handles.axesNormal,'currentpoint');
    cur_pos2=get(handles.axesDicom,'currentpoint');
    
    x=cur_pos(1,1);
    y=cur_pos(1,2);
    x2=cur_pos2(1,1);
    y2=cur_pos2(1,2);
    
    cur_pos_xy=sprintf('x=%s \n y=%s',num2str(x),num2str(y));
    cur_pos_xy2=sprintf('x=%s \n y=%s',num2str(x2),num2str(y2));
    
    set(handles.cur_pos,'String',cur_pos_xy);
    set(handles.cur_pos2,'String',cur_pos_xy2);
    
    ref_posit(1,1)=floor(x);
    ref_posit(1,2)=floor(y);
    ref_posit2(1,1)=floor(x2);
    ref_posit2(1,2)=floor(y2);

    % axes(handles.axesDicom);
    % imshow(dicom_img,'DisplayRange',[]);

    if(status==1)
        axes(handles.axesNormal);
        imshow(normal_img);
        rectangle('Position',[ref_posit(1,1)-5,ref_posit(1,2)-5,10,10],'Curvature',[1,1],'FaceColor','g');
    elseif(status==2)
        axes(handles.axesNormal);
        imshow(normal_img);
        rectangle('Position',[ref_posit(1,1)-5,ref_posit(1,2)-5,10,10],'Curvature',[1,1],'FaceColor','r');
    end

    if(status2==1)
        axes(handles.axesDicom);
        imshow(dicom_img,'DisplayRange',[]);
        rectangle('Position',[ref_posit2(1,1)-2,ref_posit2(1,2)-2,4,4],'Curvature',[1,1],'FaceColor','g');
    elseif(status2==2)
        axes(handles.axesDicom);
        imshow(dicom_img,'DisplayRange',[]);
        rectangle('Position',[ref_posit2(1,1)-2,ref_posit2(1,2)-2,4,4],'Curvature',[1,1],'FaceColor','r');
    end

    handles.status=status;
    handles.status2=status2;
    handles.ref_posit=ref_posit;
    handles.ref_posit2=ref_posit2;
    guidata(hObject,handles);
%% import jpg or png image
% --- Executes on button press in seach_normal_btn.
function seach_normal_btn_Callback(hObject, eventdata, handles)
% hObject    handle to seach_normal_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    path=handles.savepathn;
    [filename,pathname]=uigetfile({'*.jpg;*.png;*.JPG;*.PNG;';'*.*'},'Pick an Image File',path);
    [pathstr,name] = fileparts(filename);
    info=imfinfo([pathname filename]);
    format=info.Format;
    normal_img = imread([pathname,filename]);
%% extract roi
    if(strcmp(format,'png')||strcmp(format,'PNG'))
        normal_img=detectRoi(normal_img); %%%%%% crop img
        [roi_img roi_img_edge]=detectColor(normal_img); %%%%% extract roi by color
        %roi_img_edge = detectColorAddEdge(normal_img);
    elseif(strcmp(format,'jpg'))
        normal_img=detectRoi2(normal_img);
        [roi_img roi_img_edge]=detectColor2(normal_img);
        %roi_img_edge = detectColorAddEdge2(normal_img);
    end
    normal_img_sh = normal_img;
    axes(handles.axesNormal);
    imshow(normal_img);
%%    
%     set(handles.cur_pos,'String','');
%     set(handles.ref_pos_1,'String','');
%     set(handles.ref_pos_2,'String','');
%     set(handles.ref_pos_3,'String','');
%     set(handles.ref_pos_4,'String','');
    
    backup_img=normal_img;
    color_img=normal_img;
    handles.normal_img = normal_img;
    handles.normal_img_sh = normal_img_sh;
    handles.backup_img=backup_img;
    handles.color_img=color_img;
    handles.roi_img=roi_img;
    handles.roi_img_edge=roi_img_edge;
    handles.name_nmr=name;
    handles.savepathn=pathname;
    guidata(hObject,handles);
    
%% import dicom file
% --- Executes on button press in search_dicom_btn.
function search_dicom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to search_dicom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    path=handles.savepathd;
    [filename,pathname]=uigetfile({'*.dcm;*';'*.*'},'Pick an Image File',path);
    %[pathstr,name,ext,versn] = fileparts(filename);
    [pathstr,name] = fileparts(filename);
    info = dicominfo([pathname,filename]);
    dicom_img = dicomread(info);
    dicom_img_sh = dicom_img;
    axes(handles.axesDicom);
    imshow(dicom_img,'DisplayRange',[]);
    
    backup_img2=dicom_img;
    color_img2=dicom_img;
    
    handles.dicom_img = dicom_img;
    handles.dicom_img_sh = dicom_img_sh;
    handles.backup_img2=backup_img2;
    handles.color_img2=color_img2;
    handles.name_dcm=name;
    handles.savepathd=pathname;
    guidata(hObject,handles);

% --- Executes on button press in confirm_normal_btn.
function confirm_normal_btn_Callback(hObject, eventdata, handles)
% hObject    handle to confirm_normal_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    state=1;
    color_img=handles.color_img;
    save_ref_posit=handles.save_ref_posit;
    index_posimg=handles.index_posimg;
    status=handles.status;
    
    index_posimg=index_posimg+1;
    if(index_posimg>2)
        index_posimg=1;
    end
    
    ref_posit=handles.ref_posit;
    show=sprintf('%s=%d , %s=%d','x',ref_posit(1,1),'y',ref_posit(1,2));
    
    if(status==1)
        color_img=mark(color_img,ref_posit(1,2),ref_posit(1,1),status,state);
        if(index_posimg==1)
            save_ref_posit(1,1)=ref_posit(1,1);
            save_ref_posit(1,2)=ref_posit(1,2);
            set(handles.ref_pos_1,'String',show);
            set(handles.ref_pos_1,'ForegroundColor',[0 0 0]);
            set(handles.ref_pos_2,'ForegroundColor',[0 1 0]);
        elseif(index_posimg==2)
            save_ref_posit(1,3)=ref_posit(1,1);
            save_ref_posit(1,4)=ref_posit(1,2);
            set(handles.ref_pos_2,'String',show);
            set(handles.ref_pos_1,'ForegroundColor',[0 1 0]);
            set(handles.ref_pos_2,'ForegroundColor',[0 0 0]);
        end

    elseif(status==2)
        color_img=mark(color_img,ref_posit(1,2),ref_posit(1,1),status,state);
        if(index_posimg==1)
            save_ref_posit(2,1)=ref_posit(1,1);
            save_ref_posit(2,2)=ref_posit(1,2);
            set(handles.ref_pos_3,'String',show);
            set(handles.ref_pos_3,'ForegroundColor',[0 0 0]);
            set(handles.ref_pos_4,'ForegroundColor',[1 0 0]);
        elseif(index_posimg==2)
            save_ref_posit(2,3)=ref_posit(1,1);
            save_ref_posit(2,4)=ref_posit(1,2);
            set(handles.ref_pos_4,'String',show);
            set(handles.ref_pos_3,'ForegroundColor',[1 0 0]);
            set(handles.ref_pos_4,'ForegroundColor',[0 0 0]);
        end
    end
    axes(handles.axesNormal);
    imshow(color_img);
    normal_img=color_img;
    
    handles.color_img=color_img;
    handles.normal_img=normal_img;
    handles.save_ref_posit=save_ref_posit;
    handles.index_posimg=index_posimg;
    guidata(hObject,handles);


% --- Executes on selection change in popup_axis.
function popup_axis_Callback(hObject, eventdata, handles)
% hObject    handle to popup_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_axis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_axis
    index_posimg=handles.index_posimg;
    index_posimg=0;
    status=get(hObject,'Value');
    handles.index_posimg=index_posimg;
    handles.status=status;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popup_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in refresh_normal_btn.
function refresh_normal_btn_Callback(hObject, eventdata, handles)
% hObject    handle to refresh_normal_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    color_img=handles.color_img;
    normal_img=handles.normal_img;
    backup_img=handles.backup_img;
    normal_img=backup_img;
    color_img=backup_img;
    
    set(handles.cur_pos,'String','');
    set(handles.ref_pos_1,'String','');
    set(handles.ref_pos_2,'String','');
    set(handles.ref_pos_3,'String','');
    set(handles.ref_pos_4,'String','');
    
    axes(handles.axesNormal);
    imshow(normal_img);
    
    handles.color_img = color_img;
    handles.normal_img = normal_img;
    guidata(hObject,handles);


% --- Executes on button press in confirm_dicom_btn.
function confirm_dicom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to confirm_dicom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    state=2;
    color_img2=handles.color_img2;
    save_ref_posit2=handles.save_ref_posit2;
    index_posimg2=handles.index_posimg2;
    status2=handles.status2;   
    
    index_posimg2=index_posimg2+1;
    if(index_posimg2>2)
        index_posimg2=1;
    end
    
    ref_posit2=handles.ref_posit2;
    show2=sprintf('%s=%d , %s=%d','x',ref_posit2(1,1),'y',ref_posit2(1,2));
    
    if(status2==1)
        color_img2=mark(color_img2,ref_posit2(1,2),ref_posit2(1,1),status2,state);
        if(index_posimg2==1)
            save_ref_posit2(1,1)=ref_posit2(1,1);
            save_ref_posit2(1,2)=ref_posit2(1,2);
            set(handles.ref2_pos_1,'String',show2);
            set(handles.ref2_pos_1,'ForegroundColor',[0 0 0]);
            set(handles.ref2_pos_2,'ForegroundColor',[0 1 0]);
        elseif(index_posimg2==2)
            save_ref_posit2(1,3)=ref_posit2(1,1);
            save_ref_posit2(1,4)=ref_posit2(1,2);
            set(handles.ref2_pos_2,'String',show2);
            set(handles.ref2_pos_1,'ForegroundColor',[0 1 0]);
            set(handles.ref2_pos_2,'ForegroundColor',[0 0 0]);
        end

    elseif(status2==2)
        color_img2=mark(color_img2,ref_posit2(1,2),ref_posit2(1,1),status2,state);
        if(index_posimg2==1)
            save_ref_posit2(2,1)=ref_posit2(1,1);
            save_ref_posit2(2,2)=ref_posit2(1,2);
            set(handles.ref2_pos_3,'String',show2);
            set(handles.ref2_pos_3,'ForegroundColor',[0 0 0]);
            set(handles.ref2_pos_4,'ForegroundColor',[1 0 0]);
        elseif(index_posimg2==2)
            save_ref_posit2(2,3)=ref_posit2(1,1);
            save_ref_posit2(2,4)=ref_posit2(1,2);
            set(handles.ref2_pos_4,'String',show2);
            set(handles.ref2_pos_3,'ForegroundColor',[1 0 0]);
            set(handles.ref2_pos_4,'ForegroundColor',[0 0 0]);
        end
    end
    
    axes(handles.axesDicom);
    imshow(color_img2,'DisplayRange',[]);
    dicom_img=color_img2;
    
    handles.color_img2=color_img2;
    handles.dicom_img=dicom_img;
    handles.save_ref_posit2=save_ref_posit2;
    handles.index_posimg2=index_posimg2;
    guidata(hObject,handles);



% --- Executes on selection change in popup_axis2.
function popup_axis2_Callback(hObject, eventdata, handles)
% hObject    handle to popup_axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_axis2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_axis2
    index_posimg2=handles.index_posimg2;
    index_posimg2=0;
    status2=get(hObject,'Value');
    handles.index_posimg2=index_posimg2;
    handles.status2=status2;
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popup_axis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in refresh_dicom_btn.
function refresh_dicom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to refresh_dicom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    color_img2=handles.color_img2;
    dicom_img=handles.dicom_img;
    backup_img2=handles.backup_img2;
    
    dicom_img=backup_img2;
    color_img2=backup_img2;
    
    set(handles.cur_pos2,'String','');
    set(handles.ref2_pos_1,'String','');
    set(handles.ref2_pos_2,'String','');
    set(handles.ref2_pos_3,'String','');
    set(handles.ref2_pos_4,'String','');
    
    axes(handles.axesDicom);
    imshow(dicom_img,'DisplayRange',[]);
    
    handles.color_img2 = color_img2;
    handles.dicom_img = dicom_img;
    guidata(hObject,handles);


% --- Executes on button press in manual_process_btn.
function manual_process_btn_Callback(hObject, eventdata, handles)
% hObject    handle to manual_process_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dicom_img_sh=handles.dicom_img_sh;
    dicom_img=handles.dicom_img_sh;
    dicom_img_edge=handles.dicom_img_sh;
    normal_img=handles.normal_img_sh;
    roi_img=handles.roi_img;
    roi_img_edge=handles.roi_img_edge;
    save_ref_posit=handles.save_ref_posit;
    save_ref_posit2=handles.save_ref_posit2;
    
%% manual resize
    [roi_resize ratio_w ratio_h]= ratioDCM_manual(save_ref_posit,save_ref_posit2,normal_img,roi_img,dicom_img_sh);
%     [roi_resize_edge ratio_w_edge ratio_h_edge] = ratioDCM_manual(save_ref_posit,save_ref_posit2,normal_img,roi_img_edge,dicom_img_sh);


    vmaxdcm = max(max(dicom_img_sh));
    %dicom_img_edge=dicom_img;
    %normal_resize=imresize(normal_crop,[size(normal_crop,1)*1/ratio_h  size(normal_crop,2)*1/ratio_w]);
   
    roi_resize=imresize(roi_resize,[size(dicom_img,1) size(dicom_img,2)],'nearest');
    for i = 1:size(dicom_img,1)
        for j = 1:1:size(dicom_img,2)
            if roi_resize(i,j) == 1
                dicom_img(i,j) = vmaxdcm;
            end
        end
    end
    
%     roi_resize_edge=imresize(roi_resize_edge,[size(dicom_img_edge,1) size(dicom_img_edge,2)],'nearest');
%     for i = 1:size(dicom_img_edge,1)
%         for j = 1:1:size(dicom_img_edge,2)
%             if roi_resize_edge(i,j) == 1
%                 dicom_img_edge(i,j) = vmaxdcm;
%             end
%         end
%     end


%     H = fspecial('gaussian',[3 3],1);
%     H2 = fspecial('disk',3);
%     new_roiresize1 = imfilter(new_roiresize,H);
%     new_roiresize2=new_roiresize1>0.3;
%% voxel cal
%     num_v = 0;
%     num_v_edge = 0;
%     for i = 1:size(roi_img,1)
%         for j = 1:1:size(roi_img,2)
%             if roi_img(i,j) == 1
%                 num_v = num_v+1;
%             end
%             if roi_img_edge(i,j) == 1
%                 num_v_edge = num_v_edge+1;
%             end
%         end
%     end
% 
% 
%     num_v_re = 0;
%     num_v_re_edge = 0;
%     for i = 1:size(roi_resize,1)
%         for j = 1:1:size(roi_resize,2)
%             if roi_resize(i,j) == 1
%                 num_v_re = num_v_re+1;
%             end
%             if roi_resize_edge(i,j) == 1
%                 num_v_re_edge = num_v_re_edge+1;
%             end
%         end
%     end
    

%% show result
    h = figure;
    subplot(2,4,[1 2]), imshow(normal_img), title('image')
    subplot(2,4,4), imshow(dicom_img_sh,'DisplayRange',[]), title('dicom')
    subplot(2,4,[5 6]), imshow(roi_img)%, title(num_v)
    subplot(2,4,7),  imshow(roi_resize)%, title(num_v_re)
    subplot(2,4,8), imshow(dicom_img,'DisplayRange',[]), title(ratio_w)
%     subplot(3,4,[9 10]),  imshow(roi_img_edge), title(num_v_edge)
%     subplot(3,4,11),  imshow(roi_resize_edge), title(num_v_re_edge)
%     subplot(3,4,12), imshow(dicom_img_edge,'DisplayRange',[]), title(ratio_w_edge)
    
    handles.roi_resize=roi_resize;
%     handles.roi_resize_edge=roi_resize_edge;
    handles.dicom_img=dicom_img;
%     handles.dicom_img_edge=dicom_img_edge;
%     handles.num_v=num_v;
%     handles.num_v_re=num_v_re;
%     handles.num_v_edge=num_v_edge;
%     handles.num_v_re_edge=num_v_re_edge;
%     handles.ratio_w=ratio_w;
%     handles.ratio_h=ratio_h;
%     handles.ratio_w_edge=ratio_w_edge;
%     handles.ratio_h_edge=ratio_h_edge;
    handles.h=h;
%     figure, imshow(new_roiresize);
%     figure, imshow(new_roiresize1);
%     figure, imshow(new_roiresize2);
    guidata(hObject, handles);
%%


function edt_save_Callback(hObject, eventdata, handles)
% hObject    handle to edt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_save as text
%        str2double(get(hObject,'String')) returns contents of edt_save as a double


% --- Executes during object creation, after setting all properties.
function edt_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_btn.
function browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
directory_name = uigetdir;
set(handles.edt_save, 'String', directory_name);
guidata(hObject, handles);

% --- Executes on button press in auto_manual_process_btn.
function auto_process_btn_Callback(hObject, eventdata, handles)
% hObject    handle to auto_manual_process_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dicom_img_sh=handles.dicom_img_sh;
    normal_img=handles.normal_img_sh;
    roi_img=handles.roi_img;
%     roi_img_edge=handles.roi_img_edge;
%% auto resize 
    [roi_resize, dicom_img, ratio_w]=ratioDCM(normal_img,roi_img,dicom_img_sh);
    [roi_resize_edge, dicom_img_edge, ratio_w_edge]=ratioDCM(normal_img,roi_img_edge,dicom_img_sh);
%% voxel cal
    num_v = 0;
    num_v_edge = 0;
    for i = 1:size(roi_img,1)
        for j = 1:1:size(roi_img,2)
            if roi_img(i,j) == 1
                num_v = num_v+1;
            end
            if roi_img_edge(i,j) == 1
                num_v_edge = num_v_edge+1;
            end
        end
    end


    num_v_re = 0;
    num_v_re_edge = 0;
    for i = 1:size(roi_resize,1)
        for j = 1:1:size(roi_resize,2)
            if roi_resize(i,j) == 1
                num_v_re = num_v_re+1;
            end
            if roi_resize_edge(i,j) == 1
                num_v_re_edge = num_v_re_edge+1;
            end
        end
    end
%% show result
    h = figure;
    subplot(3,4,[1 2]), imshow(normal_img), title('image')
    subplot(3,4,4), imshow(dicom_img_sh,'DisplayRange',[]), title('dicom')
    subplot(3,4,[5 6]), imshow(roi_img), title(num_v)
    subplot(3,4,7),  imshow(roi_resize), title(num_v_re)
    subplot(3,4,8), imshow(dicom_img,'DisplayRange',[]), title('dcm'), title(ratio_w)
    subplot(3,4,[9 10]),  imshow(roi_img_edge), title(num_v_edge)
    subplot(3,4,11),  imshow(roi_resize_edge), title(num_v_re_edge)
    subplot(3,4,12), imshow(dicom_img_edge,'DisplayRange',[]), title(ratio_w_edge)
    handles.roi_resize=roi_resize;
    handles.roi_resize_edge=roi_resize_edge;
    handles.dicom_img=dicom_img;
    handles.dicom_img_edge=dicom_img_edge;
    handles.num_v=num_v;
    handles.num_v_re=num_v_re;
    handles.num_v_edge=num_v_edge;
    handles.num_v_re_edge=num_v_re_edge;
    handles.ratio_w=ratio_w;
    handles.ratio_w_edge=ratio_w_edge;
    handles.h=h;
    guidata(hObject, handles);
    %test/wp-content/uploads/2015/07/serviceDiagram.png
%% save
% --- Executes on button press in save_btn.
function save_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    filename=handles.name_nmr;
    pathname=handles.savepathn;
%     normal_img=handles.normal_img_sh;
%     dicom_img_sh=handles.dicom_img_sh;
%     roi_img=handles.roi_img;
%     roi_img_edge=handles.roi_img_edge;
    roi_resize=handles.roi_resize;
%     roi_resize_edge=handles.roi_resize_edge;
%     dicom_img=handles.dicom_img;
%     dicom_img_edge=handles.dicom_img_edge;
%     num_v=handles.num_v;
%     num_v_re=handles.num_v_re;
%     num_v_edge=handles.num_v_edge;
%     num_v_re_edge=handles.num_v_re_edge;
%     ratio_w=handles.ratio_w;
%     ratio_w_edge=handles.ratio_w_edge;
    h=handles.h;
%     save_ref_posit=handles.save_ref_posit;
%     save_ref_posit2=handles.save_ref_posit2;
    %% convert dicom file
%     r = max(max(dicom_img));
%     r2 = r/255;
%     dicom_img_con = dicom_img./r2;
%     dicom_img_con = uint8(dicom_img_con);
% 
%     r = max(max(dicom_img_edge));
%     r2 = r/255;
%     dicom_img_edge_con = dicom_img_edge./r2;
%     dicom_img_edge_con = uint8(dicom_img_edge_con); 
%     
%     r = max(max(dicom_img_edge));
%     r2 = r/255;
%     dicom_img_sh_con = dicom_img_sh./r2;
%     dicom_img_sh_con = uint8(dicom_img_sh_con); 
    
    %% save
%     cd report_roi
%         mkdir(filename)
%         cd(filename)
%             imwrite(normal_img,[filename '_img.bmp'],'bmp');
%             imwrite(roi_img,[filename '_roi_img.bmp'],'bmp');
%             imwrite(roi_img_edge,[filename '_roi_img_edge.bmp'],'bmp');
%             imwrite(roi_resize,[filename '_roi_dcm.bmp'],'bmp');
%             imwrite(roi_resize_edge,[filename '_roi_dcm_edge.bmp'],'bmp');
%     
%             imwrite(dicom_img_con,[filename '_dcm.bmp'],'bmp');
%             imwrite(dicom_img_edge_con,[filename '_dcm_edge.bmp'],'bmp');
%             imwrite(dicom_img_sh_con,[filename '_dcm_sh.bmp'],'bmp');
%             
%             save('roi.mat','roi_resize','roi_resize_edge','save_ref_posit','save_ref_posit2');
%             saveas(h,[filename '.fig']);
%             
%             fid = fopen('data.txt', 'w');
%                 fprintf(fid, 'number of voxel before resize: %d\n' , num_v);
%                 fprintf(fid, 'number of voxel after resize: %d\n' , num_v_re);
%                 fprintf(fid, 'number of voxel before resize with edge: %d\n' , num_v_edge);
%                 fprintf(fid, 'number of voxel after resize with edge: %d\n' , num_v_re_edge);
%                 fprintf(fid, 'ratio: %d\n' , ratio_w);
%                 fprintf(fid, 'ratio with edge: %d\n' , ratio_w_edge );    
%                 fprintf(fid, 'img coordinate w1(x,y): %d %d\n' ,  save_ref_posit(1,1),  save_ref_posit(1,2));
%                 fprintf(fid, 'img coordinate w2(x,y): %d %d\n' ,  save_ref_posit(1,3),  save_ref_posit(1,4));
%                 fprintf(fid, 'img coordinate h1(x,y): %d %d\n' ,  save_ref_posit(2,1),  save_ref_posit(2,2));
%                 fprintf(fid, 'img coordinate h2(x,y): %d %d\n' ,  save_ref_posit(2,3),  save_ref_posit(2,4));
%                 
%                 fprintf(fid, 'dcm coordinate w1(x,y): %d %d\n' ,  save_ref_posit2(1,1),  save_ref_posit2(1,2));
%                 fprintf(fid, 'dcm coordinate w2(x,y): %d %d\n' ,  save_ref_posit2(1,3),  save_ref_posit2(1,4));
%                 fprintf(fid, 'dcm coordinate h1(x,y): %d %d\n' ,  save_ref_posit2(2,1),  save_ref_posit2(2,2));
%                 fprintf(fid, 'dcm coordinate h2(x,y): %d %d\n' ,  save_ref_posit2(2,3),  save_ref_posit2(2,4));
%             fclose(fid);
%         cd ..
%         cd check
%             mkdir(filename)
%             cd(filename)
%                 imwrite(normal_img,[filename '_img.bmp'],'bmp');
%                 imwrite(dicom_img_sh_con,[filename '_dcm_sh.bmp'],'bmp');
%                 imwrite(dicom_img_con,[filename '_dcm.bmp'],'bmp');
%                 imwrite(dicom_img_edge_con,[filename '_dcm_edge.bmp'],'bmp');
%             cd ..
%         cd ..
%     cd ..
    clear roi;
    roi = roi_resize;
    savepathd = handles.savepathd;
    c1 = upper(filename);
    path = upper(savepathd);
    m = strsplit(path,'/');
    c2 = m{1,size(m,2)-1};
    if size(strfind(c1,'LIVER'),1) == 1
        if size(strfind(c1,'LT'),1) == 1
            part = [c2 'L'];
        elseif size(strfind(c1,'RT'),1) == 1
            part = [c2 'R'];
        end
    else
        part = c2;
    end
    
%     if size(strfind(c1,'HEART'),1) == 1
%         part = 'HEART';
%     elseif size(strfind(c1,'LT'),1) == 1
%         part = 'LIVER_L';
%     elseif size(strfind(c1,'RT'),1) == 1
%         part = 'LIVER_R';
%     elseif size(strfind(c1,'PANCREAS'),1) == 1
%         part = 'PANCREAS';
%     else
%         part = c1;
%     end
%     c1= strsplit(filename,'_');
%     c2 = char(c(1,3));
%     c3 = upper(c2);
    
%     part = 'LIVERL';
%     part = 'LIVERR';
%     part = 'PANCREASE';



%     uisave('roi',['roi_' part ' .mat'])
    cd ROI
    save(['roi_' part ' .mat'],'roi');
    %save(['roi.mat'],'roi');
    cd ..
    guidata(hObject, handles);
%%
% --- Executes on selection change in popup_mode.
function popup_mode_Callback(hObject, eventdata, handles)
% hObject    handle to popup_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_mode
mode=get(hObject,'Value');
handles.mode=mode;
handlesArray = [handles.text6, handles.cur_pos, handles.confirm_normal_btn,handles.refresh_normal_btn,handles.popup_axis,handles.text7,handles.text8,handles.text9,handles.text10,handles.ref_pos_1,handles.ref_pos_2,handles.ref_pos_3,handles.ref_pos_4,handles.text16,handles.cur_pos2,handles.confirm_dicom_btn,handles.refresh_dicom_btn,handles.popup_axis2,handles.text17,handles.text18,handles.text19,handles.text20,handles.ref2_pos_1,handles.ref2_pos_2,handles.ref2_pos_3,handles.ref2_pos_4,handles.manual_process_btn];

if(mode==1)
    set(handlesArray, 'Visible', 'off');
    set(handles.auto_process_btn, 'Visible', 'on');
elseif(mode==2)
    set(handlesArray, 'Visible', 'on');
    set(handles.auto_process_btn, 'Visible', 'off');
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popup_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


