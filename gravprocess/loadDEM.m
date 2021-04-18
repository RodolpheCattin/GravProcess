%% DEM file
% LON(decimal degre) LAT(decimal degre) ALTITUDE(m)
display('Please wait ... Reading DEM file can take 30-60 s');
strDEM=get(fileedit7,'String');
[londem,latdem,zdem]=textread(strDEM);
valDEM='on';
interface;
