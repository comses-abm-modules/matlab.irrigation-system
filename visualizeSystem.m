function visualizeSystem(indexT, farmList, nodeList, linkList, timeSteps)


subplot(1,3,1)
cla;
colormap Lines;
colorSet = colormap;

for indexN = 1:size(nodeList,2)
    plotCircle(nodeList(indexN).x,nodeList(indexN).y,0.1,[1, 0, 0]);
    hold on;
end

for indexF = 1:size(farmList,2)
    plotCircle(farmList(indexF).x,farmList(indexF).y,0.4,[0,0,farmList(indexF).receipt / farmList(indexF).withdrawal]);
    x = [farmList(indexF).x; farmList(indexF).node.x];
    y = [farmList(indexF).y; farmList(indexF).node.y];
   plot(x, y, 'Color', [0,0,1]);
end

for indexL = 1:size(linkList,2)
    x = [linkList(indexL).inletNode.x; linkList(indexL).outletNode.x];
    y = [linkList(indexL).inletNode.y; linkList(indexL).outletNode.y];
   plot(x, y, 'Color', [0,0,1]);
end

axis equal;


title('Irrigation System');

