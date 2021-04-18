function moonlon =moonlongitude(time)
%
%     APPARENT LONGITUDE OF THE MOON IN RADIANS
%
%       TIME : (JEe-2451545.0)/36525          EPOCH = J2000.0
%
format long;
B0=481267.8809;
C0=218.3162;
A=[62888.e-4, 12740.e-4, 6583.e-4, 2136.e-4, 1851.e-4,...
    1144.e-4, 588.e-4, 571.e-4, 533.e-4, 458.e-4, 409.e-4,...
    347.e-4, 304.e-4, 154.e-4, 125.e-4, 110.e-4, 107.e-4,...
    100.e-4, 85.e-4, 79.e-4, 68.e-4, 52.e-4, 50.e-4, 40.e-4,...
    40.e-4, 40.e-4, 38.e-4, 37.e-4, 28.e-4, 27.e-4, 26.e-4,...
    24.e-4, 23.e-4, 22.e-4, 21.e-4, 21.e-4, 21.e-4, 18.e-4,...
    16.e-4, 12.e-4, 11.e-4,  9.e-4,  8.e-4,  7.e-4,  7.e-4,...
    7.e-4,  7.e-4,  6.e-4,  6.e-4,  5.e-4,  5.e-4,  5.e-4,...
    4.e-4,  4.e-4,  3.e-4,  3.e-4,  3.e-4,  3.e-4,  3.e-4,...
    3.e-4,  3.e-4];
B=[477198.868,  413335.35, 890534.22, 954397.74,...
    35999.05 ,  966404.0 ,  63863.5 , 377336.3 ,...
    1367733.1  ,  854535.2 , 441199.8 , 445267.1 ,...
    513197.9, 75870,1443603, 489205,1303870,...
    1431597, 826671, 449334, 926533,  31932,...
    481266,1331734,1844932,    133,1781068,...
    541062,   1934, 918399,1379739,  99863,...
    922466, 818536, 990397,  71998, 341337,...
    401329,1856938,1267871,1920802, 858602,...
    1403732, 790672, 405201, 485333,  27864,...
    111869,2258267,1908795,1745069, 509131,...
    39871,  12006, 958465, 381404, 349472,...
    1808933, 549197,   4067,2322131.];
C=[44.963, 10.74, 145.70, 179.93, 87.53,  276.5,...
    124.2, 13.2, 280.7, 148.2, 47.4, 27.9, 222.5,...
    41,  52, 142, 246, 315, 111, 188,...
    323, 107, 205, 283,  56,  29,  21,...
    259, 145, 182,  17, 122, 163, 151,...
    357,  85,  16, 274, 152, 249, 186,...
    129,  98, 114,  50, 186, 127,  38,...
    156,  90,  24, 242, 223, 187, 340,...
    354, 337,  58, 220,  70, 191];
RAD=0.0174532925199433;
tempb=(B*time+C)*RAD;
amp=A.*cos(tempb);
moonlon=sum(amp);
moonlon=(moonlon+B0*time+C0)*RAD;