function [numt,nomt,apet]= ocrTip(img)
    [nombreTip,numTip]= separaTip(img);
    numt = ocrNumeroTip(numTip);
    [nomt,apet]= ocrNombreTip(nombreTip);
end
