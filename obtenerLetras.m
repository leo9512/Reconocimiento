function arrayResult = obtenerLetras(cadena)
    string = isletter(cadena);
    arrayResult='';
    index= find(string==1);
    [n,m]= size(index);
    
    for i= 1:m
        contenido= cadena(index(i));
        
        arrayResult(i)= contenido;
    end
end