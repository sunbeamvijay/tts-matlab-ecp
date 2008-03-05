function [ I ] = reconstruction( S )
%RECONSTRUCTION Summary of this function goes here
%   Detailed explanation goes here
    I=zeros(512,512,'uint8');
%    R = false(512);
   for i=1:256
       %I(find(S{i}))=i-1;
       I(S{i})=i-1;       
   end
%     for i=256:-1:1
%         RR = S{i} &(~R);
%         I(RR)=i-1;
%         R= R|S{i};
%     end
 

