function varargout = MAIN_CODE(varargin)
% MAIN_CODE MATLAB code for MAIN_CODE.fig
%      MAIN_CODE, by itself, creates a new MAIN_CODE or raises the existing
%      singleton*.
%
%      H = MAIN_CODE returns the handle to a new MAIN_CODE or the handle to
%      the existing singleton*.
%
%      MAIN_CODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_CODE.M with the given input arguments.
%
%      MAIN_CODE('Property','Value',...) creates a new MAIN_CODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MAIN_CODE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MAIN_CODE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MAIN_CODE

% Last Modified by Pradeep and Subhankar v2.5 14-Mar-2015

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MAIN_CODE_OpeningFcn, ...
                   'gui_OutputFcn',  @MAIN_CODE_OutputFcn, ...
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


% --- Executes just before MAIN_CODE is made visible.
function MAIN_CODE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MAIN_CODE (see VARARGIN)

% Choose default command line output for MAIN_CODE
handles.output = hObject;

a=ones(200);
axes(handles.axes1),imshow(a);
axes(handles.axes2),imshow(a);
axes(handles.axes3),imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MAIN_CODE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MAIN_CODE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
disp('Training the dataset.....');
for i=1:8
diry=[pwd '\dataset\' num2str(i)];
   disp(' features Extraction.....');
   feature1=training(diry);
   if i==1
       out=feature1;
       group=ones(size(feature1,1),1)*i;
   else
       group1=ones(size(feature1,1),1)*i;
       group=[group;group1];
       out=[out;feature1];
   end
end
handles.out=out;
 handles.group=group;
 msgbox('Training completed');
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[fname, pathname] = uigetfile('*.*', 'Select query image');


    fullpath = strcat(pathname, fname);
     
       Image = imread( fullpath );
     if size(Image,3)>1
         Image=rgb2gray(Image);
     end
     axes(handles.axes1),imshow(Image,[]);
     title('ORIGINAL IMAGE');
        % extract query image features
        x = histeq(Image);
        axes(handles.axes2),imshow(x,[]);
          title('ENHANCED IMAGE');
handles.x=x;
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = hObject;
I=handles.x;
 level=graythresh(I);
BW_I = ~im2bw(I,level);

% BW_I_selected = im2bw(BW_I);

% white_pixels_I_selected = sum(BW_I_selected(:) == 1);

se = strel('disk',5);

closeBW = imdilate(BW_I,se);
I=uint8(closeBW.*double(I));
 axes(handles.axes3),imshow(I);
title('Segmented Image');

%%
      GLCM2 = graycomatrix(I ,'Offset',[2 0;0 2]);
      out1 = GLCM_Features(GLCM2,0);
      feature(1,:)=out1.maxpr;
      feature(2,:)=out1.energ;
      feature(3,:)=out1.entro;
      feature(4,:)=out1.contr;
      feature(5,:)=out1.dissi;
      feature(6,:)=out1.homom;  
      feature(7,:)=out1.idmnc;
  feature
handles.fe=feature;
guidata(hObject, handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = hObject;
out=handles.out;
group=handles.group;
feature=handles.fe;


p=svm(group,out,feature(:)');

if p==1
    msgbox('Leaf type1');
end
if p==2
    msgbox('Leaf type2');
end
if p==3
    msgbox('Leaf type3');
end
if p==4
    msgbox('Leaf type4');
end
if p==5
    msgbox('Leaf type5');
end
if p==6
    msgbox('Leaf type6');
end
if p==7
    msgbox('Leaf type7');
end

if p==8
    msgbox('Leaf type8');
end
guidata(hObject, handles);
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=ones(200);
axes(handles.axes1),imshow(a);
axes(handles.axes2),imshow(a);
axes(handles.axes3),imshow(a);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
