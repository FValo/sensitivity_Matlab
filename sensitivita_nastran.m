function [sol, matr_coeff, res] = sensitivita_nastran(nome_file,parametro,analisi)
%--------------------------------------------------------------------------
% INPUT
% -) nome_file: nome del file bdf con cui lavorerà nastran, nome con cui
% verranno di conseguenza forniti tutti i file risultati. Nome_file non
% deve avere estensione
% -) parametro: struct contenente i nomi dei materiali, le loro schede
% con le caratterisctiche dei materiali, gli indice delle proprietà prese
% come variabili per l'analisi di sensitività
% -) analisi: se analisi = 0 allora analisi statica. Se analisi > 0 questo
% numero intero indica il numero di frequenze richieste.
%--------------------------------------------------------------------------
% OUTPUT
% -) U,F: matrice contenete i risultati di ogni analisi di
% sensitività, a seconda che si richieda in uscita spostamenti (U) oppure 
% frequenze (F). Attraverso la sua elaborazione si ottengono i coefficenti 
% di sensitività: A, B, C.
%--------------------------------------------------------------------------
% FValo

esistenza_eliminazione(nome_file,0);

num_fattori=length(find(parametro.fattori~=0));
num_livelli=2;
num_analisi=num_livelli^num_fattori; % numero di combinazioni possibili

[run] = combinazioni(num_fattori,num_livelli); % creazione matrice contenente le combinazioni su ogni riga
var_pc=10;   % variazione delle variabili di progetto
run=1+run.*var_pc/100;

% inizializzazione delle matrici contenenti i risultati
if analisi == 0
    U(:,:,1)=zeros(num_analisi,6);
    U(:,:,2)=zeros(num_analisi,6);
else
    F=zeros(num_analisi,analisi);
end


for i=1:num_analisi
    
    %modifica delle variabili in input all'analisi
    [para_mod] = modifica_parametro(parametro,run(i,:));
    
    % aggiornamento del file.bdf con le caratteristiche dei materiali
    % opportunamente aggiornate
    fid=fopen([nome_file '.bdf'],'r+');
    read_write_material(fid,para_mod);
    fclose(fid);
    
    
    % eseguire Nastran
    fbdf=[nome_file '.bdf'];
    
    str=['output=system(''C:\Programmi\MSC.Software\NaPa_SE\20211\Nastran\bin\nastran.exe scr=yes ',fbdf,''');'];
    eval(str);
   
    % estrazioni risultati
    fid2=fopen([nome_file '.f06'],'r');
   
    if analisi > 0
        [f] = MaxFrequency(fid2,analisi);
        F(i,:)=f';
    else
        [u1,u2] = MaxDisplacements(fid2);
        U(i,:,1) = u1 ;
        U(i,:,2) = u2 ;
    end

    fclose(fid2); 
   
    
    % eliminazione files eventualmente presenti;
    esistenza_eliminazione(nome_file,i-1);
    
   
   %---------------------------------------------------------------------
   % Contatore analisi;
   
   disp(' ');
   disp( '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
   disp([' TERMINATA ANALISI ',num2str(i),' DI ',num2str(length(run)),'']);
   disp( '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
   disp(' ');   
       
end


if analisi == 0
    sol=U;
else
    sol=F;
end

% Si determinano i coefficienti del modello approssimato che si vuole 
% definire nella forma: y=bo+b1*x1+b2*x2+b3*x3+...
matr_coeff=zeros(analisi,num_fattori+1);
matr_coeff(:,1)=median(F);
for i=1:num_fattori
    matr_coeff(:,i+1)=1/2*median(run(:,i).*F);
end

% calcolo del residuo
Y=run*matr_coeff(:,2:end)' + ones(size(run,1),1)*matr_coeff(:,1)';
res=F-Y;


end