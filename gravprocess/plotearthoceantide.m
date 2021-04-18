%% Plot the effect of both ocean and solid earth tides 
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
figure('Name','Tide','NumberTitle','off');
subplot(2,1,1)
scatter(tideplot(:,1),tideplot(:,2),50,tideplot(:,3),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Solid earth tide correction (mGal)');
subplot(2,1,2)
scatter(tideplot(:,1),tideplot(:,2),50,tideplot(:,4),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Ocean tide correction (mGal)');
