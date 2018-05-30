function numOcr = ocrNumeroTip(numTip)
    edgeThreshold = 1;
    amount = 0.6;
    figure();imshow(numTip);
    numTip = localcontrast(numTip, edgeThreshold, amount);
    [a1,a2,a3,a4,a5]= componentsTest(numTip);
    a3= component(a3,1);
    a3(a3<100)=0;
    a3(a3>99)=255;
    a3=not(a3);
    a5=bwareaopen(a3,200);
    a3=a3-a5;
    a3=bwareaopen(a3,20);
    se = strel('square',1);
    a3=imopen(a3,se);
    numOcr= ocr(a3);
    numOcr= numOcr.Text;
    numOcr= obtenerNumeros(numOcr);
end