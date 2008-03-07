function [ r ] = NumberNZcoef( B )
%NUMBERNZCOEF Summary of this function goes here
%   Detailed explanation goes here
    r=0;
    [m n] = size(B);
    for i=1:m*n
        r=r+nnz(B{i});
    end