function [b]=waffer(a)
    [fil,col]=size(a);
    col=col/3;
    b=reshape(a,[fil,col,3]);
end