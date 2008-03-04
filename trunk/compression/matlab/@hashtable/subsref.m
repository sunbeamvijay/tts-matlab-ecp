% SUBSREF
%
% Implements indexing the hashtable
%
% Copyright Brad Phelan 2005
% http://xtargets.com
function varargout = subsref(h, S) 
    switch S(1).type
    case '.'
        out = h.get(S(1).subs);
        if length(S) > 1
            if nargout > 0
                [varargout{1:nargout}] = subsref(out, S(2:end));
            else
                subsref(out, S(2:end));
                varargout = {};
            end
            return;
        end
        varargout = {out};
    otherwise
        error('Unsuported Indexing');
    end
end 
