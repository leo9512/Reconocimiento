
%--------------------------------------------------------------------------
%------- Identificación de personas por medio de la tip y cédula-----------
%------- Por: Neyder Leoncio Daza Cardona    neyder.daza@udea.edu.co ------
%-------      Estudiante ingeniería de sistemas  --------------------------
%-------      CC 1035918365 -----------------------------------------------
%-------      Maria Isabel Martínez Rendón   maria.martinez3@udea.edu.co --
%-------      Estudiante ingeniería de sistemas  --------------------------
%-------      CC 1046912393 -----------------------------------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- mayo de 2018--------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Se inicializa la interfaz gráfica------------------------------------
%--------------------------------------------------------------------------
function varargout = segmentacion(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @segmentacion_OpeningFcn, ...
                   'gui_OutputFcn',  @segmentacion_OutputFcn, ...
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


% --- Executes just before segmentacion is made visible.
function segmentacion_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = segmentacion_OutputFcn(hObject, eventdata, handles) 
% ---- Se le asigna la imagen de la camara no disponible en nuestra
% interfaz grafica inicial-------------------------------------------------
varargout{1} = handles.output;
cc=imread('cam.png');%se lee la imagen de la camara no disponible
image(cc,'Parent',handles.cam);%Se le asigna a la componente de la interfaz la imagen de la camara no disponible
axes(handles.cam);%Se le axigna al axes la imagen de la camara
axis off;


%--------------------------------------------------------------------------
%--2.Se programa el botón "Encender cámara"--------------------------------
%--------------------------------------------------------------------------
function camara_on_Callback(hObject, eventdata, handles)
    % --en primera instancia se dejan no visibles algunos botones y algunas
    % areas ya que la camara no esta disponible. --------------------------
    set(handles.cam,'Visible','on');
    set(handles.camara_on,'Visible','off');
    set(handles.procesar_frontal,'Visible','on');
    set(handles.procesar_trasera,'Visible','on');
    set(handles.procesar_tip,'Visible','on');
    set(handles.camara_off,'Visible','on');
    set(handles.compararBtn,'Visible','on');
    axes(handles.cam);
    handles.output = hObject;
    handles.rgb =[];
    handles.noback =[];
    %--- Se le asigna al area izquierda la visualización de la camara del
    %computador -----------------------------------------------------------
        try
            handles.vid=videoinput('winvideo');
           % handles.vid.HorizontalFlip='on';
            start(handles.vid);
            guidata(hObject,handles);
            vidRes = get(handles.vid,'VideoResolution');
            nBands = get(handles.vid,'NumberOfBands');
            hImage = image(zeros(vidRes(2),vidRes(1),nBands),'Parent',handles.cam);
            guidata(hObject,handles);
            thisBB = [150 50 1000 600];
            rectangle('Position',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',2 );
            preview(handles.vid,hImage);
            %--- En caso de algun error que tenga que ver con la camara, se
            %le asigna por defecto al area izquierda la imagen de la camara
            %no disponibles -----------------------------------------------
        catch
            msgbox('No hay cámara conectada')
            hImage = image(imread('cam.png'),'Parent',handles.cam);
        end

%--------------------------------------------------------------------------
%--3.Se programa el botón "Procesar cédula frontal"------------------------
%--------------------------------------------------------------------------
function procesar_frontal_Callback(hObject, eventdata, handles)
    handles.rgb=getsnapshot(handles.vid);%se toma una captura de pantalla de la camara
    a= areaInteres(handles.rgb);%se haya el area de interes de la captura de pantalla
    handles.rgb=cedulaFrontal(a);%se haya el area de interes, en este caso el numero, nombre y apellidos de la cédula
    guidata(hObject,handles);%se exponen todas las variables 
    image(handles.rgb,'Parent',handles.segmentos);%se le asigna al area derecha superior el area de interes hayada(numero,nombres y apellidos)
    axes(handles.segmentos);%se le asigna al axes dicha imagen
    axis off;

%--------------------------------------------------------------------------
%--4.Se programa el botón "Apagar cámara"----------------------------------
%--------------------------------------------------------------------------
function camara_off_Callback(hObject, eventdata, handles)
%--- Al hacer click en apagar camara se deshabilitan ciertas areas y botones
%de la interfaz -----------------------------------------------------------
set(handles.cam,'Visible','off');
set(handles.camara_on,'Visible','on');
set(handles.procesar_frontal,'Visible','off');
set(handles.procesar_trasera,'Visible','off');
set(handles.procesar_tip,'Visible','off');
set(handles.camara_off,'Visible','off');
set(handles.compararBtn,'Visible','off');
cc=imread('cam.png');%se lee la imagen de la camara inhabilitada
image(cc,'Parent',handles.cam);%se le asigna al area de la camara la imagen de la camara inhabilitada
axes(handles.cam);%se le asigna al axes la imagen de la camara inhabilitada
axis off;
closepreview;%se deshabilita la visualización de la camara del computador

%--------------------------------------------------------------------------
%--5.Se programa el botón "Procesar cédula trasera"------------------------
%--------------------------------------------------------------------------
function procesar_trasera_Callback(hObject, eventdata, handles)
    handles.a=getsnapshot(handles.vid);%se hace una captura de imagen de la camara
    a= areaInteres(handles.a);%se haya el area de intertes de la captura de pantalla
    handles.a=cedulaTrasera(a);%se haya el area de interes, en este caso la barra de codigo de la cédula
    guidata(hObject,handles);%se exponen todas las variables 
    image(handles.a,'Parent',handles.cedula_trasera);%se le asigna al area derecha del medio el area de interes hayada(barra de código)
    axes(handles.cedula_trasera);%se le asigna al axes dicha imagen
    axis off;

%--------------------------------------------------------------------------
%--6.Se programa el botón "Procesar tip"-----------------------------------
%--------------------------------------------------------------------------
function procesar_tip_Callback(hObject, eventdata, handles)
    handles.b=getsnapshot(handles.vid);%se hace una captura de pantalla de la camara
    b= areaInteres(handles.b);%se haya el area de intertes de la captura de pantalla
    handles.b=tip(b);%se haya el area de interes, en este caso el numero, nombre completo y número de identificacion
    guidata(hObject,handles);%se exponen todas las variables 
    image(handles.b,'Parent',handles.tip);%se le asigna al area derecha inferior el area de interes hayada(nombre completo y cédula)
    axes(handles.tip);%se le asigna al axes dicha imagen
    axis off;


% --- Executes on button press in compararBtn.
function compararBtn_Callback(hObject, eventdata, handles)
    match=comparaTipCedula(handles.b,handles.rgb);
    if(match==1)
        msgbox('La tip y cedula ingresada corresponden a la misma persona');
    else
        msgbox('La tip y cedula ingresada no corresponden a la misma persona, intentelo de nuevo');
end

% hObject    handle to compararBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
