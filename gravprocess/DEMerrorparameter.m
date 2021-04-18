%% Fixed the value of DEM elevation uncertainty
strDEMerror=get(fileedit13,'String');
DEMerror=str2num(strDEMerror);
clear filetext13 fileedit13;
valDEMerror='on';
interface;
