function [bestPose, bestScore] = multiMatching(nLevel,currMapPt,cellResolution,lidar_param,...
    thisScan, initial_pose, multiResolution)
% MULTIMATCHING multi resolution scan matching
% AUTHOR: Jiaheng Zhao
t1 = tic;
for level = 1:nLevel
    gridMap{level} = buildGridMap(currMapPt, cellResolution/(2^(level-1)) ,lidar_param);
%         gridMap{level} = buildGridMap(currMapPt, cellResolution/(10^(level-1)) ,lidar_param);
end
for level = nLevel-1:-1:1
    gridMap{level} = keepHighLikelihood(gridMap{level},gridMap{level+1});
end

% gridMap = {gridMap{4},gridMap{3},gridMap{2},gridMap{1}};

node = BBSearch(nLevel,gridMap, thisScan, initial_pose, multiResolution);
bestPose = node.bestPose;
bestScore = node.bestScore;

t2 = toc(t1);

disp(['Multi Level resolution runtime: ', num2str(t2),'s.']);

end