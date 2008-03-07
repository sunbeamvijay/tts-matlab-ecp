function I=ls2im(level_set,levels)
% Recontruct an image from the level sets.

% Input: levels: a vector containing all the levels at which we want to get
% the level set

I=zeros(size(level_set{1}));

[levels_sorted,indice]=sort(levels);

sub_set1=logical(zeros(size(I)));

for i=length(levels):-1:1
    j=indice(i);
    sub_set2=level_set{j}&(~sub_set1);
    I(sub_set2)=levels(j);
    sub_set1=level_set{j};
end