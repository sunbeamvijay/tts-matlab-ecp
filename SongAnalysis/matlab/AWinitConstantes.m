
function constantes = AWinitConstantes()
% Precalcul ce qui possible.

    constantes.lenF = 2048;
    % exp(-(1.05*x)^40) % peut etre à revoir
    constantes.fenetrecoef = exp(-(1.05*(((1:constantes.lenF)-constantes.lenF/2-0.5)/(constantes.lenF/2-0.5))).^40);
    
    constantes.lenMoyenne = 11;
    constantes.ratioPicMoy = 2;
    
    constantes.FreqUnit = 44100/constantes.lenF;
    constantes.TimeUnit = 441/44100;