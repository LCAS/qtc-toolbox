function [ real_qtc_rep ] = qtcInsertLegalTrans( qtc_rep )
%QTCINSERTLEGALTRANS 
%   Inserts zero Transitions to create legal QTC state chains. Works for
%   QTC_b and QTC_c.
%
%   LEGAL_QTC_REP = QTCINSERTLEGALTRANS(QTC_REP) insert transition states
%   into the original QTC representation and return new representation.
%   QTC_REP and LEGAL_QTC_REP are matrixes, e.g. [q1 q2 q3 q4; ...] for
%   QTC_c.

if size(qtc_rep,1) <= 1
    warning('qtc-toolbox:qtcInsertLegalTrans:%s', 'Just one or less data points in qtc rep')
    real_qtc_rep = qtc_rep;
    return;
end

real_qtc_rep = qtc_rep(1,:);

for i=2:size(qtc_rep,1)
    insert = qtc_rep(i,:);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % self transition = 0, transition form - to + and vice versa = 2
    % transitions from - to 0 or + to 0 and vice versa = 1
    insert(abs(qtc_rep(i-1,:)-insert)>1) = 0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % find invalid transitions according to CND:
    % 1,2: -000 <> 0-00 | +000 <> 0+00 | -000 <> 0+00 | +000 <> 0-00
    % 1,3: -000 <> 00-0 | +000 <> 00+0 | -000 <> 00+0 | +000 <> 00-0
    % 1,4: -000 <> 000- | +000 <> 000+ | -000 <> 000+ | +000 <> 000-
    % 2,3: 0-00 <> 00-0 | 0+00 <> 00+0 | 0-00 <> 00+0 | 0+00 <> 00-0
    % 2,4: 0-00 <> 000- | 0+00 <> 000+ | 0-00 <> 000+ | 0+00 <> 000-
    % 3,4: 00-0 <> 000- | 00+0 <> 000+ | 00-0 <> 000+ | 00+0 <> 000-
    for j1=1:size(qtc_rep(i,:),2)-1
        for j2=j1+1:size(insert,2)
            if sum(abs(qtc_rep(i-1,[j1,j2])))==1 ...
                    & sum(abs(insert(1,[j1,j2])))==1
                if max(abs(qtc_rep(i-1,[j1,j2])-insert(1,[j1,j2]))) > 0 ...
                        & sum(qtc_rep(i-1,[j1,j2])-insert(1,[j1,j2]))~=1
                    insert(1,[j1 j2]) = 0;
                    break;
                end
            end
        end
    end

    if ~isequal(insert,qtc_rep(i,:))
        real_qtc_rep = [real_qtc_rep; insert];
    end
    real_qtc_rep = [real_qtc_rep; qtc_rep(i,:)];
end

end

