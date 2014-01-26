function [ qtcc_rep, frames ] = qtcc( human, robot, accuracy, varargin )
%QTCC Summary of this function goes here
%   Creates (and plots) a QTC_C sequence from a given vector of points.
%   human and robot are x,y column vectors, accuracy is the distance to the
%   lines at which a point is considered to lay on the line.
%   plot = 1 turns on visualisation and saves them as framjes in frame to
%   be replayed afterwards.

plot = 0; collaps = 1;
nVarargs = length(varargin);
for i=1:nVarargs
    if strcmp(varargin{i}, 'plot')
        plot = 1;
    elseif strcmp(varargin{i}, 'nocollaps')
        collaps = 0;
    end
end


qtcc_rep_tmp = [];

end_idx = size(human,1);
if size(human,1) ~= size(robot,1)
    end_idx = min([size(human,1) size(robot,1)]);
end

for i=2:end_idx
    RL = [human(i-1,1:2); robot(i-1,1:2)];
    tmp1 = qtcTranslate(human(i-1,1:2), .5*(human(i-1,1:2)-robot(i-1,1:2)));
    tmp2 = qtcTranslate(robot(i-1,1:2), .5*(robot(i-1,1:2)-human(i-1,1:2)));
    RL_ext = [tmp1(1:2); tmp2(1:2)];
    rot_RL = orthogonalLine([human(i-1,1:2) robot(i-1,1:2)-human(i-1,1:2)], human(i-1,1:2));
    trans_RL_h = qtcTranslate([rot_RL(1,1:2); rot_RL(1,3:4)], (rot_RL(1,1:2)-rot_RL(1,3:4))/2);
    trans_RL_r = qtcTranslate(trans_RL_h, (robot(i-1,1:2)-human(i-1,1:2)));
    
    % robot movement: k
    k = [Inf, Inf];
    
    x0 = robot(i,1);
    y0 = robot(i,2);
    x1 = trans_RL_r(2,1);
    y1 = trans_RL_r(2,2);
    x2 = trans_RL_r(1,1);
    y2 = trans_RL_r(1,2);
    test=(x0 - x1) * (y2 - y1) - (x2 - x1) * (y0 - y1);
    d = abs(det([trans_RL_r(2,1:2)-trans_RL_r(1,1:2);robot(i,1:2)-trans_RL_r(1,1:2)]))/norm(trans_RL_r(2,1:2)-trans_RL_r(1,1:2));
    if test > 0 & abs(d) > accuracy
        k(1,1) = -1;
    elseif test < 0 & abs(d) > accuracy
        k(1,1) = 1;
    else
        k(1,1) = 0;
    end

    x0 = robot(i,1);
    y0 = robot(i,2);
    x1 = RL_ext(2,1);
    y1 = RL_ext(2,2);
    x2 = RL_ext(1,1);
    y2 = RL_ext(1,2);
    test=(x0 - x1) * (y2 - y1) - (x2 - x1) * (y0 - y1);
    d = abs(det([RL_ext(2,:)-RL_ext(1,:);robot(i,1:2)-RL_ext(1,:)]))/norm(RL_ext(2,:)-RL_ext(1,:)); 
    if test < 0 & abs(d) > accuracy
        k(1,2) = -1;
    elseif test > 0 & abs(d) > accuracy
        k(1,2) = 1;
    else
        k(1,2) = 0;
    end
    
    % movement of human: l
    l = [Inf, Inf];

    x0 = human(i,1);
    y0 = human(i,2);
    x1 = trans_RL_h(1,1);
    y1 = trans_RL_h(1,2);
    x2 = trans_RL_h(2,1);
    y2 = trans_RL_h(2,2);
    test = (x0 - x1) * (y2 - y1) - (x2 - x1) * (y0 - y1);
    d = abs(det([trans_RL_h(2,1:2)-trans_RL_h(1,1:2);human(i,1:2)-trans_RL_h(1,1:2)]))/norm(trans_RL_h(2,1:2)-trans_RL_h(1,1:2));
    if test > 0 & abs(d) > accuracy
        l(1,1) = -1;
    elseif test < 0 & abs(d) > accuracy
        l(1,1) = 1;
    else
        l(1,1) = 0;
    end

    x0 = human(i,1);
    y0 = human(i,2);
    x1 = RL_ext(1,1);
    y1 = RL_ext(1,2);
    x2 = RL_ext(2,1);
    y2 = RL_ext(2,2);
    test = (x0 - x1) * (y2 - y1) - (x2 - x1) * (y0 - y1);
    d = abs(det([RL_ext(2,:)-RL_ext(1,:);human(i,1:2)-RL_ext(1,:)]))/norm(RL_ext(2,:)-RL_ext(1,:));
    if test < 0 & abs(d) > accuracy
        l(1,2) = -1;
    elseif test > 0 & abs(d) > accuracy
        l(1,2) = 1;
    else
        l(1,2) = 0;
    end
    
    % print
    qtcc_rep_tmp = [qtcc_rep_tmp; [l(1,1) k(1,1) l(1,2) k(1,2)]];
    
    % plot
    if plot == 1
        qtcPlotPoses(human(i-1:i,:), robot(i-1:i,:), 2, 1, 1)
        axis equal
        line_rl = line(RL_ext(:,1), RL_ext(:,2), 'Color', 'm');
        rl_l = line(trans_RL_h(:,1)', trans_RL_h(:,2)', 'Color', 'm');
        rl_r = line(trans_RL_r(:,1)', trans_RL_r(:,2)', 'Color', 'm');
        title(['QTC_C state transition: (', num2str(qtcc_rep_tmp(end-1,:)), ') -> (',num2str(qtcc_rep_tmp(end,:)), ')']);
        frames(i-1) = getframe;
        pause(0.01);
        delete(line_rl);
        delete(rl_l);
        delete(rl_r);
    else
        frames = struct;
    end
end

if isempty(qtcc_rep_tmp)
    disp('!!!Empty qtcc_rep!!!')
    qtcc_rep = [0 0 0 0];
    frames = struct;
    return;
end

if size(qtcc_rep_tmp,1) == 1
    disp('!!!Just one data point!!!')
    qtcc_rep = [0 0 0 0];
    frames = struct;
    return;
end

if collaps
    qtcc_rep = qtcc_rep_tmp(1,:);
    j = 1;
    for i=2:size(qtcc_rep_tmp,1)
        if(~isequal(qtcc_rep(j,:), qtcc_rep_tmp(i,:)))
            qtcc_rep = [qtcc_rep; qtcc_rep_tmp(i,:)];
            j = j + 1;
        end
    end
else
    qtcc_rep = qtcc_rep_tmp;
end

end

