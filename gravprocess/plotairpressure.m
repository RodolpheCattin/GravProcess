%% Air pressure
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
figure('Name','Air pressure','NumberTitle','off');
subplot(2,1,1)
scatter(pressureplot(:,1),pressureplot(:,2),50,pressureplot(:,4),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Air pressure (hPa)');
subplot(2,1,2)
scatter(pressureplot(:,1),pressureplot(:,2),50,pressureplot(:,3),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Air pressure effect (mGal)');
