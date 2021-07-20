clear
close
clc


% MAIN X SENSITIVITà
% questo codice permette di eseduire un'analisi di sensitività tramite
% solutore NASTRAN, in particolare consideriamo un'analisi su 2 livelli
% dove i fattori possono variare a scelta dell'utente da 2 a 6.
%------------------------------------------------------------------------
% i fattori in questo caso sono le proprietà dei materiali, si possono
% scegliere come variabili fino a 6 proprietà scelte fra più materiali.
% -) il terzo elemento della struct: "fattori", definisce i termini del
% vettore prop_mat che saranno scelti come varibili. Nel nostro caso
% considereremo principlamente parametro = [2 8] ---> E1 oppure ro
%------------------------------------------------------------------------

nome_file='modale_free_free';

% parametro=struct('nome_materiale',["balsa"; "comp_vetro_UD"; "alluminio"],...
%                  'prop_mat', [4 1900 50 0.49 40 40 40 1.6e-10;
%                                    2 47700 13000 0.115 4700 4700 4700 8.1e-10;
%                                    3 69000 0 0.3 0 0 0 2.8e-9],...
%                   'fattori', [2 8; 2 8; 2 8]);

parametro=struct('nome_materiale',["balsa"; "comp_vetro_UD"],...
                 'prop_mat', [3 1900 50 0.49 40 40 40 1.6e-10;
                              2 47700 13000 0.115 4700 4700 4700 8.1e-10],...
                 'fattori', [2 8; 2 8]);
                            
analisi=5;       % analisi deve appartenere a N
              
              
[sol, matr_coeff, res] = sensitivita_nastran(nome_file,parametro,analisi);





% -) se analisi = 0, allora stiamo facendo un'analisi statica
% -) se analisi > 0, allora analisi modale, con analisi = numero frequenze
% richieste.
