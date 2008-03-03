
function [lfreq,duree] = AnalyseNote(freq,constantes)
% lfreq==log10(frequence)
% duree en s

% v2
% voir la version 1 pour quelque chose de plus simple (ci dessous)
    
    % calcul la moyenne et la variance de bloc de 6 elements	
    [moy,varr] = CalcMoyVarParBloc(log10(freq),1:length(freq)-6,6);
    % puis detecte les pics de variance
    %pic = DetecPic(varr,15,2);
	% pour reduire l'effet du bruit, l'utilisation du log aide (experimental)
    temp = log(varr(8:end-8)+1e-9); % +1e-9 pour pas avoir de log(0)
    pic = temp>(mean(temp)+sqrt(var(temp)));
    
     % on parcours toutes les valeurs pour creer les notes
     mactu = 0; 
     nactu = 0;
     snactu = 0;
     lfreq=[];
     duree=[];
     state = pic(1);
     for i=1:length(pic)-1
         if(state==0)
             if(pic(i)==0)
		 % on accumule les valeurs et la durée de la note
                 mactu = mactu+moy(7+i);
                 nactu = nactu+1;
             else
		 % jusqu'a rencontrer un pic
                 state = 1;
                 mactu=mactu/nactu;
                 nactu=nactu+snactu/2;
                 snactu=1;
             end;
         else
             if(pic(i)==0)
		 % voici une nouvelle note, on stock l'ancienne
                 state = 0;       
                 lfreq = [ lfreq, mactu];
                 duree = [ duree, (nactu+snactu/2)*constantes.TimeUnit ];
                 mactu = moy(7+i);
                 nactu = 1;
             else
		 % la durée du pic est prise en compte
                 snactu=snactu+1;
             end;
         end;
     end;

    % on perd la derniere note, faudrai faire le code de fin de boucle


% v1
%     [moy,var] = CalcMoyVarParBloc(log10(freq),1:6:length(freq)-6,6);
%     pic = DetecPic(var,5,2);
%     shift = [0, find(pic), length(pic)+1];
%     
%     N = length(shift)-1;
%     
%     freq = zeros(1,N);
%     duree = zeros(1,N);
%     
%     for i=1:length(shift)-1
%         duree(i) = shift(i+1)-shift(i)-1;
%         if duree(i)>0 
%             freq(i) = mean(moy(shift(i)+1:shift(i+1)-1));
%         end;
%     end;
%         
   
