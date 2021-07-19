function read_write_material(fid,parametro)
% AGGIORNAMENTO BDF
%------------------------------------------------------------------------
% INPUT
% -) fid: file bdf da modificare
% -) parametro: struct contenente il nome materiale e le sue caratteritiche
% con cui formare la card MAT da sostituiere all'interno del bdf
%------------------------------------------------------------------------
% OUTPUT
% file bdf modificato e pronto per essere eseguito tramite Nastran
%------------------------------------------------------------------------

cont=0;
str='qwerty';
num_materiali=length(parametro.nome_materiale);
num_fattori=length(find(parametro.fattori~=0));

    while cont<num_fattori+1 && ~strcmp(str,'ENDDATA 52f6c89b')
        str=fgetl(fid);
        
        for i=1:num_materiali
            
            if strcmp(['$ Material Record : ' convertStringsToChars(parametro.nome_materiale(i))],str)
                str=fgetl(fid);
                stringa=scrittura_cardMAT(parametro.prop_mat(i,:));
                fprintf(fid,stringa);
                cont=cont+1;
            end
            
        end
        
%         if strcmp(['$ Material Record : ' parametro1.nome_materiale],str)
%             
%             str=fgetl(fid);
%             stringa=scrittura_cardMAT(parametro1.prop_mat);
%             fprintf(fid,stringa);
%             cont=cont+1;
%             
%         elseif strcmp(['$ Material Record : ' parametro2.nome_materiale],str)
%             
%             str=fgetl(fid);
%             stringa=scrittura_cardMAT(parametro2.prop_mat);
%             fprintf(fid,stringa);
%             cont=cont+1;
%             
%         elseif strcmp(['$ Material Record : ' parametro3.nome_materiale],str)
%             
%             str=fgetl(fid);
%             stringa=scrittura_cardMAT(parametro3.prop_mat);
%             fprintf(fid,stringa);
%             cont=cont+1;
%         end
            
    end

end

