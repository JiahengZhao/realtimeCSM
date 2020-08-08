function [bestPose, bestScore] = nTo1Matching(nLevel,currMapPt,cellResolution,lidar_param,...
    allScan, initial_pose, multiResolution,tmax, rmax)
% MULTIMATCHING multi resolution scan matching
% AUTHOR: Jiaheng Zhao
t1 = tic;
nScan = size(allScan,2);
for level = 1:nLevel
    gridMap{level} = buildGridMap(currMapPt, cellResolution/(2^level) ,lidar_param);
end
for level = nLevel-1:-1:1
    gridMap{level} = keepHighLikelihood(gridMap{level},gridMap{level+1});
end
bestPose1 = cell(1,nScan-1);
bestPose = bestPose1;
bestScore = bestPose;
for iScan = nScan-1:-1:1
    if iScan <= nScan-2
       delt(1:2,1) = bestPose{iScan}(1:2) - bestPose{iScan+1}(1:2);
       delt(3) = bestPose{iScan}(3) - bestPose{iScan+1}(3); delt(3) = wrapToPi(delt(3));
        initial_pose = delt;
    end
    for level = 1:nLevel
        
        if level == 1
            [bestPose1{iScan}, ~] = fineSearch(gridMap{level}, allScan{iScan}, initial_pose,...
                multiResolution,tmax, rmax,1);
        else
            resoRatio = gridMap{level-1}.resolution / gridMap{level}.resolution;
            [bestPose{iScan}, bestScore{iScan}] = fineSearch(gridMap{level}, allScan{iScan}, bestPose1{iScan},...
                multiResolution,multiResolution(1), multiResolution(3),resoRatio);
        end
    end
end
t2 = toc(t1);

disp(['Many To 1 Multi Level resolution runtime: ', num2str(t2),'s.']);

end