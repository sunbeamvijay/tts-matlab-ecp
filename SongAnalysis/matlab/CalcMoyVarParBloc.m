
function [moy,var] = CalcMoyVarParBloc(data,id,sizebloc)
% calcul la moyenne et la variance de chaque bloc de sizebloc element
% debutant en id dans data

    % carré element par element
    data2 = data.*data;
    
    moy = data(id);
    var = data2(id);
    for i=1:sizebloc-1
        moy = moy+data(id+i);  %  sum(x)
        var = var+data2(id+i); %  sum(x²)
    end;
    moy = moy/sizebloc; % sum(x)/n
    var = var/sizebloc-moy.^2; % sum(x²)/n-E(x)² == E(x²)-E(x)²
