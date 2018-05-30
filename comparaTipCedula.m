function match = comparaTipCedula(tipImg, cedImg)
    [numeroTip,nombreTip,apellidosTip]= ocrTip(tipImg); %numt,nomt,apet
    [numeroCed,nombreCed,apellidosCed] = ocrCedulaFrontal(cedImg);
    [x1,y1]=size(numeroCed);
    [x2,y2]=size(numeroTip);
    tamNumero=min(y1,y2);
    [x1,y1]=size(nombreTip);
    [x2,y2]=size(nombreCed);
    tamNombre=min(y1,y2);
    [x1,y1]=size(apellidosTip);
    [x2,y2]=size(apellidosCed);
    tamApellidos=min(y1,y2);
    arrayNombre=zeros(1,tamNombre);
    arrayApellidos=zeros(1,tamApellidos);
    arrayNumero=zeros(1,tamNumero);
    for i=1:tamNombre
        if(nombreCed(i)==nombreTip(i))
            arrayNombre(i)=1;
        else
            arrayNombre(i)=0; 
        end
    end
    
    for i=1:tamApellidos
         if(apellidosCed(i)==apellidosTip(i))
            arrayApellidos(i)=1;
        else
            arrayApellidos(i)=0; 
        end
    end
    
     for i=1:tamNumero
         if(numeroCed(i)==numeroTip(i))
            arrayNumero(i)=1;
        else
            arrayNumero(i)=0; 
        end
    end
    valNumero = sum(arrayNumero == 1);
    valNombre=sum(arrayNombre == 1);
    valApellidos=sum(arrayApellidos == 1);
    umbralNumero= floor(tamNumero*0.7);
    umbralNombre= floor(tamNombre*0.7);
    umbralApellidos= floor(tamApellidos*0.7);
    match= 0;
    
    if(valNumero>=umbralNumero)
        if(valNombre>=umbralNombre)
            if(valApellidos>=umbralApellidos)
                match=1;
            end
        end
    end
end