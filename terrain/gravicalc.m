function[Gx,Gy,Gz]=gravicalc2(X,Y,Z,Corner,Face,dens)
%% global variable
global step steps h tstart;
%% Universal Gravitational constant.
Gc= 6.6732e-3; 
%%
Ncor=size(Corner,1);
Nf=size(Face,1);
    save('test.mat');
%% Get edgelengths
Nedges=sum(Face(1:Nf,1));
Edge=zeros(Nedges,8);
for f=1:Nf
    indx=[Face(f,2:Face(f,1)+1) Face(f,2)];
    for t=1:Face(f,1)
        edgeno=sum(Face(1:f-1,1))+t;
        ends=indx(t:t+1);
        p1=Corner(ends(1),:);
        p2=Corner(ends(2),:);
        V=p2-p1;
        L=norm(V);
        Edge(edgeno,1:3)=V;
        Edge(edgeno,4)=L;
        Edge(edgeno,7:8)=ends;
    end;
end;
Un=zeros(Nf,3);
for t=1:Nf
    ss=zeros(1,3);
    for t1=2:Face(t,1)-1;
        v1=Corner(Face(t,t1+2),:)-Corner(Face(t,2),:);
        v2=Corner(Face(t,t1+1),:)-Corner(Face(t,2),:);
        ss=ss+cross(v2,v1);
    end;
    if norm(ss)==0
        Un(t,:)=ss;
    else
        Un(t,:)=ss./norm(ss);
    end;
end;
%% Calculation
steps=4*6*size(X,1)*(size(X,1)+1);
[npro nstn]=size(X);
Gx=zeros(size(X));
Gy=Gx;
Gz=Gx;
cor=zeros(Ncor,3);
crs=zeros(3,3);

for pr=1:npro
    for st=1:nstn
        opt=[X(pr,st) Y(pr,st) Z(pr,st)];
        fsign=zeros(1,Nf); Omega=zeros(1,Nf);
        % shift origin
        for t=1:Ncor
            cor(t,:) = Corner(t,:)-opt;
        end;
        for f=1:Nf
            nsides=Face(f,1);
            cors=Face(f,2:nsides+1);
            Edge(:,5:6)=zeros(Nedges,2);% Clear record of integration
            indx=[1:nsides 1 2];
            for t=1:nsides
                crs(t,:)=cor(cors(t),:);
            end;
            % Find if the face is seen from inside
            fsign(f)=sign(dot(Un(f,:),crs(1,:)));
            % Find solid anglegravi W subtended by face f at opt
            dp1=dot(crs(indx(1),:),Un(f,:));
            dp=abs(dp1);
            if dp==0
                Omega(f)=0;
            end;
            if dp~=0
                W=0;
                for t=1:nsides
                    p1=crs(indx(t),:);
                    p2=crs(indx(t+1),:);
                    p3=crs(indx(t+2),:);
                    W=W + anglegravi(p1,p2,p3,Un(f,:));
                end;
                W=W-(nsides-2).*pi;
                Omega(f)= -fsign(f)*W;
            end;
            indx=[1:nsides 1 2];
            for t=1:nsides
                crs(t,:)=cor(cors(t),:);
            end;
            % Integrate over each side, if not done, and save result
            PQR=[0 0 0];
            for t=1:nsides
                p1=crs(indx(t),:);
                p2=crs(indx(t+1),:);
                Eno=sum(Face(1:f-1,1))+t; % Edge number
                if Edge(Eno,6)==1
                    I=Edge(Eno,5);
                    V=Edge(Eno,1:3);
                    pqr=I.* V;
                    PQR=PQR+pqr;
                end;
                if Edge(Eno,6)~=1
                    chsgn=1; % if origin,p1 & p2 are on a st line
                    if dot(p1,p2)/(norm(p1)*norm(p2))==1
                        if norm(p1)>norm(p2) % and p1 farther than p2
                            chsgn=-1;
                            psave=p1;
                            p1=p2;
                            p2=psave; % interchange p1,p2
                        end;
                    end;
                    V=Edge(Eno,1:3);
                    L=Edge(Eno,4);
                    L2=L*L;
                    b=2*(dot(V,p1));
                    r1=norm(p1);
                    r12=r1*r1;
                    b2=b/L/2;
                    if r1+b2 == 0
                        V=-Edge(Eno,1:3);
                        b=2*(dot(V,p1));
                        b2=b/L/2;
                    end;
                    if r1+b2 ~= 0
                        I=(1/L).*log ((sqrt(L2 + b + r12)+L+b2)./(r1 + b2));
                    end;
                    s=find(Edge(:,7)==Edge(Eno,8)& Edge(:,8)==Edge(Eno,7));
                    I=I*chsgn; % change sign of I if p1,p2 were interchanged
                    Edge(Eno,5)=I;
                    Edge(s,5)=I;
                    Edge(Eno,6)=1;
                    Edge(s,6)=1;
                    pqr=I.* V;
                    PQR=PQR+pqr;
                end;
            end;
            % From Omega,l,m,n,PQR, get components of field due to face f
            l=Un(f,1);
            m=Un(f,2);
            n=Un(f,3);
            p=PQR(1,1);
            q=PQR(1,2);
            r=PQR(1,3);
            if dp~=0 % if distance to face is non-zero
                gx = -dens*Gc*dp1*(l*Omega(f)+n*q-m* r);
                Gx(pr,st)=Gx(pr,st)+ gx;
                gy = -dens*Gc*dp1*(m*Omega(f)+l*r-n* p);
                Gy(pr,st)=Gy(pr,st)+ gy;
                gz = -dens*Gc*dp1*(n*Omega(f)+m*p-l* q);
                Gz(pr,st)=Gz(pr,st)+ gz;
            end;
        end;
    end;
end;
return;