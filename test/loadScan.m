function [lidar_param, scan, data] = loadScan
% LOADSCAN load scans and lidar parameters.
% AUTHOR Jiaheng Zhao

% Fetch Lidar parameters.
% lidar_param.angle_min = -1.91990637779;
% lidar_param.angle_max =  1.92525243759;
% lidar_param.angle_increment = 0.00581718236208;
% lidar_param.npoints   = 662;
% lidar_param.range_min = 0.0500000007451;
% lidar_param.range_max = 25.0;
% lidar_param.scan_time = 0.0666666701436;
% lidar_param.time_increment  = 6.17280020379e-05;
% lidar_param.angles = (lidar_param.angle_min : lidar_param.angle_increment : lidar_param.angle_max)';
lidar_param.Cov = 2e-2.^2;
% Cartographer
lidar_param.angle_min = -2.351831;
lidar_param.angle_max =  2.351831;
lidar_param.angle_increment = 0.004363;
lidar_param.npoints   = 1079;
lidar_param.range_min = 0.023;
lidar_param.range_max = 60;
lidar_param.scan_time = 0.025;
lidar_param.time_increment  = 1.736112e-05;
lidar_param.angles = (lidar_param.angle_min : lidar_param.angle_increment : lidar_param.angle_max)';
% %Siasun
% lidar_param.angle_min = -2.35619449615;
% lidar_param.angle_max =  2.35619449615;
% lidar_param.angle_increment = 0.00436332309619;
% lidar_param.npoints   = 1081;
% lidar_param.range_min = 0.5;
% lidar_param.range_max = 60;
% lidar_param.scan_time = 0.0250000003725;
% lidar_param.time_increment  = 1.73611151695e-05;
% lidar_param.angles = (lidar_param.angle_min : lidar_param.angle_increment : lidar_param.angle_max)';
% load data
% data = load('siasun.mat');
data = load('data_demo1.mat');

usableRange = 24;
for i = 1:size(data.ranges,1)
    scan.scan{i} = pol2scan(data.ranges(i,:),usableRange,lidar_param);
    %     scan.scan_2 = pol2scan(data.ranges(5,:),usableRange,lidar_param);
    
end
end

function scan = pol2scan(ranges,usableRange,lidar_param)
% Convert range-bearing to Cartesian coordinates and filter outliers.
if size(ranges,1) < size(ranges,2)
    ranges = ranges';
end

maxRange = min(lidar_param.range_max, usableRange);
isBad = ranges < lidar_param.range_min | ranges > maxRange | isnan(ranges);
angles = lidar_param.angles;
angles(isBad) = [];
ranges(isBad) = []; % This step is to delet unauthentic elements from the whole matrix.
% Convert from polar coordinates to cartesian coordinates
[xs, ys] = pol2cart(angles, ranges);
scan = [xs, ys]';
end