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
%--1. Se captura el area de interes de la parte frontal de la cedula-------
%--------------------------------------------------------------------------
function rgb=cedulaFrontal(img)
    [x,y,z]=size(img);%se halla el tamaño de la imagen, filas,columnas y capas.
    
    %---- Se establecen los umbrales donde esta la información-------------
    fmax=floor(x*5/8);%se establece el maximo valor que pueden tomar las filas
    cmax=fix(y*1/2);%se establede el maximo valor que pueden tomar las columnas
    fmin=floor(x*3/11);%se establece el minimo valor que pueden tomar las filas
    cmin=floor(y*1/17);%se establece el minimo valor que pueden tomar las columnas
    c=img(fmin:fmax,cmin:cmax,:);%se crea una nueva imagen con las filas y columnas que se dieron con los umbrales
    rgb=c;%se retorna la nueva imagen.
end