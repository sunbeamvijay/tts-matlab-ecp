function [ S ] = deconstruct( I )
%DECONSTRUCT Summary of this function goes here
%   Detailed explanation goes here
    S{257}=[];
    for i=1:256
        S{i}=(I>=i+1);
    end