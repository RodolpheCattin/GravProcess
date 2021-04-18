%% use or not parallel computing
valuehpop4 = get(hpop4,'Value');
if (valuehpop4==1)
    paralleltest=1;
end;
if (valuehpop4==2)
    paralleltest=0;
end;
valpara='on';
interface;