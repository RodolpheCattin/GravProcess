Atempo(1,:)=xs(indicea);
Atempo(2,:)=ys(indicea);
if (mer==0)
    Atempo(3,:)=zsterre(indicea);
else
    Atempo(3,:)=zsmer(indicea);
end;
Atempo2=sortrows(Atempo',2);
xw=Atempo2(:,1);
yw=Atempo2(:,2);
zw=Atempo2(:,3);
xw=cat(1,xw,flipud(xw));
yw=cat(1,yw,flipud(yw));
zw=cat(1,zw,zeros(size(zw)));
profile=[yw zw];
edgescontraints=[(1:numel(yw)-1)' (2:numel(yw))'; numel(yw) 1;];
tri=DelaunayTri(profile,edgescontraints);
inside = inOutStatus(tri);
T=tri(inside,:);
Corner=[xw yw zw];
Face=[size(T,2)*ones(size(T,1),1) T];
clear xw yw zw T edgescontraints profile Atempo Atempo2;