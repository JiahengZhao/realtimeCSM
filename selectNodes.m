function n = selectNodes(nLevel,nodes)
%SELECTNODES find the optimal node.
%AUTHOR Jiaheng Zhao

if size(nodes,1)==1
    n = 1;
    return;
end

% Search for the best node to expand
n = 0;
bestScore = Inf;

% if sum(nodes.level == nLevel) > 0   
if nodes.level(end) == nLevel   
    id = (~nodes.expand) & (~nodes.full);
    id2 = nodes.bestScore == min(nodes.bestScore(id)) & id;
    n = find(id2);
else
    id = (~nodes.expand) & (~nodes.full) & (nodes.level == nodes.level(end));
    id2 = nodes.bestScore == min(nodes.bestScore(id)) & id;
    n = find(id2);
end
% for a = 2:length(nodes)
%     if nodes(a).bestScore < bestScore && ~nodes(a).expand && ~nodes(a).full
%         bestScore = nodes(a).bestScore;
%         n = a;
%     end
% end

end