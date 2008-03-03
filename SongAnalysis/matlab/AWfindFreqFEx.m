
function freq = AWfindFreqFEx(rawdata,constantes)
% on lui passe une fenetre de raw data et la structure de contantes et elle
% calcule la frequence la plus probable de la note.
% renvoit la vrai frequence en Hz, 1 si silence

% plus maintenant
% renvoit la frequence en multiple (pas forcement entier) de la resolution de la fft

    % fenetrage des donn�es
    datafen = rawdata.*constantes.fenetrecoef;
    
    % calcul de la fft
    temp = abs(fft(datafen));
    fftdata = temp(2:constantes.lenF/2+1); %% on ignore la partie constante, fftdata(i) est le coeff de la frequence i*fbase
    
    % detection de pic par comparaison � une moyennage glissante
    fftpic = DetecPic(fftdata,constantes.lenMoyenne,constantes.ratioPicMoy);
    
    % methode anti bruit simpliste... � revoir...
	% on ne prend les pics que si leur hauteur est sup�rieur � 150. pourrais prendre une moyenne global du signal
	% � la place.
    fftpic = fftpic .* (fftdata((constantes.lenMoyenne-1)/2+1:(constantes.lenF-constantes.lenMoyenne+1)/2)>150);
    
    % selection du pic le plus bas en fr�quence
    idmin = find(fftpic)+(constantes.lenMoyenne-1)/2; % decalage a cause de detecPic
    
    if isempty(idmin)
        %freq = 1; % frequence speciale pour indiquer un silence
        freq=[];
    else
        freq=[];
        i=1; N = length(idmin);
        while i<=N
            % on ameliore la precision de la frequence en faisant un barycentre
            % avec les deux points adjacents
            % � revoir, car pas extremement precis
            id = idmin(i);
            if (i<N) && ((idmin(i)+1)==idmin(i+1))
%		[a,b,c,d] = fftdata(id-1:id+2);
           a = fftdata(id-1); b = fftdata(id); c = fftdata(id+1); d = fftdata(id+2);
		% barycentre +convertion en Hz
	        freq = [freq; constantes.FreqUnit*((id-1)*a+id*b+(id+1)*c+(id+2)*d)/(a+b+c+d) ];
                %freq = [freq; constantes.FreqUnit*(id*fftdata(id)+(id-1)*fftdata(id-1)+(id+1)*fftdata(id+1)+(id+2)*fftdata(id+2))/(fftdata(id)+fftdata(id+1)+fftdata(id-1)+fftdata(id+2))];
                i=i+1;
            else
                %[a,b,c] = fftdata(id-1:id+1);
                a = fftdata(id-1); b = fftdata(id); c = fftdata(id+1);                
                freq = [freq; constantes.FreqUnit*((id-1)*a+id*b+(id+1)*c)/(a+b+c) ];
                %freq = [ freq; constantes.FreqUnit*(id*fftdata(id)+(id-1)*fftdata(id-1)+(id+1)*fftdata(id+1))/(fftdata(id)+fftdata(id+1)+fftdata(id-1))];
            end;
            i=i+1;
        end
    end;
    
    
