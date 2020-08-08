function [pose, bestScore] = Matching(gridmap_low,gridmap_high, scan, pose, serchWindow)
% MATCHING scan matching in the serching window.
% AUTHOR Jiaheng Zhao

% resolution_low = gridmap_low.resolution;
% resolution_high = gridmap_high.resolution;
% resoRatio = resolution_low/resolution_high;

bestPose  = pose;
gridMap{1} = gridmap_low;
gridMap{2} = gridmap_high;
t1 = tic;

node = BBSearch(2,gridMap, scan, bestPose, serchWindow);
    bestPose = node.bestPose{:};
    bestScore = node.bestScore;
t4= toc(t1);
%%
if isempty(bestScore)
    error('Result is wrong');
end
pose = bestPose;
disp(['2-Level using Branch and Bound: ', num2str(t4),'s.']);


end

