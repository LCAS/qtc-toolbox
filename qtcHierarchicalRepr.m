function [ qtc_rep ] = qtcHierarchicalRepr( qtcc, distances, threshold )
%QTCHIERARCHICALREPRESENTATION Summary of this function goes here
%   Detailed explanation goes here

if size(qtcc,1)~=size(distances,1)
    error('qtc-toolbox:qtcHierarchicalRepr:%s','qtcc and distances must have the same length')
end

qtc_rep = {};

tmp = [];
for i=1:size(qtcc,1)
    qtcc(i,:)
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

