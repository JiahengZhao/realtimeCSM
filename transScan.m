function data = transScan(scan,pose)
% TRANSSCAN transform scan with given pose. Scan should be 2 by n
% AUTHOR Jiaheng Zhao
if size(scan,1)>size(scan,2)
    scan = scan';
end

t = pose(1:2);
theta = pose(3);
R = theta2R(theta);
data = t + R * scan;

end