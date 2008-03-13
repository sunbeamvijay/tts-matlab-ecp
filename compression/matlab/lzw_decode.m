function [ out ] = lzw_decode( I ,len)
%LZW_DECODE Summary of this function goes here
%   Detailed explanation goes here

    N = length(I(:));
    out=zeros(len,1);
    out_pos=1;
    
    dico = create_dico();
    
    w=I(1);
    out(1)=w;
    out_pos=2;
    for i=2:N
        k= I(i);
        if k>255
            if k<dico.numb_entry
                e = dico.Get(dico,k+1);
            else
                e= [w w(1)];
            end
        else
            e=k;
        end
        L = length(e);
        out(out_pos:out_pos+L-1) = e;
        out_pos=out_pos+L;
        dico = dico.Insert(dico,[w e(1)]);        
        w=e;
    end
    out = out(1:out_pos-1);
    

%    read a char k;
%    output k;
%    w = k;
%    while (read a char k) do
%       if (k > 255 && index k exists in dictionary) then
%           entry = dictionary entry for k;
%       else if (k > 255 && index k does not exist in dictionary)
%           entry = w + w[0];
%       else
%           entry = k;
%       endif
%       output entry;
%       add w+entry[0] to the dictionary;
%       w = entry;
%    done
