function [ I ] = DrawFreq()
%DRAWFREQ Summary of this function goes here
%   Detailed explanation goes here
    A = zeros(8);
    mar = 2;
    I = zeros(8*8+mar*7);
    for i=1:8
        for j=1:8
            A(i,j)=1;
            J=idct2(A);
            A(i,j)=0;
            k=(i-1)*(8+mar);
            l=(j-1)*(8+mar);
            I(k+1:k+8,l+1:l+8) = 2*J+0.5;
        end
    end