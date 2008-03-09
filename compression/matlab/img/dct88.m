function [ F ] = dct88( V )
    T=zeros(8);
    for i=1:8
        T(i,:) = dct8(V(i,:));
    end
    for i=1:8
        F(:,i) = dct8(T(:,i));
    end    