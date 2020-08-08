function [bestPose, bestScore] = fineSearch(gridmap, scan, pose, serchWindow,tmax, rmax,resoRatio)
% FINESEARCH exhaustive search
% AUTHOR: Jiaheng Zhao

logLookupTable = gridmap.logLookupTable;
nCols  = size(logLookupTable, 2);
nRows  = size(logLookupTable, 1);
minX   = gridmap.origin(1);
minY   = gridmap.origin(2);
resolution = gridmap.resolution;

% Search in the high resolution
xsh = (pose(1) - tmax) : serchWindow(1)/resoRatio : (pose(1) + tmax);
ysh = (pose(2) - tmax) : serchWindow(2)/resoRatio : (pose(2) + tmax);
rsh = (pose(3) - rmax) : serchWindow(3)/resoRatio : (pose(3) + rmax);
nxh = length(xsh);    nyh = length(ysh);    nrh = length(rsh);

isChange = false;
bestScore = inf;
for itheta = 1 : nrh
    theta = rsh(itheta);
    R_gc = theta2R(theta); % rotation from current scan to global frame
    GcellScan  = R_gc * scan;
    
    for  iX = 1 : nxh
        tx = xsh(iX);
        ScanIDx = round((GcellScan(1,:)+tx-minX)/resolution) + 1;
        for iY = 1 : nyh
            ty = ysh(iY);
            ScanIDy = round((GcellScan(2,:)+ty-minY)/resolution) + 1;
            
            isIn = ScanIDx>1 & ScanIDy>1 & ScanIDx<nCols & ScanIDy<nRows;
            ix = ScanIDx(isIn);
            iy = ScanIDy(isIn);
            
            % to grid linear index
            %             idx = iy + (ix-1)*nRows_High;
            % test
            idx = nRows - iy + 1 + (ix-1)*nRows;
            
            logProbs = logLookupTable(idx);
            score = sum(logProbs);
            
            % update
            if score < bestScore
                bestPose  = [tx; ty; theta];
                bestScore = score;
                isChange = true;
            end
            
        end
    end
end

if ~isChange
    bestScore = [];
    bestPose = [];
end

end
