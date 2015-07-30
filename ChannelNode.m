classdef ChannelNode < handle
    
   properties 
       id
       inletLinks
       outletLinks
       withdrawalFarms
       x
       y
   end
   
   events
      %none at the moment
   end
   
   methods 
      function A = ChannelNode(id, x, y)
          %(just the constructor)
         A.id = id;
         A.x = x;
         A.y = y;
      end % Channel Node 
      
     
      

   end % methods
end % classdef