%% Pressure file
% STATION PRESSURE (hPa) TIME(hh:mm:ss displayed in Greenwich Mean Time) DATE(year/month/day)  
strpressure=get(fileedit10,'String');
fid=fopen(strpressure,'r');
data=textscan(fid, '%10.7f %10.7f %s %s');
pressurestation=data{1};
pressure=data{2};
pressurehour=data{3};
pressuredate=data{4};
valair='on';
interface;