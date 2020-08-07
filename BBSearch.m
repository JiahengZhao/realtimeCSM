function out = BBSearch(nLevel,gridmap, scan, pose, serchWindow)
% BBSEARCH Branch and Bound search.  We use Depth-First-Search in this code.
% AUTHOR: Jiaheng Zhao

% genelize node of the first level. This level contains all the result
% level = 0; bestPose = []; bestScore = Inf; expand = false; full = false;
% Nodes = [];
% Nodes(1,1).level = 0;
% Nodes(1,1).bestPose = zeros(3,1);
% Nodes(1,1).bestScore = Inf;
% Nodes(1,1).expand = false;
% Nodes(1,1).full = false;
% Nodes = struct2table(Nodes,'AsArray',true);
nodes(1).level = 0;
% nodes(1).parent = [];
% nodes(1).children = [];
% nodes(1).nodeID = [];
nodes(1).bestPose = [];
nodes(1).bestScore = Inf;
nodes(1).expand = false;
nodes(1).full = false;
nodes = struct2table(nodes,'AsArray',true);
i=0;
while true
    n = selectNodes(nLevel,nodes);
    new_node = generateNode(n(1),nodes,gridmap, scan, pose, serchWindow,nLevel);
%     nodes(n).children = (size(nodes,2) + 1) : (size(nodes,2) + size(new_node,2));
    nodes.expand(n(1)) = true;
    [ck ,nodes]=  checkSolutionV2(nLevel, new_node,nodes);
    
%     nodes = [ nodes; new_node];
%     
%     ck = checkSolution(nodes);
    if ck
        break;
    end
    i=i+1
end

out = nodes(ck,:);
end
