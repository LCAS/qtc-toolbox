function [ newhmm ] = qtcTrainHmm( CND, qtcc, skip )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    if nargin<3
        skip=1;
    end;
    s=qtcSeq(qtcc,skip);
    [newhmm.t,newhmm.e]=hmmtrain(s,CND.t,CND.e,'PSEUDOTRANSITIONS',CND.t*1e-15,'PSEUDOEMISSIONS',CND.e*1e-15,'VERBOSE',true,'MAXITERATIONS',50);

end

