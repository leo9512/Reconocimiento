 function [tipApellidoImg,tipNumeroImg]=separaTip(img)
    nombreApellido=img;
    numero=img;
    [a1,a2,a3,a4,a5]= componentsTest(img);
    a5=component(a1,1);
    a5(a5>100)=255;
    a5(a5<101)=0;
    regionNumero=a5';
    suma=sum(regionNumero);
    [tamx,tamy]=size(regionNumero);
    index=find(suma>50000);
    ind=find(suma<10000);
     tipApellidoImg=nombreApellido(ind(1):tamy-1,:,:);
     tipNumeroImg=numero(index(1):ind(1),:,:); 
   end 