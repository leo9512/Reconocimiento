%--------------------------------------------------------------------------
%------- Identificaci�n de personas por medio de la tip y c�dula-----------
%------- Por: Neyder Leoncio Daza Cardona    neyder.daza@udea.edu.co ------
%-------      Estudiante ingenier�a de sistemas  --------------------------
%-------      CC 1035918365 -----------------------------------------------
%-------      Maria Isabel Mart�nez Rend�n   maria.martinez3@udea.edu.co --
%-------      Estudiante ingenier�a de sistemas  --------------------------
%-------      CC 1046912393 -----------------------------------------------
%------- Curso B�sico de Procesamiento de Im�genes y Visi�n Artificial-----
%------- mayo de 2018--------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Ac� se identifica el area de interes(c�dula o tip)-------------------
%--------------------------------------------------------------------------
function a=areaInteres(img)
    a4=components(img);%Se saca la componente k de la imagen en formato 'cmyk'
    k=component(a4,1);%Sacamos la primera componente de la imagen ya que esta en 3 capas, cada capa es 'k', 'k', 'k'
    k(k<128)=0;%se establece un umbral donde si el color es menor a 128 entonces se pone negro
    k(k>127)=255;%se establece un unbral donde si el color es mayor a 127 entonces se pone de color blanco 
    k=imcomplement(k);%se invierten los colores, lo negro se vuelve blanco y lo blanco negro
    k=imfill(k);%se rellenan las areas peque�as
    se = strel('diamond',10);%aplica elemento estrucurante en un diamante
    k=imerode(k,se);% se quit el ruido de la imagen
    [l,n]=bwlabel(k);total=[];%se identifican todas las areas de la imagen
    for i=1:n%se recorren todas las areas
        k1=k*0;%se hace una copia en negro de la imagen
        k1(l==i)=i;suma=sum(k1(:));total=[total,suma];%hallamos el tama�o de cada area
    end
    mx=max(total(:));%hallamos el area m�s grande
    ind=find(total==mx);%buscamos el indice en el arreglo de areas donde este el area m�s grande
    k1=k*0;%nuevamente se hace una copia de imagen
    k1(l==ind)=255;%capturamos nuestra area m�s grande (la que queremos)
    [x,y]=find(k1>0);%hallamos el tama�o de nuestra imagen, en X y Y
    fm=min(x);fx=max(x);%se halla el valor minimo y maximo de x
    cm=min(y);cx=max(y);%se halla el valor minimo y maximo de y
    b=img(fm:fx,cm:cx,:);%de la imagen original, creo una nueva imagen, solo con mi area de interes (c�dula o tip)
    a=b;%se retorna la nueva imagen
end