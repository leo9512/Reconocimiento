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
%--1. Se descompone una imagen rgb en la componente 'k' del formato 'cmyk'-
%--------------------------------------------------------------------------
function a4 = components (a)
    cform=makecform('srgb2cmyk');
    a3=applycform(a,cform); 
    k=a3(:,:,4);
    a4=[k,k,k];
end