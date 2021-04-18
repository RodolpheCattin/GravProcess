%% Fixed the value of parameters used for the mesh refinement
strDEMparam=get(fileedit8,'String');
tempo=str2num(strDEMparam);
resolution=tempo(1);
distancemax=tempo(2);
coeffaugmente=tempo(3); 
clear filetext8 fileedit8 tempo;
valmesh='on';
interface;
