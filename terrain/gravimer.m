% Topography
zsmer=point(:,3);
mer=1;
%% to fill sea area
indice=find(zsmer>-1e-5);
zsmer(indice)=-1e-5;
%% Bottom
Corner=[xs ys zsmer];
Face=[3*ones(size(tri0,1),1) tri0];
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner,Face,dens-1);
gravixmer=-real(Gx);
graviymer=-real(Gy);
gravizmer=-real(Gz);
%% Top
Corner=[xs ys zeros(size(zsmer))];
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner,Face,dens-1);
gravixmer=gravixmer+real(Gx);
graviymer=graviymer+real(Gy);
gravizmer=gravizmer+real(Gz);
%% Vertical
zvmer=zv;
indice=find(zvmer>-1e-5);
zvmer(indice)=-1e-5;
Corner1=cat(1,[xv yv 0*zvmer],[xv yv zvmer]);
tri1 = zeros(2*length(xv)-2,3);
for k=1:length(xv)-1
    tri1(2*k-1,1)=k;
    tri1(2*k-1,2)=k+1;
    tri1(2*k-1,3)=k+length(xv);
    tri1(2*k,1)=k+1;
    tri1(2*k,2)=k+length(xv)+1;
    tri1(2*k,3)=k+length(xv);
end
Face1=[3*ones(size(tri1,1),1) tri1];
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner1,Face1,dens-1);
gravixmer=gravixmer+real(Gx);
graviymer=graviymer+real(Gy);
gravizmer=gravizmer+real(Gz);
%%
clear Corner Face Gx Gy Gz zsmer;