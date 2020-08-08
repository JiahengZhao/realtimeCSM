function newnode = generateNode(n,nodes_all,gridmap, scan, pose, serchWindow,nLevel)
% GENERALNODE generate this node
% AUTHOR Jiaheng Zhao

% preID = size(nodes_all,2);
nodes = nodes_all(n,:);
level = nodes.level;

logLookupTable = gridmap{level+1}.logLookupTable;
nCols  = size(logLookupTable, 2);
nRows  = size(logLookupTable, 1);
minX   = gridmap{level+1}.origin(1);
minY   = gridmap{level+1}.origin(2);
resolution = gridmap{level+1}.resolution;

if level == 0
    tmax = serchWindow(1);
    rmax = 1 * (serchWindow(3));
    serchWindow(1:2) =  [resolution; resolution];
    serchWindow(3) = deg2rad(2);
else
    resoRatio = gridmap{1}.resolution / gridmap{level+1}.resolution;
    tmax = 1 * serchWindow(1) / resoRatio; % (level+1); %
    rmax = serchWindow(3);% (level+1); %
    serchWindow(1:2) =  [resolution; resolution];
    serchWindow(3) = deg2rad(2);
end

% search window
xsh = (pose(1) - tmax) : serchWindow(1) : (pose(1) + tmax);
ysh = (pose(2) - tmax) : serchWindow(2) : (pose(2) + tmax);
rsh = (pose(3) - rmax) : serchWindow(3) : (pose(3) + rmax);
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
            %             idx = iy + (ix-1)*nRows_High;
            % test
            idx = nRows - iy + 1 + (ix-1)*nRows;
            
            logProbs = logLookupTable(idx);
            score = sum(logProbs);
            
            % update
            bestPose  = [tx; ty; theta];
            bestScore = score;
            newnode(nodeID).level = level+1;
%             newnode(nodeID).parent = n;
%             newnode(nodeID).children =[];
%             newnode(nodeID).nodeID = preID + nodeID;
            newnode(nodeID).bestPose = bestPose;
            newnode(nodeID).bestScore = bestScore;
            newnode(nodeID).expand = false;
            if level < nLevel - 1
                newnode(nodeID).full = false;
            else
                newnode(nodeID).full = true;
            end
                nodeID = nodeID + 1;
        end
    end
end
% newnode(:).level = level+1;
% newnode.expand = false;

tmp = struct2table(newnode);
newnode = sortrows(tmp,'bestScore');
% newnode = table2struct(tmp);
% newnode = tmp';

end