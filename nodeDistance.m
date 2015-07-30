function distance = nodeDistance(node1, node2)

%calculate the euclidean distance between two nodes
distance = ((node1.x - node2.x)^2 + (node1.y - node2.y)^2)^0.5;