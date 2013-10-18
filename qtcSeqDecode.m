function [ s, problog, st ] = qtcSeqDecode( hmm, qtcc,skip )
if nargin<3
    skip=1;
end;
    
%qtcSeqDecode computes the log prob of a qtcSeq given an hmm models. Start
%and End state are automatically added.
%   Detailed explanation goes here
    s=qtcSeq(qtcc,skip);
[st, problog]=hmmdecode(s,hmm.t,hmm.e);
[m,ix]=max(st);
s=qtcCase2Label(ix-1);
end

