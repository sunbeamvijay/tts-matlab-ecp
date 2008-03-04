% MWEB_HASH
% 
% h = mweb_hash( capacity, factor)
%
% Creates a new hashtable with the specified capacity and factor.
%
% Arguments
%  capacity          -  The original capacity of the hashtable
%  factor            -  When the number of items stored > capacity * factor
%                       the capacity of the table is increased
%
% Usage
%
%   h = hashtable
%   h.x = 10;
%   y = h.x;
%
% You can also use dynamic indexing with strings that
% do not map to valid matlab variable names
%
%   h = hashtable
%   h.('a funny key') = 10;
%   y = h.('a funny key');
%
function h = hashtable

   contents = [];

   h.put = @put;
   h.get = @get;
   h.display = @display_;

   h = class(h, 'hashtable');

   function display_
      structfun(@each_field, contents);
      function out = each_field(e)
          out = 0;
          if ~isempty(e)
              for j = 1:length(e)
                % Get a textual representation of the value
                val = evalc('disp(e(j).value)');
                % Strip trailing carriage returns
                while val(end) == sprintf('\n')
                    val=val(1:end-1);
                end
                fprintf('%s\t : %s\n', e(j).key, val );
             end 
          end
      end
   end


   function out = get(key)
      hkey = hashkey(key);
      if ~isfield(contents, hkey)
         out = [];
         return;
      end
      items = contents.(hkey);
      for j = 1:length(items);item = items(j);
         if isequal(item.key, key)
            out = item.value;
            return;
         end
      end
      out = [];
      return;
   end

   function put(key, value)
      entry.key = key;
      entry.value = value;

      hkey = hashkey(key);

      if ~isfield(contents, hkey)
         contents.(hkey) = entry ;
      else
         items = contents.(hkey);
         for j = 1:length(items)
             if strcmp(key, items(j).key)
                 contents.(hkey)(j) = entry;
                 return
             end
         end
         contents.(hkey)(end+1) = entry;
      end

   end
   
end

function key = hashkey(str)
    key = sprintf('x%x', hashcode(str));
end

function hash = hashcode(str)
    str = uint32(str(:))';
    hash = uint32(5381);
    im = intmax('uint32'); 
    for c = str
        t = bitshift(hash, 5);
        t = plus_overflow(t, hash, im);
        t = plus_overflow(t, c, im);
        hash = t;
    end
end

function r = plus_overflow(a, b, m)
    r = a + b;
    if r >= m
        r = b - ( m - a);
    end
end



