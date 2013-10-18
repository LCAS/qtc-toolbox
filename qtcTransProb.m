function [ct,l,ap]=qtcTransProb(qtcc);
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
ct=ct./repmat(sum(ct,2),1,size(ct,1))
ap(1)=1;
for i=2:size(l,1)
    ap(i)=nnz(allFrom==str2num(l{i,1}))/length(allFrom);
end;
ap(end+1)=1;


