function [ out ] = huff_decode( in, tree, leaf )
%HUFF_DECODE Summary of this function goes here
%   Detailed explanation goes here
%     out=[];
%     while not(isempty(in))
%         [S in] = read_symbole(in, tree);
%         out=[out S];
%     end
     fast = generate_fastlookup(leaf);
     out=zeros(length(in),1);
     pos = 1;
     inpos = 1;
     inlen = length(in);
     pwr = 2.^(0:10);
     while inpos<=inlen
         if inlen-inpos>11
            tmp=1+(pwr*in(inpos:inpos+10));
            if not(isempty(fast(tmp).value))%isfield(fast(tmp),'value')
                 S = fast(tmp).value;
                inpos=inpos+fast(tmp).len;
             else
                [S inpos] = read_symbole(in,inpos, tree);
            end
        else
            [S inpos] = read_symbole(in,inpos, tree);
        end
        out(pos)= S;
        pos=pos+1;
     end
%      while not(isempty(in))
%          if length(in)>11
%             tmp=1+(pwr*in(1:11));
%             if not(isempty(fast(tmp).value))%isfield(fast(tmp),'value')
%                  S = fast(tmp).value;
%                 in = in((fast(tmp).len+1):end);
%              else
%                 [S in] = read_symbole(in, tree);
%             end
%         else
%             [S in] = read_symbole(in, tree);
%         end
%         out(pos)= S;
%         pos=pos+1;
%      end
     out=out(1:pos-1);

function fast = generate_fastlookup(leaf)
    %fast=zeros(256,1);   
     fast(2^12+1).value=[];
     pwr = 2.^(0:11);
     for i=1:256
         tmp=leaf{i};
         len=length(tmp);
         if len<12
            V=1+(pwr(1:len)*tmp');
            for W=V:2^len:2^12
                fast(W).value=i-1;
                fast(W).len=len;
            end
         end
     end
         
%     S=0;
%     for i=10:-1:1
%         in = zeros(i,1);
%         for j=0:(2^i-1)
%             tmp = j;
%             for k=1:i
%                 in(k)=(mod(tmp,2)==0);
%                 tmp=floor(tmp/2);
%             end
%             try
%                 [S,R] = read_symbole(in,tree);
%             catch
%                 R=[0];
%             end
%             if isempty(R)
%                 fast(j+1).value=S+1;
%                 fast(j+1).len=i;
%             end
%         end
%     end
    
     
% function [symbole, rest] = read_symbole(in, tree)
%     if isstruct(tree) 
%         if in(1)==0
%             symbole=tree.left;
%         else
%             symbole=tree.right;
%         end
%         [symbole, rest]=read_symbole(in(2:end),symbole);
%     else
%         symbole = tree;
%         rest = in;
%     end

% 72->0.03s

function [symbole, posf] = read_symbole(in,pos, tree)
    if isstruct(tree) 
        if in(pos)==0
            symbole=tree.left;
        else
            symbole=tree.right;
        end
        [symbole, posf]=read_symbole(in,pos+1,symbole);
    else
        symbole = tree;
        posf = pos;
    end

    