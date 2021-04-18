%% Fixed the value of parameters used for the mesh refinement
strdegree=get(fileedit12,'String');
tempo=str2num(strdegree);
valdegree=round(tempo);
clear filetext12 fileedit12 tempo;
valdriftdegree='on';
if strcmp(valcomplete,'off')==1
    valdriftdegree='off';
    valDEMerror='on';
    DEMerror=0;
end;
interface;
