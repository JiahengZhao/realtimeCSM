function F = visulization(map,thisScan,thisPose,traj,flag,F,allScan)
% VISULIZATION show registration result
% AUTHOR: Jiaheng Zhao
switch flag
    case 1
        tlstr = 'Brute Force';
        allScan=[];
    case 2
        tlstr = '2-Level';
        allScan=[];
    case 3
        tlstr = 'Multi-Level';
        allScan=[];
    case 4
        tlstr = 'Many-to-one';
end

if flag ~= 4
if isempty(F)
    F.p1 = plot(map.points(1,:),map.points(2,:),'k.');
    hold on;axis equal
    dx10 = traj(1,:) + 0.5*cos(traj(3,:)); dy10 = traj(2,:) + 0.5*sin(traj(3,:));
    F.x1{1} = plot([traj(1,:);dx10],[traj(2,:);dy10],'Color','k','LineWidth',1.2);
    F.x1{2} = plot(traj(1,:),traj(2,:),'Color','k','Marker','o','MarkerFaceColor','k','MarkerSize',4);
    
    dx1 = thisPose(1,:) + 1*cos(thisPose(3,:)); dy1 = thisPose(2,:) + 1*sin(thisPose(3,:));
    F.x2{1} = plot([thisPose(1,:);dx1],[thisPose(2,:);dy1],'Color','b','LineWidth',1.2);
    F.x2{2} = plot(thisPose(1,:),thisPose(2,:),'Color','b','Marker','o','MarkerFaceColor','r','MarkerSize',4);
    F.p2 = plot(thisScan(1,:),thisScan(2,:),'r.');
    thisrealscan = transScan(thisScan,thisPose);
    F.p3 = plot(thisrealscan(1,:),thisrealscan(2,:),'go');
else
    set(F.p1,'XData',map.points(1,:),'YData',map.points(2,:));
    dx10 = traj(1,:) + 0.5*cos(traj(3,:)); dy10 = traj(2,:) + 0.5*sin(traj(3,:));
    F.x1{1} = plot([traj(1,:);dx10],[traj(2,:);dy10],'Color','k','LineWidth',1.2);
    F.x1{2} = plot(traj(1,:),traj(2,:),'Color','k','Marker','o','MarkerFaceColor','k','MarkerSize',4);
    dx1 = thisPose(1,:) + 1*cos(thisPose(3,:)); dy1 = thisPose(2,:) + 1*sin(thisPose(3,:));
    F.x2{1} = plot([thisPose(1,:);dx1],[thisPose(2,:);dy1],'Color','b','LineWidth',1.2);
    F.x2{2} = plot(thisPose(1,:),thisPose(2,:),'Color','b','Marker','o','MarkerFaceColor','r','MarkerSize',4);
    set(F.p2,'XData',thisScan(1,:),'YData',thisScan(2,:));
    thisrealscan = transScan(thisScan,thisPose);
    set(F.p3,'XData',thisrealscan(1,:),'YData',thisrealscan(2,:));
end
    title(tlstr);
    legend([F.p1,F.p2,F.p3],'source','curr','regi\_curr');
    set(gca,'FontSize',24);
    
else % case 4
    nScan = size(allScan,2);
    allPose = cellfun(@(x) invPose(x),thisPose,'UniformOutput',0);
    
    if isempty(F)
    F.p1 = plot(map.points(1,:),map.points(2,:),'k.');
    hold on;axis equal
    dx10 = traj(1,:) + 0.5*cos(traj(3,:)); dy10 = traj(2,:) + 0.5*sin(traj(3,:));
    F.x1{1} = plot([traj(1,:);dx10],[traj(2,:);dy10],'Color','k','LineWidth',1.2);
    F.x1{2} = plot(traj(1,:),traj(2,:),'Color','k','Marker','o','MarkerFaceColor','k','MarkerSize',4);
    
    dx1 = thisPose(1,:) + 1*cos(thisPose(3,:)); dy1 = thisPose(2,:) + 1*sin(thisPose(3,:));
    F.x2{1} = plot([thisPose(1,:);dx1],[thisPose(2,:);dy1],'Color','b','LineWidth',1.2);
    F.x2{2} = plot(thisPose(1,:),thisPose(2,:),'Color','b','Marker','o','MarkerFaceColor','r','MarkerSize',4);
    F.p2 = plot(thisScan(1,:),thisScan(2,:),'r.');
    thisrealscan = transScan(thisScan,thisPose);
    F.p3 = plot(thisrealscan(1,:),thisrealscan(2,:),'go');
else
    set(F.p1,'XData',map.points(1,:),'YData',map.points(2,:));
    dx10 = traj(1,:) + 0.5*cos(traj(3,:)); dy10 = traj(2,:) + 0.5*sin(traj(3,:));
    F.x1{1} = plot([traj(1,:);dx10],[traj(2,:);dy10],'Color','k','LineWidth',1.2);
    F.x1{2} = plot(traj(1,:),traj(2,:),'Color','k','Marker','o','MarkerFaceColor','k','MarkerSize',4);
    dx1 = thisPose(1,:) + 1*cos(thisPose(3,:)); dy1 = thisPose(2,:) + 1*sin(thisPose(3,:));
    F.x2{1} = plot([thisPose(1,:);dx1],[thisPose(2,:);dy1],'Color','b','LineWidth',1.2);
    F.x2{2} = plot(thisPose(1,:),thisPose(2,:),'Color','b','Marker','o','MarkerFaceColor','r','MarkerSize',4);
    set(F.p2,'XData',thisScan(1,:),'YData',thisScan(2,:));
    thisrealscan = transScan(thisScan,thisPose);
    set(F.p3,'XData',thisrealscan(1,:),'YData',thisrealscan(2,:));
end
    title(tlstr);
    legend([F.p1,F.p2,F.p3],'source','curr','regi\_curr');
    set(gca,'FontSize',24);
end
    
end