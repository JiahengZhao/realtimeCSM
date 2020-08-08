function currMapPts = roundBorder(mapPoint, pose, scan)
% ROUNDBORDER select current map size

% Transform current scan into world frame
scan_w = transScan(scan, pose);

% Set top-left & bottom-right corner
minX = min(scan_w(1,:) -1);
minY = min(scan_w(2,:) -1);
maxX = max(scan_w(1,:) +1);
maxY = max(scan_w(2,:) +1);

% Extract
isAround = mapPoint(1,:) > minX...
         & mapPoint(1,:) < maxX...
         & mapPoint(2,:) > minY...
         & mapPoint(2,:) < maxY;

currMapPts = mapPoint(:,isAround);