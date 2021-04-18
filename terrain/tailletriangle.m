function h = tailletriangle(X1,X2)
global lon0 lat0 resolution coeffa;

R=sqrt( (X1-lon0).^2+(X2-lat0).^2 );
h = resolution + coeffa*R;
end

