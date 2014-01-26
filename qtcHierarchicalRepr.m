function [ qtc_rep ] = qtcHierarchicalRepr( qtcc, distances, threshold )
%QTCHIERARCHICALREPRESENTATION
%   Uses a qtc_c state sequence and the distances between the two agents to
%   to either reduce qtc_c to qtc_b or leave it as it is. Collapses equal
%   adjacent states afterwards and returns a cell araay of qtc_b and qtc_c
%   descriptions.
%
%   QTC_REP = QTCHIERARCHICALREPRESENTATION(QTCC, DISTANCES, THRESHOLD)
%   Takes a column matrix of QTCC states, a column vector of according 
%   DISTANCES (has to be same length as qtcc matrix), and a THRESHOLD. 
%   qtc_c states will be reduced to qtc_b if distance is > THRESHOLD.
%   Returns a cell araay of the resulting qtc_b and qtc_c sequences.

if size(qtcc,1)~=size(distances,1)
    error('qtc-toolbox:qtcHierarchicalRepr:%s','qtcc and distances must have the same length')
end

qtc_rep = {};

tmp = [];
for i=1:size(qtcc,1)
    if distances(i,1) > threshold
        if ~isempty(tmp) & size(tmp,2) ~= 2
            qtc_rep{end+1,1} = tmp;
            tmp = [];
        else
            if ~isempty(tmp)
                if isequal(tmp(end,:),qtcc(i,1:2))
                   continue; 
                end
            end
            tmp = [tmp; qtcc(i,1:2)];
            
        end
    else
        if ~isempty(tmp) & size(tmp,2) ~= 4
            qtc_rep{end+1,1} = tmp;
            tmp = [];
        else
            if ~isempty(tmp)
                if isequal(tmp(end,:),qtcc(i,:))
                    continue;
                end
            end
            tmp = [tmp; qtcc(i,:)];
            
        end
    end
end
qtc_rep{end+1,1} = tmp;


end

