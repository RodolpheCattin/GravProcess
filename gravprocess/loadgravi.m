%% Gravity data file
% format: LINE STATION ALTITUDE(m) GRAVITY(mGal) STANDARD_DEVIATION(mGal)
% TILTX(arc_seconds) TILTY(arc_seconds) TEMPERATURE(temperature correction
% in mGal) TIDE(tidal correction in mGal) DURATION(duration of the reading in seconds)
% REJECTED(number of rejected measurements during the reading) TIME(hh:mm:ss displayed in Greenwich
% Mean Time) DECIMAL_TIME(h.hhh displayed in Greenwich Mean Time) TER(terrain correction in mGal)
% DATE(year/month/day)
strdatagravi=get(fileedit3,'String');
for i=1:length(gravilines)
    fid=fopen(strcat(num2str(gravilines(i)),strdatagravi),'r');
    data=textscan(fid, '%12.7f %12.7f %7.4f %8.3f %5.3f %6.1f %6.1f %f %f %d %d %s %11.5f %6.4f %s');
    % delete data with a standard deviation > 0.2
    indice=find(data{5}>0.2);
    for j=1:length(data)
        data{j}(indice)=[];
    end;
    % apply calibration coefficient 
    data{4}=K(i)*data{4};
    assignin('base',strcat('line_',num2str(gravilines(i))),data);
    fclose(fid);
end;
clear data;
valgravi='on';
interface;
