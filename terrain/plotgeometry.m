figure;
scatter(lons,lats,50,zs,'filled');
hold on;
trisurf(tri0,point(:,1),point(:,2),zeros(length(point),1),'FaceAlpha',0);
hold on;
plot(lon0,lat0,'wo');
xlabel('longitude');
ylabel('latitude');
title(strcat('station #',num2str(i)));
hcbar = colorbar;
ylabel(hcbar,'Elevation (m)');

figure;
trisurf(tri0,point(:,1),point(:,2),point(:,3));
