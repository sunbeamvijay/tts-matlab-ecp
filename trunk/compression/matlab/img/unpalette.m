function [ I ] = unpalette( II, Pal )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here
    I = uint8(reshape(Pal(II,:),size(II,1),size(II,2),3));