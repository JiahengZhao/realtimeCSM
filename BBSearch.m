function out = BBSearch(nLevel,gridmap, scan, pose, serchWindow)
% BBSEARCH Branch and Bound search.  We use Depth-First-Search in this code.
% AUTHOR: Jiaheng Zhao

% genelize node of the first level. This level contains all the result

nodes(1).level = 0;
nodes(1).bestPose = [];
nodes(1).bestScore = Inf;
nodes = struct2table(nodes,'AsArray',true);
i=0;
while true
    [optNode, nodes] = selectNodes(nodes);
    if (optNode.level == nLevel)
        break;
    end
    new_node = generateNode(optNode,gridmap, scan, pose, serchWindow);
    
    nodes = [nodes; new_node];
    nodes = sortrows(nodes,'bestScore');
  
    i=i+1;
end

out = optNode;
end
