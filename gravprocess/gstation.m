%% Mean and standard deviation for each station
for i=1:length(gravilines)
    data=evalin('base', strcat('line_',num2str(gravilines(i)),'_tidal_pressure_drift'));
    dataini=evalin('base', strcat('line_',num2str(gravilines(i))));
    station=data{2};
    gmes=data{4};
    gmesstd=data{5};
    ginistd=data{17};
    gmesini=dataini{4};
    driftstd=data{18};
    liststation=[];
    for j=1:length(data{1})
        if (ismember(station(j),liststation)==0)
            liststation=horzcat(liststation,station(j));
        end;
    end;
    gmean=zeros(size(liststation));
    gstd=zeros(size(liststation));
    gistd=zeros(size(liststation));
    dstd=zeros(size(liststation));
    lon=zeros(size(liststation));
    lat=zeros(size(liststation));
    alt=zeros(size(liststation));
    dalt=zeros(size(liststation));
    for j=1:length(liststation)
        indice=find(station==liststation(j));
        gmean(j)=mean(gmes(indice));
        gstd(j)=sqrt(-gmean(j)^2+sum(gmes(indice).^2+gmesstd(indice).^2)/length(indice));
        gimean(j)=mean(gmesini(indice));
        gistd(j)=sqrt(-gimean(j)^2+sum(gmesini(indice).^2+ginistd(indice).^2)/length(indice));
        dstd(j)=mean(driftstd(indice));
        indice=find(coord(:,5)==liststation(j));
        lon(j)=coord(indice,1);
        lat(j)=coord(indice,2);
        alt(j)=coord(indice,3);
        dalt(j)=coord(indice,4);
    end;
    data1=[liststation;gmean;gstd;lon;lat;alt;dalt;gistd;dstd];
    assignin('base',strcat('line_',num2str(gravilines(i)),'_tidal_pressure_drift_mean'),data1);
end;
clear data data1 dataini;
