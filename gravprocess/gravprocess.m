%% GravProcess 1.0
%
%
% Matlab program to process gravity data and to evaluate the associated
% error. This program uses the following sub-programs:
%
% - completebouguer.m : Give a value to load or not DEM.            
% - DEMerrorparameter.m : Give the value of DEM elevation uncertainty.    
% - driftdegree.m : Give the degree of the polynomial function used in the
% instrumental drift.                 
% - earth_tide.m : Compute the tidal correction at a location and a given time.            
% - facor.m : Compute free air correction.
% - gattach.m : Find common gravity station(s) and attach gravity lines of
% the network.
% - gattachabs.m : Tie in relative gravity data to absolute gravity
% measurement(s).
% - gravprocess.m : Main subroutine. It is used to start the program. 
% - graviterrain.m : Calculate gravity terrain effect.
% - gstation.m : Calculate the mean and standard deviation of gravity
% measurement for each stations.
% - instrumentdrift.m : Compute the instrumental drift for each line.       
% - interface.m : Subroutine controling the graphical user interface.
% - latcor.m : Compute latitude correction from a defined ellispoid.         
% - loadairpressure.m : Load pressure file [STATION PRESSURE (hPa)
% TIME(hh:mm:ss displayed in Greenwich Mean Time) DATE(year/month/day)].
% - loadattach.m: Load network adjustment strategy file [LINE1 LINE2
% LINE_attached(with respect to LINE2)].
% - loadattachabs.m : Load absolute meausurements file [LON_BASE(decimal
% degre) LAT_BASE(decimal degre) GRAVITY_BASE(mGal)].
% - loadDEM.m : Load DEM file [LON(decimal degre) LAT(decimal degre)
% ALTITUDE(m)].
% - loadGPS.m : Load GPS location file [LON(decimal degre) LAT(decimal
% degre) ALTITUDE(m) ALTITUDE_STANDARD_DEVIATION(m) STATION].
% - loadgravi.m : Load gravity measurements file [LINE STATION ALTITUDE(m) 
% GRAVITY(mGal) STANDARD_DEVIATION(mGal) TILTX(arc_seconds) TILTY(arc_seconds)
% TEMPERATURE(temperature correction in mGal) TIDE(tidal correction in mGal)
% DURATION(duration of the reading in seconds) REJECTED(number of rejected
% measurements during the reading) TIME(hh:mm:ss displayed in Greenwich Mean
% Time) DECIMAL_TIME(h.hhh displayed in Greenwich Mean Time) TER(terrain
% correction in mGal) DATE(year/month/day)].
% - loadlines.m : Load lines and calibration coefficient file [NoLINE
% COEFFICIENT].
% - loadoceantide.m : Load ocean tide parameters.
% - loadpressure.m : Give a value to load or not pressure file.
% - loadtidal.m : Give a value to load or not tide file.
% - meshparameter.m : Give the value of parameters used for the mesh
% refinement.
% - ocean_tide.m : Find the closest point of ocean loading and compute the
% assocaited gravity effect.
% - parallelparameter.m : Give a value to use or not parallel computing.
% - plotairpressure.m : Plot air pressure and the associated gravity
% effect.
% - plotattach.m : Plot each step of the network adjustment.
% - plotbouguer.m : Plot Bouguer anomaly and the associated standard
% deviation.
% - plotdrift.m : Plot (1) for each line the instrument drift and (2)
% for all gravimeters the time variation of drift.
% - plotearthoceantide.m : Plot the effect of both ocean and solid earth
% tides.
% - plotfreeair.m : Plot free air anomaly and the associated standard
% deviation.
% - plotgravity.m : Plot gravity field and the associated standard
% deviation.
% - plotresult.m : Give value to define the choice of plot.
% - plotuncertainties.m : Plot uncertainties associated with raw data,
% instrument drift, network adjustment, station altitude error and DEM
% error.
% - pressurecorrection.m : Compute the gravity effect of air pressure
% variation.
% - runprocess.m : Manage the computing steps to assess gravity and gravity
% anomalies
% - saveoutput.m : Save output into a text file [STATION LON(decimal degre)
% LAT(decimal degre) ALT(m) GRAV(mGal) GRAV_STD(mGal) FREE-AIR(mGal)
% FREE-AIR_STD(mGal) BOUGUER BOUUGUER_STD(mGal) DATA_STD(mGal) DRIFT_STD(mGal)
% NETWORK_ADJUST_STD(mGal) ABS_STD(mGal) ALT_STA_STD(mGal) DEM_STD(mGal)].
% - startup.m : Give the paths where gravprocess is installed. Must be copy
% into the data directory.
% - tidalcorrection.m : Compute both solid earth and ocean tide effects.
% - wpolyfit.m : Fit polynomial to weighted data.

clear all;
close all;
format long;
%% Graphic interface parameters
valini='off';
vallines=valini;
valgravi=valini;
valGPS=valini;
valattach=valini;
valattachabs=valini;
valcomplete=valini;
valDEM=valini;
valmesh=valini;
valtidal=valini;
valocean=valini;
valpressure=valini;
valpara=valini;
valdriftdegree=valini;
valDEMerror=valini;
valair=valini;
valrun=valini;
%
strlines='lines.txt';
strdatagravi='datagravi.txt';
strGPSlocation='GPSlocation.txt';
strattachlist='attachlist.txt';
strgravbase='gravbase.txt';
strDEM='DEM.xyz';
strDEMparam='0.2 200 0.5';
stroceantidal='oceantidal.txt';
strpressure='pressure.txt';
strdegree='1';
strDEMerror='0.5';
stroutfile='gravprocess.out';
%
valuehpop1=1;
valuehpop2=1;
valuehpop3=1;
valuehpop4=1;
valuehpop5=1;
%% start user interface
interface;
