%% Tidal correction
tideplot=[];
for i=1:length(gravilines)
    data=evalin('base', strcat('line_',num2str(gravilines(i))));
    station=data{2};
    hour=data{12};
    date=data{15};
    [YY,MO,DD]=datevec(date);
    [AS,BS,CS,hh,mm,ss]=datevec(hour);
    TIME=[YY,MO,DD,hh,mm,ss];
    c_earthtide=zeros(size(station));
    c_oceantide=zeros(size(station));
    lontide=zeros(size(station));
    lattide=zeros(size(station));
    for j=1:length(data{1})
        indice=find(coord(:,5)==station(j));
        c_earthtide(j)=1e-3*earth_tide(coord(indice,2),coord(indice,1),TIME(j,:));
        if (tidaltest==1)
            c_oceantide(j)=ocean_tide(coord(indice,1),coord(indice,2),TIME(j,:),lon_ocean,lat_ocean);
        else
            c_oceantide(j)=0;
        end;
        lontide(j)=coord(indice,1);
        lattide(j)=coord(indice,2);
    end;
    data{4}=data{4}-c_earthtide-c_oceantide;
    data{16}=datenum(TIME) - datenum(YY,1,1);
    assignin('base',strcat('line_',num2str(gravilines(i)),'_tidal'),data);
    tideplot=cat(1,tideplot,[lontide lattide c_earthtide c_oceantide]);
end;
clear data;