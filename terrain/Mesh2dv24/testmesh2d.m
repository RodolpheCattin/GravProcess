clear all;
close all;
node = [0 0;1 0;1 1;0 1];
hdata.fun = @hfuntest;
[p,t] = mesh2d(node,[],hdata);