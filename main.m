function  main(timeSteps, nodeList, farmList, linkList, channelList)
%pointed to by runModel.m


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START TIME LOOP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for indexT = 1:timeSteps.total
    

    inletConditions = 10 * rand();
    solveWater(inletConditions, indexT, nodeList);
    
    visualizeSystem(timeSteps.cycle+1, farmList, nodeList, linkList, timeSteps);

end