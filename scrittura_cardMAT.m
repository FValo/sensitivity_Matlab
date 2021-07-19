function [stringa] = scrittura_cardMAT(val_prop)
% SCRITTURA CARD MATERIALE
%------------------------------------------------------------------------
% funziona per mat1 o mat8 che corrispondono a materiale isotropo oppure
% ortotropo, val prop è un vettore che contiene le caratteristiche del
% materiale con l'ordine prestabilito da mat
%------------------------------------------------------------------------


stringa=' ';
spazio='        ';
ni=erase(num2str(val_prop(4)),'0');
ro=erase(num2str(val_prop(end),'%.2e'),'e');

if strcmp(ro(end),'0')
    ro=[erase(ro,'0'),'0'];
else
    ro=erase(ro,'0');
end

if val_prop(6)==0
    stringa=['MAT1     ', num2str(val_prop(1)),...
    spazio(1:6), num2str(val_prop(2),'%.0f'),'.',...
    spazio,spazio(1:8-ceil(log10(val_prop(2)+0.01))-1), ni,...
    spazio(1:8-length(ni)), ro];
        
else
    stringa=['MAT8     ', num2str(val_prop(1)),...
    spazio(1:6), num2str(val_prop(2)),'.',...
    spazio(1:8-ceil(log10(val_prop(2)+0.01))-1), num2str(val_prop(3),'%.0f'),'.',...
    spazio(1:8-ceil(log10(val_prop(3)+0.01))-1), ni,...
    spazio(1:8-length(ni)), num2str(val_prop(5),'%.0f'),'.',...
    spazio(1:8-ceil(log10(val_prop(5)+0.01))-1), num2str(val_prop(6),'%.0f'),'.',...
    spazio(1:8-ceil(log10(val_prop(6)+0.01))-1), num2str(val_prop(7),'%.0f'),'.',...
    spazio(1:8-ceil(log10(val_prop(7)+0.01))-1), ro];
end

end

