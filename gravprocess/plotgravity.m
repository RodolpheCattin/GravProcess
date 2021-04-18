%% gravity
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
figure('Name','Gravity field','NumberTitle','off');
subplot(2,1,1)
scatter(gravbase(:,1),gravbase(:,2),80,gravbase(:,3));
hold on;
scatter(dataattachabs(4,:),dataattachabs(5,:),50,dataattachabs(2,:),'filled');
axis([xmin xmax ymin ymax]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Gravity field (mGal)');
% standard deviation
subplot(2,1,2)
scatter(dataattachabs(4,:),dataattachabs(5,:),50,erreurg,'filled');
axis([xmin xmax ymin ymax]);
caxis([0 2*mean(dataattachabs(3,:))]);
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Standard deviation (mGal)');