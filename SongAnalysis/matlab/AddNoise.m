
function SigN = AddNoise(Sig,lev)
    % lev est l'ecart type du bruit blanc
    pwr = log10(lev*lev)*10; %en db
    
    SigN = Sig + wgn(1,length(Sig),pwr);