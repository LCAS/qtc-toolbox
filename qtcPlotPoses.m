function [ fig ] = qtcPlotPoses( human, robot, new_plot, plot_start, plot_end )
%PLOTPOSES Summary of this function goes here
%   Detailed explanation goes here

ps = 1;
pe = 1;

if nargin < 3 || new_plot == 1
    fg=figure;
    set(fg,'OuterPosition',[2638 326 562 505]);
elseif nargin >= 3 & new_plot == 2
    refresh
    set(gcf,'OuterPosition',[2638 326 562 505]);
end
if nargin >= 4 & plot_start == 0
    ps = 0; 
end
if nargin >= 5 & plot_end == 0
    pe = 0; 
end

hold on

tmp1 = plot(human(:,1), human(:,2), 'b-', 'LineWidth', 2);
tmp2 = plot(robot(:,1), robot(:,2), 'r-', 'LineWidth', 2);
% if nargin < 3 || new_plot == 1
    h = [tmp1; tmp2];
    set(h(1),'Displayname','Human')
    set(h(2),'Displayname','Robot')
    legend(h,'Location','north')
% end

if ps == 1
    plot(human(1,1), human(1,2), 'rs')
    plot(robot(1,1), robot(1,2), 'rs')
end
if pe == 1
    plot(human(size(human,1),1), human(size(human,1),2), 'kd')
    plot(robot(size(robot,1),1), robot(size(robot,1),2), 'kd')
end

end

