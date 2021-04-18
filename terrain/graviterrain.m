function graviterrainz =graviterrain(lon,lat,z,londata,latdata,zdata,resolutionini,extentini,coeffaugmente)
%% Calculate gravity terrain effect
% With all distances in meters, model density in gm/cm3.
% It gives gravity fields in milligals with x positive eastward, y positive northward and z positive upward
%% global variable
global lon0 lat0 resolution coeffa;
%%
format long;
%% parameters
% density of model, gm/cm3
dens=2.67;
% project on WGS84
semimajor_axis=6378137.0;
eccentricity=0.081819190842621;
% Lowest resolution (km) and extent (km)  of elevation data
resolution=resolutionini/110; % km to degre
optimparam;
coeffa=coeffaugmente;
%% calculation for each gravity measurement
graviterrainx=zeros(size(londata'));
graviterrainy=graviterrainx;
graviterrainz=graviterrainx;
for i=1:numel(londata)
    lon0=londata(i);
    lat0=latdata(i);
    z0=zdata(i);
    [dist, ~]=distance(lat0,lon0,lat,lon,[semimajor_axis,eccentricity]);
    indice = find(dist < extentini*1e3);
    lons=lon(indice);
    lats=lat(indice);
    zs=z(indice);
    clear indice;
    nint = max([round(2*pi/(coeffa+resolutionini/extentini)),10]);
    [y, x]= scircle(lat0, lon0, extentini*1e3, [], [semimajor_axis, eccentricity],[],nint); % small circle definition
    x(end)=x(1);
    y(end)=y(1);
    node=flipud((cat(2,x,y)));
    %% sample elevation data
    [point,tri0] = mesh2d(node,[],hdata,options);
    for j=1:length(point)
        [~,indice]=min((point(j,1)-lons).^2+(point(j,2)-lats).^2);
        point(j,3)=zs(indice);
    end
%    plotgeometry;
    %% degre to meter
    [dist,az] = distance(lat0,lon0,point(:,2),point(:,1),[semimajor_axis,eccentricity]);
    xs=dist.*sind(az);
    ys=dist.*cosd(az);
    clear dist az;
    [dist,az] = distance(lat0,lon0,node(:,2),node(:,1),[semimajor_axis,eccentricity]);
    xv=dist.*sind(az);
    yv=dist.*cosd(az);
    zv=zeros(size(xv));
    for k=1:length(xv)
        [~,indice]=min((xv(k)-xs).^2+(yv(k)-ys).^2);
        zv(k)=zs(indice);
    end
    clear dist az;
    %% calculation of gravity field
    graviterre;
    gravimer;
    graviterrainx(i)=-(gravixterre+gravixmer);
    graviterrainy(i)=-(graviyterre+graviymer);
    graviterrainz(i)=-(gravizterre+gravizmer);
end
