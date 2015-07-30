function [farmList, nodeList, linkList, channelList] = setUpIrrigationSystem()

%this script initializes a simple irrigation system for testing purposes,
%with two watercourses running off a single distributary, each with 10
%equally spaced farms along them

%the farm objects created here are specific to a particular application
%of an irrigation system, in which farmers are making choices of what
%to plant based on reliability of water receipt

%For now, manually build a small network of two watercourses off a single
%distributary

nodeID = 0;
farmID = 0;
linkID = 0;

channelHierarchy(1).id = 1; channelHierarchy(1).parent = 0; channelHierarchy(1).order = 2;
channelHierarchy(2).id = 2; channelHierarchy(2).parent = 1; channelHierarchy(2).order = 3;
channelHierarchy(3).id = 3; channelHierarchy(3).parent = 1; channelHierarchy(3).order = 3;

%make the source and distributary nodes
nodeID = nodeID + 1;
nodeList(1) = ChannelNode(nodeID, 0, 0);

nodeID = nodeID + 1;
nodeList(end+1) = ChannelNode(nodeID, 2, 0);

linkID = linkID + 1;
linkList(1) = ChannelLink(linkID, channelHierarchy(1).id, nodeDistance(nodeList(1),nodeList(2)), .001, channelHierarchy(1).order, nodeList(1), nodeList(2));
nodeList(1).outletLinks = linkList(1);
nodeList(2).inletLinks = linkList(1);

channelList{1}(1) = linkList(1);

nodeID = nodeID + 1;
nodeList(end+1) = ChannelNode(nodeID, 4, 0);

linkID = linkID + 1;
linkList(end+1) = ChannelLink(linkID, channelHierarchy(1).id, nodeDistance(nodeList(2),nodeList(3)), .001, channelHierarchy(1).order, nodeList(2), nodeList(3));
nodeList(2).outletLinks = linkList(2);
nodeList(3).inletLinks = linkList(2);

channelList{1}(2) = linkList(2);

%now make the watercourse and farm nodes
for indexA = 1:10
    
    nodeID = nodeID + 1;
    farmID = farmID + 1;
    linkID = linkID + 1;
    xFarm = 1;
    xNode = 2;
    y = indexA;
    withdrawal = rand();

    currentNode = ChannelNode(nodeID, xNode, y);
     
    currentFarm = Farm(farmID, withdrawal, currentNode, xFarm, y, channelHierarchy([1 2]));
    
    if(indexA == 1)
        currentLink = ChannelLink(linkID, channelHierarchy(2).id, nodeDistance(nodeList(2),currentNode), .001, channelHierarchy(2).order, nodeList(2), currentNode);
        nodeList(end+1) = currentNode;
        farmList(indexA) = currentFarm;
        linkList(end+1) = currentLink;
        nodeList(end).inletLinks = linkList(end);
        nodeList(end).withdrawalFarms = currentFarm;
        nodeList(2).outletLinks(end+1) = linkList(end);
        channelList{2}(1) = currentLink;

    else
        currentLink = ChannelLink(linkID, channelHierarchy(2).id, nodeDistance(nodeList(end),currentNode), .001, channelHierarchy(2).order, nodeList(end), currentNode);        
        nodeList(end+1) = currentNode;
        farmList(indexA) = currentFarm;
        linkList(end+1) = currentLink;
        nodeList(end).inletLinks = linkList(end);
        nodeList(end).withdrawalFarms = currentFarm;
        nodeList(end-1).outletLinks = linkList(end);
        channelList{2}(end+1) = currentLink;
    end
    
end

%drain for this watercourse
nodeID = nodeID + 1;
linkID = linkID + 1;
xNode = 2;
y = indexA+1;

currentNode = ChannelNode(nodeID, xNode, y);
currentLink = ChannelLink(linkID, channelHierarchy(2).id, nodeDistance(nodeList(end),currentNode), .001, channelHierarchy(2).order, nodeList(end), currentNode);        
nodeList(end+1) = currentNode;
linkList(end+1) = currentLink;

for indexA = 1:10
    
    nodeID = nodeID + 1;
    farmID = farmID + 1;
    linkID = linkID + 1;
    xFarm = 3;
    xNode = 4;
    y = indexA;
    withdrawal = rand();


    currentNode = ChannelNode(nodeID, xNode, y);
     
    currentFarm = Farm(farmID, withdrawal, currentNode, xFarm, y, channelHierarchy([1 3]));
    
    if(indexA == 1)
        currentLink = ChannelLink(linkID, channelHierarchy(3).id, nodeDistance(nodeList(3),currentNode), .001, channelHierarchy(3).order, nodeList(3), currentNode);
        nodeList(end+1) = currentNode;
        farmList(end+1) = currentFarm;
        linkList(end+1) = currentLink;
        nodeList(end).inletLinks = linkList(end);
        nodeList(end).withdrawalFarms = currentFarm;
        nodeList(3).outletLinks = linkList(end);
        channelList{3}(1) = currentLink;
    else
        currentLink = ChannelLink(linkID, channelHierarchy(3).id, nodeDistance(nodeList(end),currentNode), .001, channelHierarchy(3).order, nodeList(end), currentNode);        
        nodeList(end+1) = currentNode;
        farmList(end+1) = currentFarm;
        linkList(end+1) = currentLink;
        nodeList(end).inletLinks = linkList(end);
        nodeList(end).withdrawalFarms = currentFarm;
        nodeList(end-1).outletLinks = linkList(end);
        channelList{2}(end+1) = currentLink;
    end
    
end

%drain for this watercourse
nodeID = nodeID + 1;
linkID = linkID + 1;
xNode = 4;
y = indexA+1;

currentNode = ChannelNode(nodeID, xNode, y);
currentLink = ChannelLink(linkID, channelHierarchy(3).id, nodeDistance(nodeList(end),currentNode), .001, channelHierarchy(3).order, nodeList(end), currentNode);        
nodeList(end+1) = currentNode;
linkList(end+1) = currentLink;

