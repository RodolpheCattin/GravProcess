%% plot results from gravity data processing
valuehpop5 = get(hpop5,'Value');
if (valuehpop5==1)
    plotdrift;
end;
if (valuehpop5==2)
    plotattach;
end;
if (valuehpop5==3)
    plotairpressure;
end;
if (valuehpop5==4)
    plotearthoceantide;
end;
if (valuehpop5==5)
    plotgravity;
end;
if (valuehpop5==6)
    plotfreeair;
end;
if (valuehpop5==7)
    plotbouguer;
end;
if (valuehpop5==8)
    plotuncertainties;
end;
if (valuehpop5==9)
    indice=findall(0,'type','figure');
    if (length(indice)>1)
        close(indice(2:length(indice)))
    end;
end;