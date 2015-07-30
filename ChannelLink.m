classdef ChannelLink < handle
    
   properties 
       id
       channelID
       length
       designFlow
       maintenance
       depreciationRate
       level
       inletNode
       outletNode
       inletWater
       inletTime
   end
   
   events
      %none at the moment
   end
   
   methods 
      function A = ChannelLink(id, channelID, length, designFlow, level, inletNode, outletNode)
         A.id = id;
         A.channelID = channelID;
         A.length = length;
         A.designFlow = designFlow;
         A.level = level;
         A.inletNode = inletNode;
         A.outletNode = outletNode;
      end % Channel link 
      
      
   end % methods
end % classdef