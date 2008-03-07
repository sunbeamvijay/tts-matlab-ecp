function bw=small_component_remove(bw,threshold,N)
% Remove the small components. N: 4 or 8

[L,nb_comp]=bwlabel(bw,N);

for i=1:nb_comp
    comp=(L(:)==i);
    if sum(comp(:))<threshold
        L(comp)=0;
    end
end

bw=(L>0);