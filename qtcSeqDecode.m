function [ problog, st ] = qtcSeqDecode( hmm, qtcSeq )
%qtcSeqDecode computes the log prob of a qtcSeq given an hmm models. Start
%and End state are automatically added.
%   Detailed explanation goes here
[c,n]=qtc2case(qtcSeq);
seq=[1 n+1 (3.^size(qtcSeq,2))+2]
[st, problog]=hmmdecode(seq,hmm.t,hmm.e);
end

