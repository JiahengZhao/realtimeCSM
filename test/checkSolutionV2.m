function [ck, new_nodes] = checkSolutionV2(nLevel,this_node,nodes)
% CHECKSOLUTION check the node
% AUTHOR Jiaheng Zhao
%   Input:
%       nodes is an array of structures
%   Output:
%       n is an integer (the index of the optimal node, n is 0 if there is
%       no optimal solution)

% bestScore = Inf;
% If this is not the deepest level, return 0;
if this_node.level(1) < nLevel
    ck = 0;
    new_nodes = [nodes; this_node];
    return
end

this_node = this_node(1,:);

deletID = nodes.bestScore > this_node.bestScore(1);
nodes(deletID,:) = [];
new_nodes = [nodes;this_node];

unexpandID = ~new_nodes.expand & ~new_nodes.full;
idnlevel = new_nodes.level == nLevel;
if ~isempty(idnlevel) && sum(idnlevel)>3
    ck = new_nodes.bestScore == min(new_nodes.bestScore(idnlevel));
    ck = find(ck);
    ck = ck(1);
    return
end

if sum(unexpandID) ~= 0
    bestScore = min(new_nodes.bestScore(unexpandID));
    goodID = (new_nodes.full) & (new_nodes.bestScore <= bestScore);
    ck = find(goodID);
else
    ck = new_nodes.bestScore == min(new_nodes.bestScore(new_nodes.full));
    ck = find(ck);
    ck = ck(1);
end


end


