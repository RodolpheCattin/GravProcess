%% tidal correction
if (tidaltest==1)
    display('Earth and ocean tide corrections');
else
    display('Earth tide correction');
end;
tidalcorrection;
%% pressure correction
if (pressuretest==1)
    display('Air pressure correction');
end;
pressurecorrection;
%% instrumental drift
display('Instrumental drift');
instrumentdrift;
%% mean value and standard deviation
gstation;
%% relative attachment
display('Attachment');
gattach;
%% absolute attachment
gattachabs;
%% latitude correction
display('Latitude correction');
latcor;
%% free air correction
display('Free air correction');
facor;
%% terrain correction
if (completeb==1)
    display('Terrain correction (It takes between 10 and 30 seconds per station !)');
    londem=cat(2,londem',dataattachabs(4,:));
    latdem=cat(2,latdem',dataattachabs(5,:));
    zdem=cat(2,zdem',dataattachabs(6,:));
    if (paralleltest==1)
        terrain=zeros(size(dataattachabs,2),1);
        parfor i=1:size(dataattachabs,2)
            terrain(i)=graviterrain(londem,latdem,zdem,dataattachabs(4,i),dataattachabs(5,i),dataattachabs(6,i),resolution,distancemax,coeffaugmente);
        end
    end
    if (paralleltest==0)
        terrain=zeros(size(dataattachabs,2),1);
        for i=1:size(dataattachabs,2)
            terrain(i)=graviterrain(londem,latdem,zdem,dataattachabs(4,i),dataattachabs(5,i),dataattachabs(6,i),resolution,distancemax,coeffaugmente);
        end
    end
else
    display('Plateau correction');
    dens=(1-2.67)*ones(size(dataattachabs,2),1);
    indice=find(dataattachabs(6,:)>0);
    dens(indice)=2.67;
    Gc= 6.6732e-3;
    terrain=zeros(size(dataattachabs,2),1);
    terrain=-2*pi*Gc*dens.*(dataattachabs(6,:))';
end;
terrain=-terrain';
dterrain=0;
erreurg=sqrt(dataattachabs(8,:).^2+dataattachabs(9,:).^2+gattachstd.^2*ones(1,size(dataattachabs,2))+...
    std(dgattachabs2).^2*ones(1,size(dataattachabs,2)));
erreurfreeair=sqrt(erreurg.^2+(0.3086*dataattachabs(7,:)).^2);
erreurbouguer=sqrt(erreurfreeair.^2+(0.065*DEMerror*ones(1,size(dataattachabs,2))).^2);
valrun='on';
interface;
