function [ newhmm ] = qtcTrainHmm( CND, qtcc, skip )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    s=qtcSeq(head_on_s,2);
    [newhmm.t,newhmm.e]=hmmtrain(s,CND.t,CND.e);

end

