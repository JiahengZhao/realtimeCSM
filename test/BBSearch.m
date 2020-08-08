function out = BBSearch(nLevel,gridmap, scan, pose, serchWindow)
% BBSEARCH Branch and Bound search.  We use Depth-First-Search in this code.
% AUTHOR: Jiaheng Zhao

% generate node of the first level. This level contains all the result
nodes(1).level = 0;
nodes(1).bestPose = [];
nodes(1).bestScore = Inf;
nodes(1).expand = false;
nodes(1).full = false;
nodes = struct2table(nodes,'AsArray',true);
while true
    n = selectNodes(nLevel,nodes);
    new_node = generateNode(n(1),nodes,gridmap, scan, pose, serchWindow,nLevel);
    nodes.expand(n(1)) = true;
    [ck ,nodes]=  checkSolutionV2(nLevel, new_node,nodes);
    if ck
        break;
    end
end

out = nodes(ck,:);
end
