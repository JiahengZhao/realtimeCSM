function n = selectNodes(nodes)
%SELECTNODES find the optimal node.
%AUTHOR Jiaheng Zhao

if size(nodes,2)==1
    n = 1;
    return;
end

% Search for the best node to expand
n = 0;
bestScore = Inf;

for a = 2:length(nodes)
    if nodes(a).bestScore < bestScore && ~nodes(a).expand && ~nodes(a).full
        bestScore = nodes(a).bestScore;
        n = a;
    end
end

end