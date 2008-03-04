% SUBSASGN
%
% Implements indexing the hashtable with assignment
%
% Copyright Brad Phelan 2005
% http://xtargets.com
function h = subsref(h, S, B) 
    switch S(1).type
    case '.'
        if length(S)>1
            v = h.get_fun(S(1).subs, false);
            v = subsasgn(v, S(2:end), B);
            h.put(S(1).subs, v);
        else
            h.put(S(1).subs, B);
        end
    otherwise
        error('Unsuported Indexing');
    end
end 
