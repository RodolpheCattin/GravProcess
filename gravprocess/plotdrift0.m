%% figure instrumental drift
figure('Name',strcat('Instrument drift - Line No',num2str(gravilines(i))),'NumberTitle','off');
errorbar(timed(indice),gmes(indice),gmesstd(indice),'o');
hold on;
plot(timed,coeff(1)*timed+coeff(2),'-r');
legend('Measurements','Calculated drift');
xlabel('Time (day)');
ylabel('gmes (mGal)');