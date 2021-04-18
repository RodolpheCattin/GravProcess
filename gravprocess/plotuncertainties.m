%% Uncertainties
xmin=min(dataattachabs(4,:));
xmax=max(dataattachabs(4,:));
ymin=min(dataattachabs(5,:));
ymax=max(dataattachabs(5,:));
%%
figure('Name','Uncertainties','NumberTitle','off');
D=cat(2,dataattachabs(8,:),dataattachabs(9,:),gattachstd,std(dgattachabs2),...
    0.3086*dataattachabs(7,:),0.065*DEMerror);
indice=find(D<1e-3);
D(indice)=1e-3;
% Rescale data 1-64
d = log10(D);
mn = min(d(:));
rng = max(d(:))-mn;
d = 1+63*(d-mn)/rng; % Self scale data
L = [0.001 0.01 0.1 1 10];
% Choose appropriate
% or somehow auto generate colorbar labels
l = 1+63*(log10(L)-mn)/rng; % Tick mark positions
cmin=min(d);
cmax=max(d);
%% raw data
subplot(3,2,1)
d=log10(dataattachabs(8,:));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC = colorbar;
ylabel('Latitude');
title('Raw data (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);
%% drift
subplot(3,2,2)
d=log10(dataattachabs(9,:));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC = colorbar;
title('Intrumental drift (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);
%% adjustment 1
subplot(3,2,3)
d=log10(gattachstd*ones(1,length(dataattachabs)));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC=colorbar;
ylabel('Latitude');
title('Network adjustment (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);
%% adjustment 2
subplot(3,2,4)
d=log10(std(dgattachabs2)*ones(1,length(dataattachabs)));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC=colorbar;
title('Absolute adjustment (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);
%% free air
subplot(3,2,5)
d=log10(0.3086*dataattachabs(7,:));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC=colorbar;
xlabel('Longitude');
ylabel('Latitude');
title('Station altitude (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);
%% DEM
subplot(3,2,6)
d=log10(0.065*DEMerror*ones(1,length(dataattachabs)));
scatter(dataattachabs(4,:),dataattachabs(5,:),50,1+63*(d-mn)/rng,'filled');
axis([xmin xmax ymin ymax]);
caxis([cmin cmax]);
hC=colorbar;
xlabel('Longitude');
title('DEM uncertainty (mGal)');
set(hC,'Ytick',l,'YTicklabel',L);