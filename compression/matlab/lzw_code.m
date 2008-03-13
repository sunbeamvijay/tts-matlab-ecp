function [ out ] = lzw_code( I )
%LZW_CODE Summary of this function goes here
%   Detailed explanation goes here
    I=uint8(I(:));
    N = length(I);
    out=zeros(N,1);
    out_pos=1;
    
    dico = create_dico();
    
    w=[];
    for i=1:N
        wc=[w I(i)];
        k=dico.Find(dico,wc);
        if isempty(k)
            dico = dico.Insert(dico,wc);
            out(out_pos)=dico.Find(dico,w)-1;
            out_pos=out_pos+1;
            w=I(i);
        else
            w = wc;
        end
    end
    out(out_pos)=dico.Find(dico,w)-1;
    out = out(1:out_pos);
    
%    w = NIL;
%    while (read a char c) do
%        if (wc exists in dictionary) then
%            w = wc;
%        else 
%            add wc to the dictionary;
%            output the code for w;
%            w = c;
%        endif
%    done
%    output the code for w;
