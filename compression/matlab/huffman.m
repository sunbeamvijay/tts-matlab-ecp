function [ tree, leaf ] = huffman( in )
%HUFFMAN Summary of this function goes here
%   Detailed explanation goes here

    I = in(:);
    
    frequence = zeros(256,1);
    for i=0:255
        frequence(i+1)=sum(I==i);
    end
    freq_total = sum(frequence);
    frequence = frequence/freq_total;
    
    [proba,value] = sort(frequence);
    value = value-1;
    
    tree_proba=[];
    tree_node=[];
    
    while length(proba)+length(tree_proba)>1
        [R1,proba,value,tree_proba,tree_node] = deque_smallest(proba,value,tree_proba,tree_node);
        [R2,proba,value,tree_proba,tree_node] = deque_smallest(proba,value,tree_proba,tree_node);
        R.prob = R1.prob+R2.prob;
        R.left = R1.value;
        R.right = R2.value;
        tree_proba = [tree_proba;R.prob];
        tree_node = [tree_node;R];
    end
    
    tree = tree_node(1);
    leaf = create_leaf([], tree, {});

function [leaf] = create_leaf(prefix, subtree, leaf)
    if isstruct(subtree)
        leaf=create_leaf([prefix 0],subtree.left,leaf);
        leaf=create_leaf([prefix 1],subtree.right,leaf);
    else
        leaf{subtree+1} = prefix;
    end
    
function [R,Ap,Av,Bp,Bv] = deque_smallest(iAp,iAv,iBp,iBv)
    if isempty(iAp)
        [C,I] = min(iBp);
        R.value = iBv(I);
        R.prob = C;
        Ap=[]; Av=[]; Bp=iBp([1:I-1,I+1:end]); Bv=iBv([1:I-1,I+1:end]);
    elseif isempty(iBp)
        R.value = iAv(1);
        R.prob = iAp(1);
        Bp=[]; Bv=[]; Ap=iAp(2:end); Av=iAv(2:end);
    elseif iAp(1)<=iBp(1)
        R.value = iAv(1);
        R.prob = iAp(1);
        Bp=iBp; Bv=iBv; Ap=iAp(2:end); Av=iAv(2:end);
    else
        [C,I] = min(iBp);
        R.value = iBv(I);
        R.prob = C;
        Ap=iAp; Av=iAv; Bp=iBp([1:I-1,I+1:end]); Bv=iBv([1:I-1,I+1:end]);
    end        