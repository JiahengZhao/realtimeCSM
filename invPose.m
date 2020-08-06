function tp = invPose(p)
%INVPOSE inverse pose (2D)
% AUTHOR Jiaheng Zhao
tp = -p;
R = theta2R(p(3));
tp(1:2) = -R'*p(1:2);

end