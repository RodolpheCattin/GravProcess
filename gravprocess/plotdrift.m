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
    [coeff,S]=wpolyfit(timed(indice),gmes(indice),1,1./gmesstd(indice));
    Rinv=inv(S.R);
    coeffcovar=(Rinv*Rinv')*S.normr^2/S.df;
    data{4}=gmes-(coeff(1)*timed+coeff(2));
    data{5}=gmesstd+sqrt((timed.^2).*coeffcovar(1,1)+coeffcovar(2,2)+...
        2.*timed.*coeffcovar(1,2));
    plotdrift0;
    assignin('base',strcat('line_',num2str(gravilines(i)),'_tidal_pressure_drift'),data);
    timedrift=cat(1,timedrift,mean(timed));
    valdrift=cat(1,valdrift,coeff(1));
end;
clear data;
%% drift with time
figure('Name','Instrumental drift with time','NumberTitle','off');
plot(timedrift,valdrift,'ko');
xlabel('Time (day)');
ylabel('Instrumental drift (mGal/day)');
