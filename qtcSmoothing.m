function [ smoothed_data ] = qtcSmoothing( data, threshold, mode )
%BINNING Summary of this function goes here
%   Smoothing of trajectories.
%   Time smoothing needs a time, x, y colum vector of points. Threshold is
%   the time you want to average over.
%   Space thresholding needs a x,y column vector. Threshold is the
%   distance a point has to have from the previous one to be considered a
%   movement.

smoothed_data = data(1,:);
j = 1;

if strcmp(mode,'time')
    threshold = threshold + 0.01; % not nice but necessary?!
    tmp = [];
    for i=2:size(data,1)
        if data(i,1)-smoothed_data(j,1) <= threshold
            tmp = [tmp; data(i,:)];
        elseif ~isempty(tmp)
            smoothed_data = [smoothed_data; [data(i,1), mean(tmp(:,2:end),1)]];
            j = j + 1;
            tmp = [];
        end
    end
elseif strcmp(mode,'space')
    for i=2:size(data,1)
       mag = norm(data(i,1:2)-data(i-1,1:2));
       if mag > threshold
           smoothed_data = [smoothed_data; data(i,:)];
       else
           smoothed_data = [smoothed_data; smoothed_data(i-1,:)];
       end
    end
end


end

