function [ diff ] = CompHuffEntr( I )
%COMPHUFFENTR Summary of this function goes here
%   Detailed explanation goes here
    H = Entropie0(I)
    [ tree, leaf ] = huffman( I );
    C = length( huff_code(I,leaf) )
    diff=(C-H)/H;