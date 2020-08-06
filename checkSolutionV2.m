function [ck, new_nodes] = checkSolutionV2(nLevel,this_node,nodes)
% CHECKSOLUTION check the node
% AUTHOR Jiaheng Zhao
%   Input:
%       nodes is an array of structures
%   Output:
%       n is an integer (the index of the optimal node, n is 0 if there is
%       no optimal solution)

bestScore = Inf;
new_nodes = [];
% If this is not the deepest level, return 0;
if this_node(1).level < nLevel
    ck = 0;
    return
end

% Find minimum unexpanded partial node
for a = 1:length(nodes)
    if ~nodes(a).expand && nodes(a).bestScore < bestScore && ~nodes(a).full
        bestScore = nodes(a).bestScore;
    end
end
% bestScore
ck = 0;
% Check if a full solution is less than minimum unexpanded node
for a = 1:length(nodes)
    if ck == 0
        if nodes(a).full && nodes(a).bestScore < bestScore
            ck = a;
        end
    else
         if nodes(a).full && nodes(a).bestScore < bestScore && nodes(a).bestScore < nodes(ck).bestScore
            ck = a;
         end
    end
end

end


