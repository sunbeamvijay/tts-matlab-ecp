function [ B ] = BlockSplitting( I )
%BLOCKSPLITTING Summary of this function goes here
%   Detailed explanation goes here
    n = floor(size(I,1)/8);
    m = floor(size(I,2)/8);
    B = cell(n,m);
    for i=1:n
        for j=1:m
            B{i,j}=I(i*8-7:i*8,j*8-7:j*8,:);
        end
    end