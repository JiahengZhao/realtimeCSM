function newnode = generateNode(nodes,gridmap, scan, pose, serchWindow)
% GENERALNODE generate this node
% AUTHOR Jiaheng Zhao


level = nodes.level;

logLookupTable = gridmap{level+1}.logLookupTable;
nCols  = size(logLookupTable, 2);
nRows  = size(logLookupTable, 1);
minX   = gridmap{level+1}.origin(1);
minY   = gridmap{level+1}.origin(2);
resolution = gridmap{level+1}.resolution;
searchStep = [resolution; resolution; deg2rad(2)];

if level == 0
    tmax = serchWindow(1);
    rmax = serchWindow(3);
else
    pose = nodes.bestPose{:};
    tmax = gridmap{level}.resolution/2; % (level+1); %
    rmax = 0;
end

% search window
xsh = (pose(1) ) : searchStep(1) : (pose(1) + 2*tmax);
ysh = (pose(2) ) : searchStep(2) : (pose(2) + 2*tmax);
rsh = (pose(3) ) : searchStep(3) : (pose(3) + 2*rmax);
nxh = length(xsh);    nyh = length(ysh);    nrh = length(rsh);

nodeID = 1;
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
            idx = nRows - iy + 1 + (ix-1)*nRows;
            
            logProbs = logLookupTable(idx);
            score = sum(logProbs);
            
            % update
            bestPose  = [tx; ty; theta];
            bestScore = score;
            newnode(nodeID).level = level+1;
            newnode(nodeID).bestPose = bestPose;
            newnode(nodeID).bestScore = bestScore;
                nodeID = nodeID + 1;
        end
    end
end

tmp = struct2table(newnode);
newnode = sortrows(tmp,'bestScore');

end