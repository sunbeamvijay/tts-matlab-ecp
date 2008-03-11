function [ H ] = Entropie1( I )
%ENTROPIE1 Summary of this function goes here
%   Detailed explanation goes here

    frequence = zeros(256);
    II = double([0, I(1:end-1)])+double(I(:)')*256;
    for i=0:256*256-1
        frequence(i+1)=sum(II==i);
    end
    nnz(frequence)
    freq_total = sum(frequence,2);
    frequence = diag(1./freq_total)*frequence;

    h=zeros(1,256);
    for i=1:256
        p = frequence(i,frequence(i,:)>0);
        h(i) = -sum( p.*log2(p) );
    end
    H = sum(h([1, I(1:end-1)+1]));
    
% a=[ 1 2 ; 3 4]
% a =
%      1     2
%      3     4
% a(2)
% ans =
%      3
% a(1,2)
% ans =
%      2