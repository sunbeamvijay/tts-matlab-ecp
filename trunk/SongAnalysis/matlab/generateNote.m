
function [wave, phasefin] = generateNote(note,tempo,phaseini)
% genere une sinusoide correspondant à la note donnée
% la note peut etre un accord (si plusieurs notes presentes)
% si accord, on prend la durée de la premiere note

    fC4 = 261.63; % DO3, base de la clé de sol
    notation = {'C,';'C,#';'D,';'D,#';'E,';'F,';'F,#';'G,';'G,#';'A,';'A,#';'B,';
                'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#';'A';'A#';'B';
                'c';'c#';'d';'d#';'e';'f';'f#';'g';'g#';'a';'a#';'b';
                'c''';'c''#';'d''';'d''#';'e''';'f''';'f''#';'g''';'g''#';'a''';'a''#';'b''' };

% parse la note
    res = regexp(note,'([a-gA-G][#,'']?)(/?[0-9]*)', 'tokens');
    %res = regexp(note,'([^/0-9 ]+)(/?[0-9]*)', 'tokens'); % separation ton/durée
    ton = strmatch(res{1}{1}, notation, 'exact'); % conversion du ton en indice
    frequence = fC4*2^((ton-13)/12); % en hertz
    if(length(res{1}{2})>0)
        if( res{1}{2}(1)=='/')
            duree = 1/str2num(res{1}{2}(2:end));
        else
            duree = str2num(res{1}{2});
        end
    else
        duree = 1;
    end
    duree=duree*tempo; % en seconde
    
    N = size(res,2);
    
    % amplitude 1
    wave = sin(2*pi*frequence*(0:1/44100:duree)+phaseini)/N;
    
    %phasefin = 2*pi*frequence*duree+phaseini; % ne veux plus rien dire...
    
    % pour les accords
    for i=2:N
        ton = strmatch(res{i}{1}, notation, 'exact'); % conversion du ton en indice
        frequence = fC4*2^((ton-13)/12); % en hertz
        wave=wave+sin(2*pi*frequence*(0:1/44100:duree)+phaseini)/N;
    end
    
    % pour faire le raccord:
    phasefin = asin(wave(end));
    if(wave(end)<wave(end-1))
        phasefin = pi-phasefin;
    end