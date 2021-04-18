%% GPS location file
% LON(decimal degre) LAT(decimal degre) ALTITUDE(m) ALTITUDE_STANDARD_DEVIATION(m) STATION
strGPSlocation=get(fileedit4,'String');
coord=load(strGPSlocation);
fileGPS='correct';
for i=1:length(gravilines)
    data=evalin('base', strcat('line_',num2str(gravilines(i))));
    station=data{2};
    if (prod(1.*ismember(station,coord(:,5)))==0)
        fileGPS='uncorrect';
    end;
end;
clear data;
if strcmp(fileGPS,'uncorrect')
    indice=find(ismember(station,coord(:,5))==0);
    display('The following GPS locations are missing :');
    display(num2str(station(indice)));
else
    valGPS='on';
    interface;
end;

