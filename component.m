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
%--1. se obtine una capa en especifico de una imagen-----------------------
%--------------------------------------------------------------------------
function [b] = component(a,c)
    [fil,col]=size(a);
    if c==1; ind=1:col/3;end
    if c==2;ind=col/3+1:col/3*2;end
    if c==3;ind=col/3*2+1:col/3*3;end
    b=a(:,ind);
end