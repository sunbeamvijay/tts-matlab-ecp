function [ out ] = huff_code( in, leaf )
%HUFF-CODE Summary of this function goes here
%   Detailed explanation goes here
    I=in(:);
    n=length(I);
%     out=[];
%     for i=1:n
%         out=[out, leaf{I(i)+1}];
%     end
    out = zeros(n*8,1);
    pos = 1;
    for i=1:n
        code = leaf{int16(I(i))+1};
        len = length(code);
        out(pos:(pos+len-1))=code;
        pos=pos+len;
    end
    out = out(1:pos-1);