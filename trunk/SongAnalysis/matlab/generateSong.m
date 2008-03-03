
function wave = generateSong(song,tempo)
    rem = song;
    wave=[];
    phase = 0;
    while(isempty(rem)~=1)
        [a,rem] = strtok(rem);
        [temp,phase] = generateNote(a,tempo,phase);
        wave = [wave, temp];
    end;