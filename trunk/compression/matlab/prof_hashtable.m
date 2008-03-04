h = hashtable;
tic
for i = 1:10000
    h.(sprintf('XXX%d', i)) = i;
end
toc
for i = 1:1000
    if h.(sprintf('XXX%d', i)) ~= i
        error('bad key');
    end
end
tic
h = hashtable2;
tic
for i = 1:10000
    put(h, sprintf('XXX%d', i), i);
end
toc


