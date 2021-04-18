function tidalgravityeffect=oceanloading(xtime,stationlongitude,oceanloadamplitude,oceanloadphase)
% xtime is in hours from Jan 1, 1900, stationlongitude is longitude
%
%     purpose:  To assess the ocean loading/gravity effect due to the
%               separate tidal primary components derived from the Agnew
%               program ( LOADF ).
%
%%
%     definition of input/output variables
%
%     oceanloadamplitude           - Array(11) of the oceanload amplitudes in Gals.  The order of
%               the gravityeffectonents is (M2,S2,K1,O1,N2,P1,K2,Q1).  The next three
%               gravityeffectonents (Mf,Mm,Ssa) are ignored.
%     oceanloadphase           - Array(11) of phases of the oceanloading gravityeffectonents.
%     stationlongitude          - east longitude
%     oceanloading  - oceanloading correction in uGal
%
%%
dtor=pi/180;
%
%     START TIME  (ET)        EPOCH = J2000.0     (JED-2451545.0)/36525
%
TL=64.184;       % time shift ET-UT = 41.184+yr-1970 seconds
ets=(xtime/24+0.5+TL/86400)/36525-1;
%%
%               Calculate the mean longitudes of the sun (h0),
%               moon (s0) and lunar perigee (p0).
%               And local siderial time (tl).
%               All quantities in radians.
%
p0 = lunarperigee(ets);
h0 = sunlongitude(ets);
s0 = moonlongitude(ets);
AM = 18.69735+2400.05130*(ets-TL/3.15576e9);
P = 0.00029*cos((1934*ets+145)*dtor);
gast = pi+(xtime+AM+P)*pi/12 + stationlongitude*dtor;
tidalgravityeffect = gravityeffect(h0,s0,p0,gast,oceanloadamplitude,oceanloadphase);