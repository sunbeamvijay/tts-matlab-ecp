
function [ res ] = AnalyseWave( filename )

    res = 0;
    
    waverawdata = wavread(filename); %y = wavread('filename',[N1 N2]) pour une portion du fichier
    
    constantes = AWinitConstantes();
    
    len = size(waverawdata,1); %% tester
    
    fenetres = 1:441:len-constantes.lenF+1;
    
    freqs = zeros(1,length(fenetres));
    
    for i=1:length(fenetres)
	% pour chaque fenêtre, chercher le pic.
	% une fenetre de 2048 points tout les 1/100e de secondes
        freqs(i) = AWfindFreqF(waverawdata(fenetres(i):fenetres(i)+constantes.lenF-1,1)',constantes);
    end
    
    % converti les pic de fréquence en une liste de note/durée
    [lfreq,duree] = AnalyseNote(freqs,constantes);
    tempo = AnalyseTempo(duree);
    % cree la partition au format ABC (sans les entete)
    res = ExtractPartition(lfreq,duree,tempo);
    
    %res = freqs;
% echantillonage à 44,1kHz
% 2048 point par fft => 21.5Hz
% utilisation d'une fenetre : exp(-x^40)

% fenetre tout les 1/100 de s -> 441 echantillons
% detection de pic: si >2*moy(10val autour)
% calcul de barycentre avec les points entourant le pic pour plus de
% precision
