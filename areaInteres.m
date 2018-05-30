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
%--1. Acá se identifica el area de interes(cédula o tip)-------------------
%--------------------------------------------------------------------------
function a=areaInteres(img)
    a4=components(img);%Se saca la componente k de la imagen en formato 'cmyk'
    k=component(a4,1);%Sacamos la primera componente de la imagen ya que esta en 3 capas, cada capa es 'k', 'k', 'k'
    k(k<128)=0;%se establece un umbral donde si el color es menor a 128 entonces se pone negro
    k(k>127)=255;%se establece un unbral donde si el color es mayor a 127 entonces se pone de color blanco 
    k=imcomplement(k);%se invierten los colores, lo negro se vuelve blanco y lo blanco negro
    k=imfill(k);%se rellenan las areas pequeñas
    se = strel('diamond',10);%aplica elemento estrucurante en un diamante
    k=imerode(k,se);% se quit el ruido de la imagen
    [l,n]=bwlabel(k);total=[];%se identifican todas las areas de la imagen
    for i=1:n%se recorren todas las areas
        k1=k*0;%se hace una copia en negro de la imagen
        k1(l==i)=i;suma=sum(k1(:));total=[total,suma];%hallamos el tamaño de cada area
    end
    mx=max(total(:));%hallamos el area más grande
    ind=find(total==mx);%buscamos el indice en el arreglo de areas donde este el area más grande
    k1=k*0;%nuevamente se hace una copia de imagen
    k1(l==ind)=255;%capturamos nuestra area más grande (la que queremos)
    [x,y]=find(k1>0);%hallamos el tamaño de nuestra imagen, en X y Y
    fm=min(x);fx=max(x);%se halla el valor minimo y maximo de x
    cm=min(y);cx=max(y);%se halla el valor minimo y maximo de y
    b=img(fm:fx,cm:cx,:);%de la imagen original, creo una nueva imagen, solo con mi area de interes (cédula o tip)
    a=b;%se retorna la nueva imagen
end