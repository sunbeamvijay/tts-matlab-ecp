function [ out ] = huff_decode( in, tree )
%HUFF_DECODE Summary of this function goes here
%   Detailed explanation goes here
    out=[];
    while not(isempty(in))
        [S in] = read_symbole(in, tree);
        out=[out S];
    end

function [symbole, rest] = read_symbole(in, tree)
    if isstruct(tree) 
        if in(1)==0
            symbole=tree.left;
        else
            symbole=tree.right;
        end
        [symbole, rest]=read_symbole(in(2:end),symbole);
    else
        symbole = tree;
        rest = in;
    end
