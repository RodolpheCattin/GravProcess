%% Clean up time
clear all;
close all;
%% Input and outputfile name
inputname = 'CG6test.txt';
outputname = 'CG5test_from_CG6test.txt';
%% Read CG6 file
CG6 = readtable(inputname);
%% Create CG5 table
ndata = size(CG6,1);
CG5 = table('Size',[ndata, 15],'VariableTypes',{'double','double', ...
    'double','double','double','double','double','double','double', 'double', ...
    'double','duration','double','double','string'});
%% Fill CG5 table
CG5(:,1) = CG6(:,5); % Line number
CG5(:,2) = CG6(:,1); % Station number
CG5(:,3) = {20}; % Ambient temperature in degrees
CG5(:,4) = CG6(:,8); % Gravity measurement in mGal 
CG5(:,5) = CG6(:,6); % Standard deviation of the mean of the five-second samples in mGal
CG5(:,6) = CG6(:,9); % Tilt about the X-axis in arcsecond
CG5(:,7) = CG6(:,10); % Tilt about the Y-axis in arcsecond,
CG5(:,8) = CG6(:,11); % Gravity sensor Temperature in mK
CG5(:,9) = CG6(:,12); % Tidal correction in mGal
CG5(:,10) = CG6(:,16); % Duration of measurement in seconds
CG5(:,11) = {0}; % Number of rejected samples
CG5(:,12) = CG6(:,3); % Start time of measurements in hours:minutes:seconds
CG5.Var13 = datenum(datetime(CG6.Var2))-datenum(2000,1,1)+datenum(CG5.Var12); % Decimal start time in decimal days
CG5(:,14) = {0}; % Terrain correction in mGal
CG5(:,15) = CG6(:,2); % Date in year/month/day
formatOut = 'yyyy/mm/dd';
CG5.Var15 = datestr(datetime(CG5.Var15),formatOut);
%% save CG5 table into a text file with the CG5 format
cellCG5 = table2cell(CG5);
fileID = fopen(outputname,'w');
formatSpec = '%12.7f %12.7f %7.4f %8.3f %5.3f %6.1f %6.1f %f %f %d %d %s %11.5f %6.4f %s \n';
for row = 1:ndata
    fprintf(fileID,formatSpec,cellCG5{row,:});
end
fclose(fileID);