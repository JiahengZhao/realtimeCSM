function [bestPose, bestScore] = multiMatching(nLevel,currMapPt,cellResolution,lidar_param,...
    thisScan, initial_pose, multiResolution)
% MULTIMATCHING multi resolution scan matching
% AUTHOR: Jiaheng Zhao
t1 = tic;
gridMap = cell(nLevel);
for level = 1:nLevel
    gridMap{level} = buildGridMap(currMapPt, cellResolution*(2^(nLevel-level)) ,lidar_param);
end
for level = nLevel-1:-1:1
    gridMap{level} = keepHighLikelihood(gridMap{level},gridMap{level+1});
end
t2 = toc(t1);
% gridMap = {gridMap{4},gridMap{3},gridMap{2},gridMap{1}};
t3 = tic;
node = BBSearch(nLevel,gridMap, thisScan, initial_pose, multiResolution);
bestPose = node.bestPose{:};
bestScore = node.bestScore;
t4 = toc(t3);

disp(['Multi Map Generation duration: ',num2str(t2),'s. Multi Level resolution runtime: ', num2str(t4),'s.']);

end