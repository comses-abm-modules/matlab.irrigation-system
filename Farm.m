classdef Farm < handle
    
   properties 
       id
       withdrawal
       receipt
       wealth
       node
       channelMember
       x
       y
   end
   
   events
      %none at the moment
   end
   
   methods 
      function A = Farm(id, withdrawal, node, x, y, channelMember)
         A.id = id;
         A.withdrawal = withdrawal;
         A.node = node;
         A.x = x;
         A.y = y;
         A.wealth = 0;
         A.receipt = withdrawal;
         A.channelMember = channelMember;

      end % Farm 
      

   end % methods
end % classdef