function level_set=im2ls(I,levels)
% Get the level sets from an image
% Input: levels: a vector containing all the levels at which we want to get
% the level set
% level_set{i} is the level set at the level "levels(i-1)"

if size(I,3)~=1
    I=I(:,:,1);
end
    
level_set=cell(1,length(levels));
for i=1:length(levels)
    level_set{i}=(I>=levels(i));
end