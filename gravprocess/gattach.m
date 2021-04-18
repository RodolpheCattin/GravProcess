%% find common station(s) and attach gravity lines
gattachstd=0;
for i=1:size(attachlist,1)
    data1=evalin('base',strcat('line_',num2str(attachlist(i,1)),'_tidal_pressure_drift_mean'));
    data2=evalin('base',strcat('line_',num2str(attachlist(i,2)),'_tidal_pressure_drift_mean'));
    % common station(s)
    lialon=ismember(data1(4,:),data2(4,:));
    lialat=ismember(data1(5,:),data2(5,:));
    indice1=find(lialon.*lialat==1);
    lialon=ismember(data2(4,:),data1(4,:));
    lialat=ismember(data2(5,:),data1(5,:));
    indice2=find(lialon.*lialat==1);
    % attachment
    dgattach=mean(data2(2,indice2)-data1(2,indice1));
    gattachstd=gattachstd+mean(data2(3,indice2)+data1(3,indice1));
    data1modif=data1;
    data1modif(2,:)=data1(2,:)+dgattach;
    data1modif(:,indice1)=[];
    data=cat(2,data2,data1modif);
    assignin('base',strcat('line_',num2str(attachlist(i,3)),'_tidal_pressure_drift_mean'),data);
end;
gattachstd=gattachstd/size(attachlist,1);
dataattach=line_0_tidal_pressure_drift_mean;
dataattach(3,:)=dataattach(3,:)+gattachstd;
clear data data1 data1modif data2;
