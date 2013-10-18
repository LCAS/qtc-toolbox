function [ res ] = qtcSeqDecode( hmm, qtcc,skip )
if nargin<3
    skip=1;
end;
    
    s=qtcSeq(qtcc,skip);
    if (~iscell(s))
        s={s};
    end;
    for i=1:length(s)
        [st, problog]=hmmdecode(s{i},hmm.t,hmm.e);
        [m,ix]=max(st);
        
        res(i).origSeq=qtcCase2Label(s{i}-1);
        res(i).origCaseSeq=s{i}-1;
        res(i).stateSeq=qtcCase2Label(ix-1);
        res(i).stateCaseSeq=ix-1;
        res(i).st=st;
        res(i).problog=problog;
    end
    
end

