%% instrumental drift
timedrift=[];
valdrift=[];
for i=1:length(gravilines) 
    data=evalin('base', strcat('line_',num2str(gravilines(i)),'_tidal_pressure'));
    station=data{2};
    gmes=data{4};
    gmesstd=data{5};
    timed=data{16};
    deltatmax=0;
    for j=1:length(data{1})
        indice=find(station==station(j));
        deltat=max(timed(indice))-min(timed(indice));
        if (deltat>deltatmax)
            deltatmax=deltat;
            stationderive=station(j);
        end;
    end;
    indice=find(station==stationderive);
    [coeff,S]=wpolyfit(timed(indice),gmes(indice),valdegree,1./gmesstd(indice));
    Rinv=inv(S.R);
    coeffcovar=(Rinv*Rinv')*S.normr^2/S.df;
    derive=zeros(size(timed));
    deriveerreur=zeros(size(timed));
    for k=1:valdegree+1
        derive=derive+coeff(k)*timed.^(valdegree+1-k);
        deriveerreur=deriveerreur+coeffcovar(k,k).*timed.^(2*(valdegree+1-k));
        for l=1:k-1
            deriveerreur=deriveerreur+2*coeffcovar(l,k).*(timed.^(valdegree+1-l)).*...
                (timed.^(valdegree+1-k));
        end;
    end;
    data{4}=gmes-derive;
    data{5}=gmesstd+sqrt(deriveerreur);
    data{17}=gmesstd;
    data{18}=sqrt(deriveerreur);
%    plotdrift (correct for valdegree=1 only);
    assignin('base',strcat('line_',num2str(gravilines(i)),'_tidal_pressure_drift'),data);
    timedrift=cat(1,timedrift,mean(timed));
    valdrift=cat(1,valdrift,coeff(1));
end;
clear data;