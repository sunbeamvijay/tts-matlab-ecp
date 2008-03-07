function [ H ] = Entropie0( I )
%ENTROPIE0 Summary of this function goes here
%   Detailed explanation goes here

    frequence = zeros(256,1);
    for i=0:255
        frequence(i+1)=sum(I==i);
    end
    freq_total = sum(frequence);
    frequence = frequence/freq_total;
    
    p = frequence(frequence>0);
    h = -sum( p.*log2(p) );
    H = length(I(:))*h;