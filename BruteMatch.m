function [pose, bestHits] = BruteMatch(gridmap, scan, pose,...
                            bruteResolution, tmax, rmax)
% Grid map information
logLookupTable = gridmap.logLookupTable;
minX   = gridmap.origin(1);
minY   = gridmap.origin(2);
nCols  = size(logLookupTable, 2);
nRows  = size(logLookupTable, 1);

% Search space                               
xs = (pose(1) - tmax) : bruteResolution(1) : (pose(1) + tmax);
ys = (pose(2) - tmax) : bruteResolution(2) : (pose(2) + tmax);
rs = (pose(3) - rmax) : bruteResolution(3) : (pose(3) + rmax);
nx = length(xs);    ny = length(ys);    nr = length(rs);

% Searching
scores = Inf(nx, ny, nr);
bestScore = Inf;

t1 = tic;
% Rotation
for ir = 1 : nr
     
    theta = rs(ir);
    R_gc = theta2R(theta); % rotation from current scan to global frame
    GcellScan  =  R_gc * scan;    
    
    % Translation along x-axis
    for ix = 1 : nx
        tx = xs(ix);
        ScanIDx = round((GcellScan(1,:)+tx-minX)/ gridmap.resolution) + 1;
        
        % Translate along y-axis
        for iy = 1 : ny
            
            ty = ys(iy);
            ScanIDy = round((GcellScan(2,:)+ty-minY)/ gridmap.resolution) + 1;
            
            % Metric score
            isIn = ScanIDx>1 & ScanIDy>1 & ScanIDx<nCols & ScanIDy<nRows;
%             idx  = ScanIDy(isIn) + (ScanIDx(isIn)-1)*nRows;
            
            idx = nRows - ScanIDy(isIn) + 1 + (ScanIDx(isIn)-1)*nRows;
            
            hits = logLookupTable(idx);
            score = sum(hits);
            
            scores(ix, iy, ir) = score;
            
            if score < bestScore
                bestScore = score;
                bestHits = hits;
                pose = [tx; ty; theta];
            end
            
        end  
    end
end

t2 = toc(t1);
disp(['Brute Force runtime: ', num2str(t2),'s.']);
