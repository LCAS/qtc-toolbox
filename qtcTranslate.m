function [ pose_trans ] = qtcTranslate( pose, trans_vec )
%TRANSLATE Summary of this function goes here
%   Translating every 2D point in pose by trans_vec


pose_trans = pose;

for i = 1:size(pose_trans,1)
    pose_trans(i,1:2)=pose_trans(i,1:2)+trans_vec;
end

end

