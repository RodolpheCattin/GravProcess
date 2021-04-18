function h = hfuntest(x,y)
% User defined size function for square
h = 0.02 + 0.02*sqrt( (x-0.75).^2+(y-0.05).^2 )+0.01*sqrt( (x-0.15).^2+(y-0.75).^2 );
end