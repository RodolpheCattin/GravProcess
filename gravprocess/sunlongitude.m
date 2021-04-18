function sunlon =sunlongitude(time)
%
%     LONGITUDE OF THE SUN IN RADIANS ( NUTATION IS TAKEN INTO ACCOUNT )
%       GRAVITY IS FREE FROM ABERRATION  (-0.0057 DEG.)
%
%       TIME : (JED-2451545.0)/36525     EPOCH = J2000.0
%
format long;
B0=36000.7695;
C0=280.4659;
A=[19147e-4, 200e-4, 48e-4, 20e-4, 18e-4, 18e-4,...
    15e-4,  13e-4,  7e-4,  7e-4,  7e-4,  6e-4,...
    5e-4,   5e-4,  4e-4,  4e-4];
B=[35999.050, 71998.1,  1934, 32964,    19,...
    445267   , 45038 , 22519, 65929,  3035,...
    9038   , 33718 ,   155,  2281, 29930,...
    31557   ];
C=[267.520, 265.1, 145, 158, 159, 208,...
    254.   , 352 ,  45, 110,  64, 316,...
    118.   , 221 ,  48, 161];
RAD=0.0174532925199433;
%%
A(1) = 1.9147-0.0048*time;
tempb=(B*time+C)*RAD;
amp=A.*cos(tempb);
sunlon=sum(amp);
sunlon=(sunlon+B0*time+C0)*RAD;