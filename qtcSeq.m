function [ seq ] = qtcSeq( qtcc, skip )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if (nargin<2)
    skip=0;
end;
if (iscell(qtcc))
    for i=1:length(qtcc)
        seq{i}=qtcSeq(qtcc{i},skip);
    end;
else
    [c,n]=qtc2case(qtcc);
    seq=[1 n+1 (3.^size(qtcc,2))+2];
    seq=seq(skip+1:end);
end

