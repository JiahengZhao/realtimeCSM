function map = initializationProb(scan, pose)
% INITIALIZATIONPROB initializing a map with the first scan.
% AUTHOR Jiaheng Zhao


map.points = transScan(scan, pose); 
% map.size = % it should be integer multiple resolution


end