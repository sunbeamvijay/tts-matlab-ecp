
function [ res ] = AnalyseWaveEx( filename )

    res = 0;
    
    waverawdata = wavread(filename); %y = wavread('filename',[N1 N2]) pour une portion du fichier
    %waverawdata=filename;
    
    constantes = AWinitConstantes();
    
    len = size(waverawdata,1); %% tester
    
    fenetres = 1:441:len-constantes.lenF+1;
    
    freqs = cell(1,length(fenetres));%zeros(1,length(fenetres));
    
    for i=1:length(fenetres)
	% pour chaque fenetre, renvoit l'ensemble des pic detecté
        freqs{i} = AWfindFreqFEx(waverawdata(fenetres(i):fenetres(i)+constantes.lenF-1,1)',constantes);
    end
    
    % cherche la note correspondant à chaque pic => forme des accord si necessaire
    [lfreq,duree] = AnalyseNoteEx(freqs,constantes);
    tempo = AnalyseTempo(duree);
    % cree le format ABC
    res = ExtractPartitionEx(lfreq,duree,tempo);
    
    %res = freqs;
% echantillonage à 44,1kHz
% 2048 point par fft => 21.5Hz
% utilisation d'une fenetre : exp(-x^40)

% fenetre tout les 1/100 de s -> 441 echantillons
% detection de pic: si >2*moy(10val autour)
% calcul de barycentre avec les points entourant le pic pour plus de
% precision
