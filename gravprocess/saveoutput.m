%% save output into a text file
stroutfile=get(fileedit16,'String');
display(strcat('Save result into: ',stroutfile));
fid = fopen(stroutfile, 'w');
out=[dataattachabs(1,:);dataattachabs(4,:);dataattachabs(5,:);dataattachabs(6,:);...
    dataattachabs(2,:);erreurg;dataattachabs(2,:)-(gth-fa);erreurfreeair;...
    dataattachabs(2,:)-(gth-fa+terrain);erreurbouguer;...
    dataattachabs(8,:);dataattachabs(9,:);gattachstd*ones(1,length(dataattachabs));...
    std(dgattachabs2)*ones(1,length(dataattachabs));0.3086*dataattachabs(7,:);...
    0.065*DEMerror*ones(1,length(dataattachabs))];
fprintf(fid, '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g\n', out);
fclose(fid);
display('Done !');