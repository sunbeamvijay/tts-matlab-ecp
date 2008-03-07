function I_new=extrema_killer(I,treshold,N_neighborhood)

if nargin<3
    N_neighborhood=8;
end

if N_neighborhood~=8&&N_neighborhood~=4
    error('N_neighborhood should be either 4 or 8!')
end

levels=0:255;
level_set=im2ls(I,levels);
for i=1:length(level_set)
    level_set{i}=small_component_remove(level_set{i},treshold,N_neighborhood);
end
I_new=ls2im(level_set,levels);

I=-I_new;
levels=-255:0;
level_set=im2ls(I,levels);
for i=1:length(level_set)
    level_set{i}=small_component_remove(level_set{i},treshold,N_neighborhood);
end
I_new=-ls2im(level_set,levels);

I_new=uint8(I_new);