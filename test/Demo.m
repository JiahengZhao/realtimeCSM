% Demo
% Author: Jiaheng Zhao
% Date: 28/07/2020

clc;
clear all;
close all;

% load scan.
[lidar_param, scan, data] = loadScan;

% Map parameters
cellResolution_Low = 0.04;    % m
cellResolution_High = 0.02;    % m
% Scan matching parameters
nLevel = 2;

searchWindow  = [0.5; 0.5; deg2rad(20)];
nTo1index = [];

% 1-Brute Force; 2-2 Level CSM; 3-Multi-level CSM;
method = 2;

thisPose = [0; 0; 0];
traj = thisPose;

nStep = size(scan,1);
stepSize = 40;
startID = 1;
f = figure;
for thisStep = startID: stepSize: 1*(startID+stepSize+1)
    
    thisScan = scan.scan{thisStep};
    
    if thisStep == startID
        map = initializationProb(thisScan, thisPose);
        F=[];
        nTo1index = startID;
        initial_pose = thisPose;
        continue;
    end
    
    currMapPt = roundBorder(map.points, thisPose, thisScan); % 可以不用。有的点可以再找回来。
    
    % Scan matching
    % Uniform displacement
    delt(1:2,1) = thisPose(1:2) - traj(1:2,end);
    delt(3) = thisPose(3) - traj(3,end); delt(3) = wrapToPi(delt(3));
    initial_pose = thisPose + delt;
    
%     profile on;
    tic;
    switch method
        case 1
            gridMap_High = buildGridMap(currMapPt, cellResolution_High,lidar_param);
            [thisPose, ~] = BruteMatch(gridMap_High, thisScan, initial_pose, searchWindow, 0.5,deg2rad(7));
        case 2
            % Build grid map with two resolutions;
            gridMap_Low = buildGridMap(currMapPt, cellResolution_Low,lidar_param);
            gridMap_High = buildGridMap(currMapPt, cellResolution_High,lidar_param);
            % Maintain log likelihood of low resolution grid map and keep it as the upper bound
            gridMap_Low = keepHighLikelihood(gridMap_Low,gridMap_High);
            
            [thisPose, thisScore] = Matching(gridMap_Low,gridMap_High, thisScan, initial_pose,...
                  searchWindow);
        case 3
            [thisPose, thisScore] = multiMatching(nLevel,currMapPt,cellResolution_High,lidar_param,...
                thisScan, initial_pose, searchWindow);
%         case 4
%             if thisStep <= startID+stepSize
%                 continue;
%             end
%             allScan = scan.scan(nTo1index);
%             [thisPose, thisScore] = nTo1Matching(nLevel,thisScan,cellResolution_Low,lidar_param,...
%                 allScan, initial_pose, multiResolution,corResolution(1)*3, corResolution(3));
            
    end
    
    toc
%     profile viewer;
    
    if method ~= 4
        F = visulization(map,thisScan,thisPose,traj,method,F);
    else
        F = visulization(map,thisScan,thisPose,traj,method,F,allScan);
    end
    drawnow;
    traj = [traj thisPose];
    
    map = insertScan(map, thisPose, thisScan);
end