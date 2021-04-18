%% Bouguer anomaly
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
cmin=min(dataattachabs(2,:)-(gth-fa+terrain));
cmax=max(dataattachabs(2,:)-(gth-fa+terrain));
figure('Name','Bouguer anomaly','NumberTitle','off');
subplot(2,1,1)
scatter(dataattachabs(4,:),dataattachabs(5,:),50,dataattachabs(2,:)-(gth-fa+terrain),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Bouguer anomaly (mGal)');
% standard deviation
subplot(2,1,2)
scatter(dataattachabs(4,:),dataattachabs(5,:),50,erreurbouguer,'filled');
axis([xmin xmax ymin ymax]);
colorbar;
caxis([0 2*mean(dataattachabs(3,:)+dfa+dterrain)]);
xlabel('Longitude');
ylabel('Latitude');
title('Standard deviation (mGal)');
