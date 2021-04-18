function valtide=ocean_tide(lonstation,latstation,time,lonocean,latocean)
%% find the closest point of ocean loading
    lonstation(lonstation<0)=lonstation+360;
    [C,I] = min((lonstation-lonocean).^2+(latstation-latocean).^2);
%% calculate gravity effect of ocean loading
    data=load(strcat('oceanloading',num2str(I)));
    xtime=24*(datenum(time)-datenum(1900,1,1));
    valtide=oceanloading(xtime,lonocean(I),data(1,:),data(2,:));