function [ data_out ] = arith_code( data_in, model, model_data )
%ARITH_CODE Summary of this function goes here
%   Detailed explanation goes here

    % constantes:
    FULL = uint32(2^17);
    HALF = uint32(2^16);
    ONEQ = uint32(2^15);
    THREEQ = uint32(3*2^15);
    MAX = uint32(2^15-1);
    
    % intialisation:
    N = length(data_in(:));
    rm = uint32(0);
    rM = uint32(FULL-1);
    
    % pessimistic assumption
    data_out = logical(zeros(1,N));
    out_pos = 1;
    
    btf=0;
    
    % loop
    for i=1:N
        [cfm,cfM,cft,model_data] = model(data_in(i),model_data);
        if cft>MAX
            error('frequency count too high');
        elseif cfm==cfM
            error('null probability');
        end
        extend = rM-rm+1;
        nrm = rm + extend*uint32(cfm)/uint32(cft);
        nrM = rm + extend*uint32(cfM)/uint32(cft)-1;
        while 1
            if nrM<HALF
                [data_out,out_pos] = output_bit(0,data_out,out_pos,btf);
                btf=0;
            elseif nrm>=HALF
                [data_out,out_pos] = output_bit(1,data_out,out_pos,btf);
                btf=0;
                nrm = nrm-HALF;
                nrM = nrM-HALF;
            elseif (nrm>=ONEQ)&&(nrM<THREEQ)
                btf=btf+1;
                nrm = nrm-ONEQ;
                nrM = nrM-ONEQ;
            else
                break;
            end
            nrm=nrm*2;
            nrM=nrM*2+1;
        end
    end
    btf=btf+1;
    [data_out,out_pos] = output_bit(nrm>=ONEQ,data_out,out_pos,btf);
    data_out = data_out(1:out_pos-1);
                
                    
function [oD,op] = output_bit(b,D,p,btf)
    b=logical(b);
    D(p)=b; p=p+1;
    for i=1:btf
        D(p)=not(b); p=p+1;
    end
    oD = D;
    op=p;