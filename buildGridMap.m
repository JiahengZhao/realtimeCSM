function gridmap = buildGridMap(scanPoints, resolution,lidar_param)
% GRIDMAP build occupancy grid map with given scan points and resolution. Log likelihood lookup
% table is also returned.
% AUTHOR Jiaheng Zhao

if nargin < 3
    Cov = 2e-2.^2;
else
    Cov = lidar_param.Cov;
end

% Grid size
minXY = min(scanPoints,[],2);%- 3 * resolution; % make sure all the points started at the left-bottom corner.
maxXY = max(scanPoints,[],2)+1;% + 3 * resolution; % 0.9 meter larger than the min x coordinate

numGrid = floor((maxXY - minXY) / resolution); % grid numbers in total
% numGrid = round((maxXY - minXY) / resolution) + 1; % grid numbers in total

%
hitPtsGrid = round( (scanPoints-minXY) / resolution ) + 1; % move to the corner
% idx = (hitPtsGrid(1,:)-1)*numGrid(2) + hitPtsGrid(2,:); % Convert x y index to linear indexing. 
% test
idx = (hitPtsGrid(1,:)-1)*numGrid(2) + numGrid(2) - hitPtsGrid(2,:) + 1; 

grid  = false(numGrid(2), numGrid(1)); % Grid original point is left-bottom corner, the corresponding matrix, 
%however, is origined at left-top corner
grid(idx) = true;
% grid = flip(grid);

logLikelihood = min(bwdist(grid),10);
logLikelihood = logLikelihood./max(logLikelihood,[],'all');
% logLikelihood = log(1./sqrt(2*pi*Cov) .* exp(-0.5.*(1./Cov).*logLikelihood.^2) );

gridmap.occGrid = grid;
gridmap.points = scanPoints;
gridmap.logLookupTable = logLikelihood; 
gridmap.resolution = resolution;
gridmap.origin = minXY;

end