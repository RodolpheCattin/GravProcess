%% load or not tide file
valuehpop2 = get(hpop2,'Value');
if (valuehpop2==1)
    tidaltest=1;
    valtidal='on';
end;
if (valuehpop2==2)
    tidaltest=0;
    valocean='on';
    valtidal='off';
end;
interface;