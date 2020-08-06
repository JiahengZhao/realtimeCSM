function gridMap_Low = keepHighLikelihood(gridMap_Low,gridMap_High)
%KEEPHIGHLIKELIHOOD maintain two gridmaps. Compute the low resolution table so that each 
%  cell is set to the maximum value of the corresponding cells in the high-resolution map.

resolution_low = gridMap_Low.resolution;
resolution_high = gridMap_High.resolution;
resoRatio = resolution_low/resolution_high;

% each grid map has a 3*resolution blank border.
tmpLow = gridMap_Low.logLookupTable;
tmpHigh0 = gridMap_High.logLookupTable;

% complementary tmpHigh
[a,b] = size(tmpLow);
[A,B] = size(tmpHigh0);
da = A - a*resoRatio ; db = B - b*resoRatio; % Maybe the dimension is slightly different.
tmpHigh1 =mat2cell(tmpHigh0(1:end-da, 1: end-db),resoRatio*ones(1,a),resoRatio*ones(1,b));
tmpHigh = cellfun(@(x) min(x(:)),tmpHigh1,'UniformOutput',0);
tmpHigh = cell2mat(tmpHigh);
rplID = tmpLow > tmpHigh;
tmpLow(rplID) = tmpHigh(rplID);
gridMap_Low.logLookupTable = tmpLow;
end