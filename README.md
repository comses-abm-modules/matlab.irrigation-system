PACKAGE NAME: Irrigation Flow

PLATFORM: MATLAB

AUTHOR: Andrew Bell

VERSION HISTORY: 1.0

### Description
A set of objects and routines to describe an irrigation system as a set of nodes, links, and farms; and solve water flow
and withdrawal through the system.  Water *flow* is solved by specifying water demand at nodes and withdrawing it, with
residual water allocated proportionally to all other outflow links based on their specified design flow.  Thus, this
simple model does not rely on physical solution (i.e., the St. Venant equations) to calculate flow rate or depth.

### Inputs
1. An irrigation system, described in terms of channel links and nodes
2. A volume of water appropriate to the time period

### Outputs
Water receipt at each node for the time period

### PACKAGE CONTENTS

1. runModel.m: An outer script to set up the model space and call the main time loop
2. setUpIrrigationSystem.m: A sample specification of an irrigation system (two watercourses off of a larger distributary) for testing purposes
3. main.m: The main time loop within which solveWater.m is called
4. visualizeSystem.m: A routine for visualizing the system state 
5. ChannelNode.m: An object class for the nodes in the system
6. ChannelLink.m: An object class for the links between nodes in the system
7. Farm.m: An object class for the farms withdrawing water from nodes in the system
8. nodeDistance.m: A utility to calculate distance between points
9. plotCircle.m: A utility called by visualizeSystem.m to plot circles

### INSTRUCTIONS

To test this package, copy all files to a folder and run runModel.m

### BENCHMARKS

Vary the level of input water supply, as well as the water demand of the farms, and observe that when supply is much greater than demand, all farms receive adequate water (appear as blue in the visualization) but as water supply decreases many downstream farms are water deficient (appear as black in the visualization).
