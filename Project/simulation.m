function varargout = simulation(varargin)
% SIMULATION MATLAB code for simulation.fig
%      SIMULATION, by itself, creates a new SIMULATION or raises the existing
%      singleton*.
%
%      H = SIMULATION returns the handle to a new SIMULATION or the handle to
%      the existing singleton*.
%
%      SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATION.M with the given input arguments.
%
%      SIMULATION('Property','Value',...) creates a new SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simulation

% Last Modified by GUIDE v2.5 28-Dec-2018 02:48:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @simulation_OutputFcn, ...
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


% --- Executes just before simulation is made visible.
function simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simulation (see VARARGIN)

% Choose default command line output for simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
xlabel('当前被感染人数');
grid on

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
xlabel('被感染过的总人数');
grid on

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
xlabel('新增患病人数');
grid on

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
xlabel('被治愈的人数');
grid on


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%将治愈者移出仿真总人数,并构建初始被感染者
H = handles.H*(handles.start_node+handles.sen);
p = handles.start_node;
parent_node = zeros(1,H*p);
i = 1;
[~,n] = size(parent_node);
while i <= n
    r = randi([1,H]);
    if (~ismember(r,parent_node))
        parent_node(i) = r;
        i = i+1;
    end
end 

% SIR模型仿真
[inf,nisum,rec,infsum] = sir_simulation(handles.WS_world,parent_node,handles.inf_prob,handles.rec_prob,handles.step);

% rec = rec + handles.H*(1-handles.start_node-handles.sen);

% 绘图
axes(handles.axes1);
plot(inf, 'b*:');
xlabel('当前被感染人数');
grid on

axes(handles.axes2);
plot(infsum, 'b*:');
xlabel('被感染过的总人数');
grid on

axes(handles.axes3);
plot(nisum, 'b*:');
xlabel('新增患病人数');
grid on

axes(handles.axes4);
plot(rec, 'b*:');
xlabel('被治愈的人数');
grid on

guidata(hObject,handles);

function population_Callback(hObject, eventdata, handles)
% hObject    handle to population (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of population as text
%        str2double(get(hObject,'String')) returns contents of population as a double
H = str2double(get(hObject,'String'));
handles.H = H;
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function population_CreateFcn(hObject, eventdata, handles)
% hObject    handle to population (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
H = str2double(get(hObject,'String'));
handles.H = H;
guidata(hObject,handles);



function K_Callback(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K as text
%        str2double(get(hObject,'String')) returns contents of K as a double
k = str2double(get(hObject,'String'));
handles.k = k;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
k = str2double(get(hObject,'String'));
handles.k = k;
guidata(hObject,handles);



function beta_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta as text
%        str2double(get(hObject,'String')) returns contents of beta as a double
b = str2double(get(hObject,'String'));
handles.b = b;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
b = str2double(get(hObject,'String'));
handles.b = b;
guidata(hObject,handles);



function steps_Callback(hObject, eventdata, handles)
% hObject    handle to steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of steps as text
%        str2double(get(hObject,'String')) returns contents of steps as a double
step = str2double(get(hObject,'String'));
handles.step = step;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
step = str2double(get(hObject,'String'));
handles.step = step;
guidata(hObject,handles);



function infect_prob_Callback(hObject, eventdata, handles)
% hObject    handle to infect_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of infect_prob as text
%        str2double(get(hObject,'String')) returns contents of infect_prob as a double
inf_prob = str2double(get(hObject,'String'));
handles.inf_prob = inf_prob;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function infect_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to infect_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
inf_prob = str2double(get(hObject,'String'));
handles.inf_prob = inf_prob;
guidata(hObject,handles);



function recovery_prob_Callback(hObject, eventdata, handles)
% hObject    handle to recovery_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recovery_prob as text
%        str2double(get(hObject,'String')) returns contents of recovery_prob as a double
rec_prob = str2double(get(hObject,'String'));
handles.rec_prob = rec_prob;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function recovery_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recovery_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
rec_prob = str2double(get(hObject,'String'));
handles.rec_prob = rec_prob;
guidata(hObject,handles);



function startnode_Callback(hObject, eventdata, handles)
% hObject    handle to startnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startnode as text
%        str2double(get(hObject,'String')) returns contents of startnode as a double
start_node = str2double(get(hObject,'String'));  
handles.start_node = start_node;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function startnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
start_node = str2double(get(hObject,'String'));
handles.start_node = start_node;
guidata(hObject,handles);


% --- Executes on button press in gen_network.
function gen_network_Callback(hObject, eventdata, handles)
% hObject    handle to gen_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H = handles.H;
k = handles.k;
beta = handles.b;
% 在新窗口进行小世界网络的展现
figure(2)
WS_world = WattsStrogatz(H,k,beta);
handles.WS_world = WS_world;
plot(graph(WS_world),'NodeColor','k','EdgeAlpha',0.1);
title('Watts-Strogatz Graph','Interpreter','latex');
guidata(hObject,handles);


% --- Executes on button press in ode.
function ode_Callback(hObject, eventdata, handles)
% hObject    handle to ode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 设置仿真步长,以及初始值
ts = 0:1:handles.step;
x0 = [handles.H*handles.sen,handles.H*handles.start_node,handles.H*(1-handles.start_node-handles.sen)];
%进行数值仿真
[t,x] = ode45(@(t,x) sirmodel(t,x,handles.inf_prob,handles.rec_prob), ts, x0);
%在新窗口绘图
figure(3);
plot(t,x(:,1),t,x(:,2),'.',t,x(:,3),'*');
xlabel('时间/天');
ylabel('比例');
legend('易感人数','患病人数','治愈人数');
title('传染病SIR模型');


% --- Executes on button press in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
UI;



function sensi_Callback(hObject, eventdata, handles)
% hObject    handle to sensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sensi as text
%        str2double(get(hObject,'String')) returns contents of sensi as a double
sen = str2double(get(hObject,'String'));
handles.sen = sen;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sensi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
sen = str2double(get(hObject,'String'));
handles.sen = sen;
guidata(hObject,handles);
