function [u1,u2] = MaxDisplacements(fid)
   % estrazione spostamento dai nodi richiesti file.f06
   %------------------------------------------------------------------------

   nodo1=5099;
   nodo2=9721;
   
   u1=zeros(1,6);
   u2=zeros(1,6);
   cont=0;  

   while cont<2

      str=fgetl(fid);
      
      if length(str)==109 && strcmp(str,'      POINT ID.   TYPE          T1             T2             T3             R1             R2             R3')
         
         u=( fscanf(fid,'%d %c %e %e %e %e %e %e',[8 50]) )';
         
         if cont==0
             nodo=nodo1;
         else
             nodo=nodo2;
         end
         
         indice=find(u(:,1)==nodo);
         
         if indice>0
             if cont==0
                 cont=cont+1;
                 u1=u(indice,3:end);
             else
                 cont=cont+1;
                 u2=u(indice,3:end);
             end
         end
                 
      end   
   end

end

