%% load or not DEM
valuehpop1 = get(hpop1,'Value');
if (valuehpop1==1)
    completeb=1;
    valcomplete='on';
    valDEM='off';
end;
if (valuehpop1==2)
    completeb=0;
    valDEM='off';
    valcomplete='off';
    valmesh='on';
end;
interface;