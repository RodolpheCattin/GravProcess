%% pressure correction
pressureplot=[];
for i=1:length(gravilines)
    data=evalin('base', strcat('line_',num2str(gravilines(i)),'_tidal'));
    station=data{2};
    hour=data{12};
    date=data{15};
    c_pressure=zeros(size(station));
    lon_pressure=zeros(size(station));
    lat_pressure=zeros(size(station));
    val_pressure=zeros(size(station));
    if (pressuretest==1)
        [YY,MO,DD]=datevec(date);
        [AS,BS,CS,hh,mm,ss]=datevec(hour);
        TIME=[YY,MO,DD,hh,mm,ss];
        timedata=datenum(TIME) - datenum(YY,1,1);
        [YYp,MO,DD]=datevec(pressuredate);
        [AS,BS,CS,hh,mm,ss]=datevec(pressurehour);
        pressureTIME=[YYp,MO,DD,hh,mm,ss];
        timepressure=datenum(pressureTIME) - datenum(YY(1),1,1);
        %
        for j=1:length(data{1})
            indice=find(coord(:,5)==station(j));
            altitude=coord(indice,3);
            lon_pressure(j)=coord(indice,1);
            lat_pressure(j)=coord(indice,2);
            Pzo=1013.25*(1-(0.0065*altitude)/288.15)^5.2559;
            indice=find(pressurestation==station(j));
            [val,indicetemps]=min(timepressure(indice)-timedata(j));
            c_pressure(j)=0.3e-3*(pressure(indicetemps)-Pzo);
            val_pressure(j)=pressure(indicetemps);
        end;
    end;
    data{4}=data{4}-c_pressure;
    assignin('base',strcat('line_',num2str(gravilines(i)),'_tidal_pressure'),data);
    pressureplot=cat(1,pressureplot,[lon_pressure lat_pressure c_pressure val_pressure]);
end;
clear data;