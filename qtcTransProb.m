function [ct,l]=qtcTransProb(qtcc);
allFrom=[];
allTo=[];
for (i=1:length(qtcc))
    [c,n]=qtc2case(qtcc{i});
    from=[0 n(1:end)];
    to=[n(1:end) 1000];
    allFrom=[allFrom from];
    allTo=[allTo to];
end;
[ct,chi2,p,l]=crosstab(allFrom, allTo);
l{1,1}='S';
l{end,2}='E';
ct=ct./length(qtcc);

