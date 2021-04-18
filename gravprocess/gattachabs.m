%% attachment of gravity data to absolute gravity measurement
% dgattachabs1=zeros(1,size(gravbase,1));
j=0;
for i=1:size(gravbase,1)
    [val,indice]=min(sqrt((dataattach(4,:)-gravbase(i,1)).^2+(dataattach(5,:)-gravbase(i,2)).^2));
    if (val<0.01)
        j=j+1;
        dgattachabs1(j)=mean(gravbase(i,3)-dataattach(2,indice));
    end;
end;
dataattachabs=dataattach;
dataattachabs(2,:)=dataattach(2,:)+mean(dgattachabs1);
dgattachabs2=zeros(1,size(gravbase,1));
j=0;
for i=1:size(gravbase,1)
    [val,indice]=min(sqrt((dataattach(4,:)-gravbase(i,1)).^2+(dataattach(5,:)-gravbase(i,2)).^2));
    if (val<0.01)
        j=j+1;
        dgattachabs2(j)=mean(gravbase(i,3)-dataattachabs(2,indice));
    end;
end;
dataattachabs(3,:)=dataattach(3,:)+std(dgattachabs2)+0.3086*dataattach(7,:)+0.065*DEMerror;
%% assessment of difference between shifted dataset and absolute gravity measurement
j=0;
for i=1:size(gravbase,1)
    [val,indice]=min(sqrt((dataattachabs(4,:)-gravbase(i,1)).^2+(dataattachabs(5,:)-gravbase(i,2)).^2));
    if (val<0.01)
        j=j+1;
        dgattachabs3(i)=mean(abs(gravbase(i,3)-dataattachabs(2,indice)));
    end;
end;
display(['Mean difference between shifted dataset and absolute gravity measurements:',num2str(mean(dgattachabs3)),' mGal']);