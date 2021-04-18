%% Free air anomaly
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
figure('Name','Free air anomaly','NumberTitle','off');
subplot(2,1,1)
scatter(dataattachabs(4,:),dataattachabs(5,:),50,dataattachabs(2,:)-(gth-fa),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Free air anomaly (mGal)');
% standard deviation
subplot(2,1,2)
scatter(dataattachabs(4,:),dataattachabs(5,:),50,erreurfreeair,'filled');
axis([xmin xmax ymin ymax]);
colorbar;
caxis([0 2*mean(dataattachabs(3,:)+dfa)]);
xlabel('Longitude');
ylabel('Latitude');
title('Standard deviation (mGal)');