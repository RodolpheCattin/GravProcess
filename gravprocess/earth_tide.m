% [TIDE] = earth_tide(LAT,LON,gtime)
% input
% LAT,LON - North Latitude and East Longitude, degrees
% a single droptime in the BINARY datestr matlab format
% output:
% computes the tidal correction in microgals.
% it should be added to your measurements. 
%
%
% GDC returns the constant tide (Honkasalo term) as well.  The
% constant tide is included in TIDE. 
% In order to correct surface gravity records for tides, ADD this 
% tide output to gravity records

%	BOMM subroutine written by Jon Berger  November 1969
%	astronomy revised by Judah Levine (after J C Harrison) Sept 1973
%	updated by Karen Young  March 1977, for PDP 11
%	amended by Duncan Agnew June 1978 to speed execution
%	solar astronomy redone and rigid-earth potential added by Duncan
%	Agnew June 1979
%	tide generating part put in separate subroutine and computation
%	of Munk-Cartwright coefficients added by Duncan Agnew Feb 1981,
%	uly 1982
%
%	This version rewritten for export, using F77 calls for I/O,
%	by Duncan Agnew Mar 1987
%
%	This version stripped down to theoretical gravity tide and
%	called as a subroutine.  Output is in a passed vector.
%	By Glenn Sasagawa, June 1988 
%
%	tides are calculated from harmonics 2 through 3 for
%	the lunar terms, 2 for the solar terms.
%	love numbers h(n), k(n), and l(n) are set by data statements.
%
%	gravity tide is in microgals, plus for up acceleration
%
%	Arguments
%	yr1,day1,zhr	Start year, day and hour
%	yr2,day2,yhr	Start year, day and hour
%     NOTE THAT ZHR AND YHR ARE DOUBLE PRECISION
%	d			Time interval in hours, DOUBLE PRECISION
%	theta		North latitude
%	lamda		East longitude
%	iterms		Number of output tide terms
%	gravtide		Output gravity tide
function [gravtide] = earth_tide(theta,lamda,gtime)
global dsz dcz dsl dcl ssz scz ssl scl dpar sdist;  % bpos common block
global h k l;                   	% love common block
       h =[0.6114  0.2891   0.175];
       k =[0.304   0.09421  0.043];
       l =[0.0832  0.0145   0.0103];

global azt azs;        % azimut common block
global etmut;                    % tdiff common block
global moon;                     % sunny common block
       moon=0;
% hardwire these - you can only send it ONE droptime
deltat = 1;
NPT = 1;
% change droptime in datstr format 
% YY,MO,DD,HH,MM,SS - Start time in year-month-day-hour-minute-second
% changed so that YY is 4 character, not 2
%[YY MO DD HH MM SS] = undo_date(droptime_fg5);
   YY = gtime(1);
   MO = gtime(2);
   DD = gtime(3);
   HH = gtime(4);
   MM = gtime(5);
   SS = gtime(6);
% Initialize variables      

irl=1; iflag=0; ntotl=1; iget=[0 0 0 0 0 0 0]';
ispc=[0 0 0 0]'; ntw=[1 0 0]';
ioptn ='t'; ielement = 0;

%	data statements for input and output unit numbers (on terminal I/O)
inun=5; ioun=6; nptpb=6;

% Input stuff;
if nargin==8
   deltat = 1;
   NPT = 1;
end;

if isempty(HH) HH = 0; end;
if isempty(MM) MM = 0; end;
if isempty(SS) SS = 0; end;
if isempty(deltat) deltat = 1; end;
if isempty(NPT) NPT = 1; end;
   
%yr1=yr1-1900;
%yr2=yr2-1900;
yr1=YY-1900;
day1 = datenum(YY,MO,DD);
%	find times in hours from 0 hr, 1 jan 1900
%ts=zhr+24.d0*(day1-1)+8760.d0*yr1+24.d0*fix((yr1-1)/4);
%te=yhr+24.d0*(day2-1)+8760.d0*yr2+24.d0*fix((yr2-1)/4);
ts=SS/3600+MM/60 + HH+24.d0*(day1-1)+8760.d0*yr1+24.d0*fix((yr1-1)/4);
te = ts + (NPT-1)*deltat/3600;
d = deltat/3600;
%terms=(te-ts)/d + 1; 
terms=NPT; 
%fprintf ('Time runs from %11.4f to %11.4f with interval %6.4f\n',...
%   ts,te,d)
 
%done asking questions - begin execution
i = 1;
tt = ts;
sph(theta,lamda,0)
etmut = 41.184 + yr1 - 70;
while (tt <= te)
   t = (tt+12.d0 + (etmut/3600.d0))/876600.d0;
   %  t is ephemeris time in julian centuries from 12 hr 0 jan 1900
   ephem(t)
 
   % calculate normalized gravity tides
   [grav tilt strain gdc] = elastd(ntw);
   gravtide(i) = 1.e8*grav; 
   i = i + 1;
   tt = tt + d;
end
iflag = 1;

% write data out
iterms = fix(terms);
i = 1;
%fprintf('\n\n Each output series is %8d terms long\n',iterms);

%--------------------------------------------------------------------------
function [] =  sph(grlat,elong,ht)  
%   for a point at geographical north latitude grlat, east longitude elong      
%   (in degrees), and height ht (in meters), finds geocentric position   
%   and local g using formulae for a spheroid
% Initialize Variables 
%global cthet sthet clong slong dvert radn g;   %obs common block      
global cth sth clg slg dif radn gl 					%common/obs/
gn=9.798277692; ae=6378140.; f=0.00335281; rm=0.00344978; dr=0.01745329252;    
 
clong = cos(elong*dr);    
slong = sin(elong*dr);    
% latitude difference 
dvert = f*(1.+.5*f)*sin(2.*grlat*dr) - .5*f*f*sin(4.*grlat*dr);     
gcclat = (3.1415926535898/2.) - (grlat*dr - dvert);   
cthet = cos(gcclat);      
sthet = sin(gcclat);      
% geocentric radius   
radn = 1 - f*(cthet^2)*(1 + 1.5*f*(sthet^2));     
% formulae for g are from jeffreys, 4.022 and 4.023      
g = gn*(1 + f - 1.5*rm + f*(f-(27/14)*rm) + (2.5*rm - f -f*(f- ... 
      (39/14)*rm))*(cthet^2) - (f/2)*(7*f-15.*rm)*((cthet*sthet)^2));      
% free air correction 
g = g - g*(2.*ht*(1.+f+rm - 2.*f*(cthet^2))/ae) ;    

% Conversion Here for Globals
%global cthet sthet clong slong dvert radn g;    %obs common block      
%global cth sth clg slg dif radn gl %common/obs/
cth=cthet; sth=sthet; clg=clong; slg=slong; dif=dvert; g1=g;
  
 
function [] = ephem(t)
%   t is ephemeris time in julian centuries from 12 hr 0 jan 1900
%   (in ordinary civil reckoning this is greenwich noon on 31 december
%   1899). if the difference between ephemeris and unversal time is
%   not put in (see common tdiff below), t should be in universal time
%   which is (nearly) the time ordinarily kept by clocks.
%   computes positions of the sun and moon at time t, returning results
%   in common block bpos. the solar ephemeris uses the mean sun.
%   Derived from J. Levine's revision (after J. C. Harrison)
%   of an earthtide program by J. Berger and W. E. farrell, with small
%   alterations by D. C. Agnew, partly after M. Wimbush. present
%   subroutine version by d. c. agnew.
 
%   common block bpos contains, in order:
%   sine and cosine of colatitude of sublunar point
%   sine and cosine of east longitude of sublunar point
%   sine and cosine of colatitude of subsolar point
%   sine and cosine of east longitude of subsolar point
%   the lunar sine parallax in arc seconds
%   the solar distance in astronomical units
global dsz dcz dsl dcl ssz scz ssl scl dpar sdist; % bpos common block
%
%  common block containing the difference ephemeris minus
%  universal time, in seconds. if this is not known it should
%  be set to zero, and the argument to the program should be
%  universal rather than ephemeris time.
%
global etmut; %tdiff common block
%  common block containing the instruction on which ephemeris to compute
%  moon =   0  - both sun and moon
%      1  - moon only
%      2  - sun only
global moon;
%fcos(xxx) = cos(sngl(xxx));
%fsin(xxx) = sin(sngl(xxx));
pi20=62.8318530717958d0;
%   compute universal time in hours
ts = 876600.d0*t -12.d0 - (etmut/3600.d0);
hr = mod(ts,24.d0);
%   compute obliquity of the ecliptic
w = .409319747d0 - .0002271107d0*t;
cosw = cos(w);
sinw = sin(w);
t2 = t*t;
if (moon~=1) 
    % compute solar constants for given t
    hs = 4.881627982482d0 + 628.3319508731d0*t + 0.523598775578d-5*t2;
    hs = mod(mod(hs,pi20)+pi20,pi20);
    ps = 4.908229466993d0+ 0.03000526416690d0*t + 0.790246300201d-5*t2;
    es = 0.01675104d0 - 0.00004180d0*t - 0.000000126d0*t2;
    psig = 0.2617993877971d0*(hr-12.) + hs;
    chmp = cos(hs-ps);
    shmp = sin(hs-ps);
    ls = hs + shmp*es*(2.+2.5*es*chmp);
    sls = sin(ls);
    cz = sinw*sls;
    sz = sqrt(1.-cz^2);
    psis = atan2(cosw*sls,cos(ls));
    rbarr = 1. + es*(chmp + es*(chmp-shmp)*(chmp+shmp));
    ll = psis - psig;
    scz = cz;
    ssz = sz;
    ssl = sin(ll);
    scl =cos(ll);
    sdist = 1/rbarr;
end
% compute lunar constants for given t

if (moon==2) 
   return; 
end
hm=4.7199666d0+8399.7091449d0*t-.0000198d0*t2;
pm=5.83515154d0+71.01804120839d0*t-.180205d-3*t2;
nm=4.523601515d0-33.75714624d0*t+.3626406335d-4*t2;
%   bl bls bf bd are the fundamental arguments of browns theory
bl=hm-pm;
bls=hs-ps;
bf=hm-nm;
bd=hm-hs;
%   lunar lat long and parallax from brown.  latter two from
%   improved lunar ephemeris, latitude from ras paper of 1908...
tlongm=hm+.10976*fsin(bl)-.02224*fsin(bl-2.*bd)+0.01149*fsin(2.*bd)+...
       0.00373*fsin(2.*bl)-.00324*fsin(bls)-.00200*fsin(2.*bf)-0.00103*...
       fsin(2.*bl-2.*bd)-.00100*fsin(bl+bls-2.*bd)+0.00093*fsin(bl+2.*bd)...
       -.00080*fsin(bls-2.*bd)+.00072*fsin(bl-bls)-.00061*fsin(bd)-...
       .00053*fsin(bl+bls);
tlatm=.08950*fsin(bf)+.00490*fsin(bl+bf)-.00485*fsin(bf-bl)-.00303*...
      fsin(bf-2.*bd)+.00097*fsin(2.*bd+bf-bl)-.00081*fsin(bl+bf-2.*bd)+...
      .00057*fsin(bf+2.*bd);
plx=(3422.45+186.54*fcos(bl)+34.31*fcos(bl-2.*bd)+28.23*fcos(2.*bd...
     )+10.17*fcos(2.*bl)+3.09*fcos(bl+2.*bd)+1.92*fcos(bls-2.*bd)+1.44*...
     fcos(bl+bls-2.*bd)+1.15*fcos(bl-bls)-0.98*fcos(bd)-0.95*fcos(bl+...
     bls)-0.71*fcos(bl-2.*bf)+0.62*fcos(3.*bl)+0.60*fcos(bl-4.*bd));
sinmla=sin(tlatm);
cosmla=cos(tlatm);
sinmln=sin(tlongm);
cosmln=cos(tlongm);
%...convert from celestial lat and long according to explan suppl of
%......na and le page 26
cz=cosmla*sinmln*sinw+sinmla*cosw;
sz=sqrt(1.-cz^2);
at1=cosmla*sinmln*cosw-sinmla*sinw;
at2=cosmla*cosmln;
ram=atan2(at1,at2);
ll=ram-psig;
dcz = cz;
dsz = sz;
dsl = sin(ll);
dcl = cos(ll);
dpar = plx;
      
%------------------------------------------------------------------      
function [grav,tilt,strain,gdc] = elastd(ntw)
%   computes the earth tides on an elastic earth, given the solar and lunar
%   positions and the place of observation.  degree 2 is used for the solar
%   tides, 2 through 4 for the lunar tides. the results are returned in
%   grav, tilt, and strain. ntw(1) gives the number of gravity tides
%   ntw(2) the number of tilt tides, ntw(3) the number of strain tides.
%   as the dimensioning shows, at most one gravity tide, two tilts, and
%   three strains may be computed.  if ntw(1) = -1, the program will
%   put the equilibrium potential height for a rigid spherical earth in
%   grav.  the units are m/s**2, radians, extension, and meters.
%   the sign convention is positive for upward potential
%   height, a decrease in g, a tilt in the azimuth given, and
%   extensional strain.
%   that part of the tidal signal which comes from the permanent
%   deformation is subtracted out using the coefficient of .31455 m
%   found by Cartwright and Edden for the dc tide.
%
%   based (very closely) on J. Berger earth tide program.
%   converted to subroutine by D. Agnew Nov 1979.
%   computation of the potential and subtraction of dc tides added
%   by D. Agnew Jan 1980.
%
% Simulated common block obs with observatory information
global cth sth clg slg dif radn gl 
% Simulated common block love with love numbers 
global  h k l;      
% Simulated common block azimut with strainmeter and tiltmeter azimuths
global azt azs 
% Simulated common block bpos with lunar and solar colat and long, lunar sine parallax,
% and solar distance
global dsz dcz dsl dcl ssz scz ssl scl dpar sdist;  

coor =[dsz dcz dsl dcl ssz scz ssl scl];
par = dpar; 	
% Data for mean parallaxes, a times m over m(earth), equatorial radius.
rbor=[1.6592496e-2 4.2635233e-5]; amrat=[78451.25 2.1235762e12];a=6.37814e6;
g1=9.79828;g2=9.82022; ppp(1)=3.;iflag=0; strain(1) = 0;

% On first call compute factors for gravity and tilt, and dc tides
% at the given latitude.
if (iflag ~= 1) 
   iflag=1;
   for i = 1:3
     del(i) = 1. + (2./(i+1.))*h(i) - ((i+2.)/(i+1.))*k(i);
     dim(i) = 1. + k(i) - h(i);
   end  
	%  dc gravity tide is also known as the Honkasalo correction
	%  **note that the love numbers for an elastic earth are used
	%  in computing the dc tide as well.eq
	gdc = -3.0481e-7*(3*cth^2 - 1.)*del(1)*radn;
	tnsdc = -9.1445e-7*cth*sth.*dim(1).*radn./gl;
   etdc = -1.555e-8*(h(1)*(3.*cth^2-1.) - 6.*l(1)*(2.*cth^2 -1.));
   eldc = -1.555e-8*(h(1)*(3.*cth^2-1.) - 6.*l(1)*cth^2);
   potdc = .0992064*(1.-3*cth^2);
   re = 1./(radn*a);
end   

% zero out arrays
tilt = [0 0]; e = [0 0 0]; tltcor = [0 0]; grav = 0; gnth = 0;
% compute normalized parallax
pa(1) = par/3422.45; pa(2) = 1/sdist;
% in outer loop, ii = 1 for moon, 2 for sun
for ii = 1:2
	id = 3;
	if(ii==2) 
		id = 1; 
	end;
	ir = 4*(ii-1);
	% find cosine of zenith angle, potential constants, legendre polynomials
	% and their derivatives, and derivatives of the cosine of the zenith angle.
	cll = clg*coor(ir+4) + slg*coor(ir+3);
   sll = slg*coor(ir+4) - clg*coor(ir+3);
   cz = coor(ir+2);
   sz = coor(ir+1);
   cu = cth*cz + sth*sz*cll;
   xi = rbor(ii)*pa(ii)*radn;
	cc = amrat(ii)*rbor(ii)*pa(ii);
   %fprintf ('ii  amrat   %d %e  \n',ii,amrat(ii));
	rkr(1) = cc*xi*xi;
   rkr(2) = rkr(1)*xi;
   rkr(3) = rkr(2)*xi;
   p(1) = 0.5*(3*cu*cu - 1.);
   pp(1)=3*cu;
   if(ii~= 2) 
		p(2) = .5*cu*(5.*cu*cu - 3.);
      p(3) = .25*(7.*cu*p(2) - 3.*p(1));
      pp(2) = 1.5*(5.*cu*cu - 1.);
      pp(3) = .25*(7.*p(2) + cu*pp(2)) - 3.*pp(1);
      ppp(2) = 15.*cu;
      ppp(3) = 7.5*(7.*cu*cu - 1.);
	end
   cut = -sth*cz + cth*sz*cll;
   cutt = -cu;
   cul = -sth*sz*sll;
   cull = -sth*sz*cll;
   cutl = -cth*sz*sll;
   for j = 1:id
		if(ntw(1)==1) 
         grav = grav + del(j)*(j+1)*rkr(j)*p(j)*g1*re;
      %   fprintf('rkr(j) p(j) %e %d %e %e\n',grav,j,rkr(j),p(j));
      end
   end
   gnth = gnth - dim(1)*rkr(1)*pp(1)*g1*cut*re;
end
% ellipticity corrections, convert strains to strainmeter
%ntw
if (ntw(1)==1) 
   %grav
   %gnth
   %dif
   %gdc
   grav = grav + gnth*dif - gdc;
end

 

%-----------------------------------------------------------------
function [y] = fcos(xxx) ;
y = cos(xxx);
%y = cos(sngl(xxx));

function [y] = fsin(xxx);
y= sin(xxx);
%y= sin(sngl(xxx));

function [YYYY, MO, DD, HH, MM, SS] = undo_date(start_time);
% Kristine Larson
% ASEN 2003
% March 8, 2004
% code to read times (internal matlab datstr) from absolute gravity data files. 
% outputs 
%    year (YYYY), month (MO), day (DD), hour (HH), 
%    minute (MM), second (SS) appropriate for use in gravtide.m
% ouput times are integers
YYYY = str2num(datestr(start_time, 10));
MO = str2num(datestr(start_time, 5));
DD = str2num(datestr(start_time, 7));
hms = datestr(start_time, 13);
HH = str2num(hms(1:2));
MM = str2num(hms(4:5));
SS = str2num(hms(7:8));
