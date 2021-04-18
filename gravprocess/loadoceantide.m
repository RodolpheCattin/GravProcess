%% load ocean tide parameter
i=0;
stroceantidal=get(fileedit9,'String');
fid = fopen(stroceantidal, 'rt');
lon_ocean=[];
lat_ocean=[];
while feof(fid) == 0
    tline = fgetl(fid);
    matches = findstr(tline,'lon/lat');
    num = length(matches);
    if num > 0
        i=i+1;
        data=tline(50:60);
        lon_oceantemp=str2num(data);
        data=tline(60:70);
        lat_oceantemp=str2num(data);
        lon_ocean=cat(1,lon_ocean,lon_oceantemp);
        lat_ocean=cat(1,lat_ocean,lat_oceantemp);
        data=[];
        for j=1:6
            data0 = fgetl(fid);
            data1 = str2num(data0(1:length(data0)));
            data=cat(1,data,data1);
        end;
        fid0=fopen(strcat('oceanloading',num2str(i)),'w');
        olap=data([1 4],[1 2 5 6 3 7 4 8 9 10 11]);
        fprintf(fid0,'%g %g %g %g %g %g %g %g %g %g %g\n',olap');
        fclose(fid0);
    end;
end
nptocean=i;
fclose(fid);
valocean='on';
interface;