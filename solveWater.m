function solveWater(inletConditions, indexT, nodeList)

    %this function solves water flow and withdrawal through the irrigation
    %system as a node tree.  it is initialized by solving the inlet node
    %and distributing water across all outlets of that node, and then
    %building a list of all nodes linked to this first node.  From there
    %the while loop will repeat this process for all nodes in this list,
    %adding new ones as they are encountered, and removing those that have
    %been completely solved
    
    %this algorithm allocates water at each node 1) first to farms,
    %proportionally based on allocation, and 2) second to other outward
    %links, proportionally based on design flow
    
    %seed the irrigation system with new inlet conditions
    currentNode = nodeList(1);
        
    %distribute inletConditions across all outlets of the first node
    totalOutletDesign = sum([currentNode.outletLinks.designFlow]);
    for indexO = 1:length(currentNode.outletLinks)
       currentOutletFlow = currentNode.outletLinks(indexO).designFlow / totalOutletDesign * inletConditions;
       currentNode.outletLinks(indexO).inletWater = currentOutletFlow;
       currentNode.outletLinks(indexO).inletTime = indexT;
    end
    
    %initialize a list of unsolved nodes with the nodes linked to the
    %first node
    openNodeList = [currentNode.outletLinks.outletNode];
    
    indexN = 1;
    
    %while the system is not totally solved
    while(~isempty(openNodeList))
        
        %if we have gone past the end of the list, return to the start
        if(length(openNodeList) < indexN)
            indexN = 1;
        end
        
        %pick the next node
        currentNode = openNodeList(indexN);
        
        %test whether all inlets to the current node have been solved
        allInletsSolved = sum([currentNode.inletLinks.inletTime] ~= indexT) == 0;
            
        if(allInletsSolved)
            %solve this node by allocating all withdrawals, and then
            %passing along outlet flows as appropriate to downstream links
            
            %calculate total water entering the node
            totalInletWater = sum([currentNode.inletLinks.inletWater]);
            
            totalWithdrawal = 0;
            
            %allocate water FIRST to farms, proportionally based on their
            %share of demand (but not allocating greater than their demand)
            if(~isempty(currentNode.withdrawalFarms))
                totalWithdrawalDemand = sum([currentNode.withdrawalFarms.withdrawal]);
                for indexF = 1:length(currentNode.withdrawalFarms)
                   currentWithdrawal = min(currentNode.withdrawalFarms(indexF).withdrawal / totalWithdrawalDemand * totalInletWater, currentNode.withdrawalFarms(indexF).withdrawal);
                   currentNode.withdrawalFarms(indexF).receipt = currentWithdrawal;
                   totalWithdrawal = totalWithdrawal + currentWithdrawal;
                end
                totalInletWater = totalInletWater - totalWithdrawal;
            end
            
            %allocate remaining water to outlet links, proportionally based
            %on their design flow
            totalOutletWater = 0;
            if(~isempty(currentNode.outletLinks))
                totalOutletDesign = sum([currentNode.outletLinks.designFlow]);
                for indexO = 1:length(currentNode.outletLinks)
                   currentOutletFlow = currentNode.outletLinks(indexO).designFlow / totalOutletDesign * totalInletWater;
                   currentNode.outletLinks(indexO).inletWater = currentOutletFlow;
                   currentNode.outletLinks(indexO).inletTime = indexT;
                   openNodeList(end+1) = currentNode.outletLinks(indexO).outletNode;
                   totalOutletWater = totalOutletWater + currentOutletFlow;
                end
                totalInletWater = totalInletWater - totalOutletWater;
            end
        
            %node is solved so pull it from the list
            openNodeList(indexN) = [];
        else
            %come back to it later when we've gone through all other nodes
            indexN = indexN + 1;
        end
    end %all nodes solved
    
    f = 1;
