function [ dico ] = create_dico(  )
%CREATE_DICO Summary of this function goes here
%   Detailed explanation goes here
    dico.numb_entry = 256;
    dico.size = 512;
    dico.data=cell(512,1);
    
    for i=1:256
        dico.data{i}=char([i-1]);
    end
    
    dico.Find = @dico_find;
    dico.Insert = @dico_insert;
    dico.Get = @dico_get;
    
function k = dico_find(dico, str)
    k = find( strcmp(dico.data,char(str)),1);
    
function dico2=dico_insert(dico,str)
    dico.numb_entry=dico.numb_entry+1;
    if dico.numb_entry>dico.size
        dico.data = cat(1,dico.data,cell(dico.size,1));
        dico.size = dico.size*2;
    end
    dico.data{dico.numb_entry}=char(str);
    dico2=dico;
    
function str = dico_get(dico,k)
    str = dico.data{k};