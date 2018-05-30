function [nombreOcr,apellidoOcr] = ocrNombreTip(nombreTip)
H= fspecial('unsharp');
nombreTip= imfilter(nombreTip,H);
edgeThreshold = 0.4;
amount = 0.2;
nombreTip=localcontrast(nombreTip,edgeThreshold,amount);
[a1,a2,a3,a4,a5]= componentsTest(nombreTip);
k= component(a4,1);
a4= component(a1,1);
k= k- a4;
a4(a4<75)=0;
a4(a4>74)=255;
a5=bwareaopen(a4,300);
a5=im2uint8(a5);
a4=a4-a5;
a4=bwareaopen(a4,20);
se = strel('square',1);
a4=imopen(a4,se);
b=a4';
c=sum(b);
index=find(c>10);
[tamx,tamy]=size(index);
inicio=index(1);
final=index(tamy);
intermedio=index(floor(tamy/2));
tipNombreImg=a4(inicio:intermedio-1,:,:);
tipApellidoImg=a4(intermedio:final,:,:);
nombreOcr= ocr(tipNombreImg);
nombreOcr= nombreOcr.Text;
nombreOcr= obtenerLetras(nombreOcr);
apellidoOcr= ocr(tipApellidoImg);
apellidoOcr= apellidoOcr.Text;
apellidoOcr= obtenerLetras(apellidoOcr);
end