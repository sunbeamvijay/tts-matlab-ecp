function [ out ] = huff_code( in, leaf )
%HUFF-CODE Summary of this function goes here
%   Detailed explanation goes here
    I=in(:);
    n=length(I);
    out=[];
    for i=1:n
        out=[out, leaf{I(i)+1}];
    end
    