function [ legal_qtc_rep ] = qtcInsertLegalTrans( qtc_rep )
%QTCINSERTLEGALTRANS 
%   Inserts zero Transitions to create legal QTC state chains. Works for
%   QTC_b and QTC_c.
%
%   LEGAL_QTC_REP = QTCINSERTLEGALTRANS(QTC_REP) insert transition states
%   into the original QTC representation and return new representation.
%   QTC_REP and LEGAL_QTC_REP are matrixes, e.g. [q1 q2 q3 q4; ...] for
%   QTC_c. If QTC_REP is a cell aray, LEGAL_QTC_REP will also be a cell
%   array of size [LENGTH(QTC_REP),1].

if iscell(qtc_rep)
    legal_qtc_rep = {};
    for i=1:length(qtc_rep)
        legal_qtc_rep{i,1} = qtcInsertLegalTrans(qtc_rep{i});
        if i > 1
            if iscell(legal_qtc_rep{i-1,1}) | iscell(legal_qtc_rep{i,1})
                error('qtc-toolbox:qtcInsertLegalTrans:%s','no nested cells allowed.')
            end
            diff = length(legal_qtc_rep{i-1,1}(end,:)) - length(legal_qtc_rep{i,1}(1,:));
            if diff > 0
                test1 = [legal_qtc_rep{i-1,1}(end,:); ...
                    [legal_qtc_rep{i,1}(1,:), nan(1, diff)]];
            else
                test1 = [[legal_qtc_rep{i-1,1}(end,:), nan(1, -diff); ...
                    legal_qtc_rep{i,1}(1,:)]];
            end
            test2 = qtcInsertLegalTrans(test1);
            if ~isequal(test1(~isnan(test1)),test2(~isnan(test2)))
                test2(isnan(test2))=0;
                legal_qtc_rep{i-1,1}(end+1,:) = test2(2,1:size(legal_qtc_rep{i-1,1},2));
            end
        end
        if sum(sum(isnan(legal_qtc_rep{i,1}))) > 0
            1
        end
    end
    return;
end

if size(qtc_rep,1) <= 1
    warning('qtc-toolbox:qtcInsertLegalTrans:%s', 'Just one or less data points in qtc rep')
    legal_qtc_rep = qtc_rep;
    return;
end

legal_qtc_rep = qtc_rep(1,:);

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
                end
            end
        end
    end

    if ~isequal(insert(~isnan(insert)),qtc_rep(i,~isnan(insert)))
        legal_qtc_rep = [legal_qtc_rep; insert];
    end
    legal_qtc_rep = [legal_qtc_rep; qtc_rep(i,:)];
end

end

