%% Lines and calibration coefficient file
% format: NoLINE COEFFICIENT
strlines=get(fileedit2,'String');
linesinput=load(strlines);
gravilines=linesinput(:,1);
K=linesinput(:,2);
clear linesinput;
vallines='on';
interface;