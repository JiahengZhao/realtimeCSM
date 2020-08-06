function map = insertScan(map, pose, scan)
%INSERTSCAN insert new scan to map points.
scan = transScan(scan, pose);

map.points = [map.points scan];

end