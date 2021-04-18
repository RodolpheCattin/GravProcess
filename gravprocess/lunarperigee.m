function perigee =lunarperigee(time)
%
%     LONGITUDE OF LUNAR PERIGEE IN RADIANS
%
%        TIME:  (JED-2451545.0)/36525             EPOCH = J2000.0
%           ets is the Julian centuries since Jan 1.5 2000.
%           t1 is the Julian centuries since Jan 0.5 1900.
%
format long;
dtor=pi/180;
t1=1+time;
t2=t1*t1;
t3=t2*t1;
perigee= 334.329653*dtor + 4069.0340329575*dtor*t1 -...
    0.010325*dtor*t2 - 1.2e-5*dtor*t3;