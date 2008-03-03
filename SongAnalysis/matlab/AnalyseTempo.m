
function tempo = AnalyseTempo(duree)
% renvoit la durée de base du morceau, entre 0.25s et 0.75s


% probleme quand le tempo pres des bord, ca wrap
% on fait l'analyse sur deux fenêtres et on prend celle de variance minimal pour limiter ce probleme

    % fenetre de valeur entre 0.25 et 0.5
    ldm = mod(log(duree/0.25)/log(2),1);
    % fenetre de valeur entre 0.375 et 0.75
    ldm2 = mod(log(duree/0.375)/log(2),1);
    
    % on choisi la fenetre à variance minimal
    if(var(ldm)<var(ldm2))
	% on exclu les valeurs totalement fausse (temp=1 si dans l'interval moy+-2var)
        temp = abs(ldm-mean(ldm))<2*sqrt(var(ldm));
        tempo = 0.25*2^((ldm*temp')/sum(temp)); % moyenne (des valeurs 'correctes') et delogarisation
    else
	% on exclu les valeurs totalement fausse (temp=1 si dans l'interval moy+-2var)
        temp = abs(ldm2-mean(ldm2))<2*sqrt(var(ldm2));
        tempo = 0.375*2^((ldm*temp')/sum(temp)); % moyenne (des valeurs 'correctes') et delogarisation
    end
    
    % delogarisation==exponentiation, on supprime l'effet du precedent log ;)
