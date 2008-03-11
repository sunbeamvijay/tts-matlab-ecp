function [ data_out ] = arith_decode( data_in, len, model, model_data )
%ARITH_DECODE Summary of this function goes here
%   Detailed explanation goes here

    % constantes:
    FULL = uint32(2^17);
    HALF = uint32(2^16);
    ONEQ = uint32(2^15);
    THREEQ = uint32(3*2^15);
    MAX = uint32(2^15-1);
    
    rm = uint32(0);
    rM = uint32(FULL-1);

    value = uint32((2^(16:-1:0)).*data_in(1:17));
    in_pos = 18;
    
    data_out = uint8(zeros(1,len));
    
    for i=1:len
        extend = rM-rm+1;
        cum = 
        while 1
            if nrM<HALF
            elseif nrm>=HALF
                value = value-HALF;
                nrm = nrm-HALF;
                nrM = nrM-HALF;
            elseif (nrm>=ONEQ)&&(nrM<THREEQ)
                value = value-ONEQ;
                nrm = nrm-ONEQ;
                nrM = nrM-ONEQ;
            else
                break;
            end
            nrm=nrm*2;
            nrM=nrM*2+1;
            value = value*2+uint32(data_in(in_pos));
            in_pos=in_pos+1;
        end