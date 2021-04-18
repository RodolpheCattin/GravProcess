%% load or not pressure file
valuehpop3 = get(hpop3,'Value');
if (valuehpop3==1)
    pressuretest=1;
    valpressure='on';
end;
if (valuehpop3==2)
    pressuretest=0;
    valair='on';
    valpressure='off';
end;
interface;