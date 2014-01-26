function [ newhmm ] = qtcTrainHmm( CND, qtcc, varargin )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
skip=1;
combined = 0;
nVarargs = length(varargin);
for i=1:nVarargs
    if strcmp(varargin{i}, 'skip')
        if i+1 > nVarargs
            disp(['ERROR: Missing input after ', varargin{i}])
            return;
        end
        i = i + 1;
        skip = varargin{i};
    elseif strcmp(varargin{i}, 'combined')
        combined = 1;
    end
end
if combined
    s=qtcCombinedSeq(qtcc, skip);
else
    s=qtcSeq(qtcc,skip);
end
[newhmm.t,newhmm.e]=hmmtrain(s,CND.t,CND.e,'PSEUDOTRANSITIONS',CND.t*1e-15,'PSEUDOEMISSIONS',CND.e*1e-15,'VERBOSE',true,'MAXITERATIONS',50);

end

