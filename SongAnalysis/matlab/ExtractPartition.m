
function notes = ExtractPartition(lfreq,duree,tempo)
    N = length(lfreq);
    % lfreq = log10(freq)
    
    fC4 = log10(261.63); % DO3, do de la cle de sol
    %fDelta = log10(29.135/27.5);
    
    posnote = round(12*(lfreq-fC4)/log10(2)); % position de la note par rapport à C4 en demi ton
%    octave = floor(posnote/12);
%    note = mod(posnote,12);
    
 %   notation = {'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B'};
    notation = {'C,';'C,#';'D,';'D,#';'E,';'F,';'F,#';'G,';'G,#';'A,';'A,#';'B,';
                'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B';
                'c';'c#';'d';'d#';'e';'f';'f#';'g';'g#';'a';'a#';'b';
                'c''';'c''#';'d''';'d''#';'e''';'f''';'f''#';'g''';'g''#';'a''';'a''#';'b''' };
    
    notes={};
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
        if(posnote(i)+13<1)
            note(i) = {[ 'Z', strd ]};
        else
            notes(i) = {[ notation{13+posnote(i)}, strd ]};
        end
    end
    
