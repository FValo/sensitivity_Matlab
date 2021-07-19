function [frequenze] = MaxFrequency(fid,analisi)
% estrazione frequenze richieste dal file.f06
%------------------------------------------------------------------------

   fnd=true;  
   
   while fnd

      str=fgetl(fid);
      
      if length(str)==77 && strcmp(str,'                                              R E A L   E I G E N V A L U E S')
         
         fnd=false;
         
         str=fgetl(fid);
         str=fgetl(fid);
         
         f=(fscanf(fid,'%d %d %e %e %e %e %e',[7 analisi]))';
         frequenze=f(:,5);
      end   
   end

end