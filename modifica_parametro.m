function [parametro] = modifica_parametro(parametro,run)
% AGGIORNAMENTO strcut parametro
%------------------------------------------------------------------------
% INPUT
% -) parametro: strcut data in input dall'utente come visto prima
% -) run: vettore contenente la i-esima riga della matrice run
% corrispondente alla i-esima analisi. In questo vettore è indicato come
% devono variare le variabili di progetto
%------------------------------------------------------------------------
% OUTPUT
% struct parametro con prop_mat modificate
%------------------------------------------------------------------------

num_fattori=length(find(parametro.fattori~=0));
num_materiali=length(parametro.nome_materiale);

j=1;

for i=1:num_materiali
    [x,y,indice]=find(parametro.fattori(i,:));
    
    parametro.prop_mat(i,indice)=parametro.prop_mat(i,indice).*run(j:j+length(indice)-1);
    
    j=j+length(indice);
end

end

