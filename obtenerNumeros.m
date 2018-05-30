function arrayResult = obtenerNumeros(cadena)
    [n,m]= size(cadena);
    array = zeros(1,m);
    contador=0;
    for k = 1:m
        contenido = str2double(cadena(k));
        if(isnan(contenido))
             array(k) = 0;
        else
             array(k) = 1;
             contador= contador+1;
        end
    end
    arrayResult = zeros(1,contador);
    index= find(array==1);
    for i= 1:contador
        arrayResult(i)= str2double(cadena(index(i)));
    end
end