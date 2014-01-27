function [ res ] = qtcSeqDecode( hmm, qtcc, varargin )
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
        type = 'combined';
    end
end
    
if combined
    s=qtcCombinedSeq(qtcc, skip);
else
    s=qtcSeq(qtcc,skip);
end

if (~iscell(s))
    s={s};
end;
for i=1:length(s)
    [st, problog]=hmmdecode(s{i},hmm.t,hmm.e);
    [m,ix]=max(st);

    res(i).origSeq=qtcCase2Label(s{i}-1, type);
    res(i).origCaseSeq=s{i}-1;
    res(i).stateSeq=qtcCase2Label(ix-1, type);
    res(i).stateCaseSeq=ix-1;
    res(i).st=st;
    res(i).problog=problog;
end
    
end

