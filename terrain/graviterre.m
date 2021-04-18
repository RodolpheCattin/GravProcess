% Topography
zsterre=point(:,3);
mer=0;
%% to fill sea area
indice=find(zsterre<1e-5);
zsterre(indice)=1e-5;
%% Top
Corner=[xs ys zsterre];
Face=[3*ones(size(tri0,1),1) tri0];
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner,Face,dens);
gravixterre=-real(Gx);
graviyterre=-real(Gy);
gravizterre=-real(Gz);
%% Bottom
Corner=[xs ys zeros(size(zsterre))];
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner,Face,dens);
gravixterre=gravixterre+real(Gx);
graviyterre=graviyterre+real(Gy);
gravizterre=gravizterre+real(Gz);
%% Vertical
zvterre=zv;
indice=find(zvterre<1e-5);
zvterre(indice)=1e-5;
Corner1=cat(1,[xv yv zvterre],[xv yv 0*zvterre]);
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
[Gx,Gy,Gz]=gravicalc(0,0,z0,Corner1,Face1,dens);
gravixterre=gravixterre+real(Gx);
graviyterre=graviyterre+real(Gy);
gravizterre=gravizterre+real(Gz);
%%
clear Corner Face Gx Gy Gz zsterre;