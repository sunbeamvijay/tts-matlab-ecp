function [ F ] = dct8( V )
    persistent C;
    if(isempty(C))
        C = (0.5*cos(pi/8*(0.5:7.5)'*(0:7)))';
        C(1,:)=C(1,:)/sqrt(2);
    end
    F = C*V(:);