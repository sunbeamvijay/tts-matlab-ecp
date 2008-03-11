function [ cfm,cfM,cft,model_data2 ] = AdaptMod0( c,model_data )
%ADAPTMOD0 Summary of this function goes here
%   Detailed explanation goes here
    c=uint32(c)+1;
    
    %model_data.MAX = 257 pour 256 pos
    
    FMAX = uint32(2^15-1);
    
    if model_data.f(model_data.MAX)==FMAX
        cum=0;
        freq = model_data.f(2:end)-model_data.f(1:end-1);
        for i=1:model_data.MAX-1
            cum=cum+(freq(i)+1)/2;
            model_data.f(i+1)=cum;
        end
    end
    for i=c+1:model_data.MAX
        model_data.f(i)=model_data.f(i)+1;
    end
    cft=model_data.f(model_data.MAX);
    cfm=model_data.f(c);
    cfM=model_data.f(c+1);
    model_data2=model_data;