function [ seq ] = qtcCombinedSeq( qtc, skip )
%QTCCOMBINEDSEQ Summary of this function goes here
%   Detailed explanation goes here

seq = [];

if iscell(qtc) & ~isempty(qtc)
    if ~isempty(qtc{1})
        if iscell(qtc{1}(1))
            for j = 1:length(qtc)
                seq{j} = qtcCombinedSeq( qtc{j}, skip );
            end
            return;
        end
    else
        5
    end
end
if iscell(qtc)
    for i = 1:length(qtc)
        tmp = qtcCombinedSeq(qtc{i});
        if size(qtc{i},2) == 2
            tmp = tmp(2:end-1);
        elseif size(qtc{i},2) == 4
            tmp = tmp(2:end-1);
            tmp = tmp + 9;
        end
        seq = [seq, tmp];
    end
else
    seq = qtcSeq(qtc);
    return;
end

seq = [1 seq 92];
seq = seq(skip+1:end);

end

