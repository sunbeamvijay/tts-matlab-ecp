
function pic = DetecPic(data,size,seuil)
% detect les pic en comparant les valeurs à la moyenne glissante sur size
% element avec un facteur de seuil multiplication
% size est impaire, le resultat à length(data)-(size-1) elements.

    N = length(data);

	% moyennage
	delta = (size-1)/2;
    datamoyen = zeros(1,N-(size-1));

	% version, beaucoup plus lente (environs N fois plus lente)
%	for k = 1+delta:N-delta
%		accu = 0;
%		for i=-delta:delta;
%			accu = accu + data(k+i);
%		end
%		datamoyen(k-delta);
%	end

    for i=-delta:delta
        datamoyen = datamoyen + data(delta+1+i:N-delta+i);
    end;
    
    % detection des pics

	% version, beaucoup plus lente (environs N fois plus lente)
%	for k = 1+delta:N-delta
%		pic(k-delta) = data(k)>(seuil*datamoyen(k-delta)/size);
%	end
    
	pic = data(delta+1:N-delta)>(seuil*datamoyen/(size));
    
