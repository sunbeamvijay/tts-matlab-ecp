
function note = ExtractPartitionEx(lfreq,duree,tempo)
    N = length(lfreq);
    % lfreq==round(12*log2(frequence/fC4))
    
    
 %   notation = {'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B'};
    notation = {'C,';'C,#';'D,';'D,#';'E,';'F,';'F,#';'G,';'G,#';'A,';'A,#';'B,';
                'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B';
                'c';'c#';'d';'d#';'e';'f';'f#';'g';'g#';'a';'a#';'b';
                'c''';'c''#';'d''';'d''#';'e''';'f''';'f''#';'g''';'g''#';'a''';'a''#';'b''' };
    
    note={};
    for i=1:N % pour chaque note
	% on decide son type: croche, noir, blanche...
        temp = duree(i)/tempo;
        if(round(temp)<2)
            temp2 = round(log(temp)/log(2));
            if(temp2<0)
                strd = ['/', '0'+ 2^(-temp2) ];
            else
                strd='';
            end
        else
            strd = '0'+round(temp);
        end
	% et son niveau sur la partition, puis on concatene pour faire la notation ABC
        note{i} = [];
        for j=1:length(lfreq{i})
            if(lfreq{i}(j)+13<1)
                note{i} = [note{i}, 'Z', strd ];
            else
                note{i} = [note{i}, notation{13+lfreq{i}(j)}, strd ];
            end
        end
    end
    
