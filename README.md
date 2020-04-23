# Dijkstra

Example _Dijkstra_ algorithm (shortest path problem) implementation written in Objective-C.

## Usage

![Example usage](https://raw.githubusercontent.com/username0x0a/Dijkstra/master/example.png)

```swift
#import <Dijkstra/Dijkstra.h>

// Define the nodes

DJKNode *Brno      = [DJKNode nodeWithID:@"Brno"];
DJKNode *Praha     = [DJKNode nodeWithID:@"Praha"];
DJKNode *Ostrava   = [DJKNode nodeWithID:@"Ostrava"];
DJKNode *Pardubice = [DJKNode nodeWithID:@"Pardubice"];
DJKNode *Kolin     = [DJKNode nodeWithID:@"Kolin"];
DJKNode *Plzen     = [DJKNode nodeWithID:@"Plzen"];
DJKNode *Adamov    = [DJKNode nodeWithID:@"Adamov"];

// Define the graph edges

NSArray<DJKEdge *> *edges = @[
	[DJKEdge edgeFromNode:Ostrava   toNode:Brno    cost:180],
	[DJKEdge edgeFromNode:Praha     toNode:Ostrava cost:420],
	[DJKEdge edgeFromNode:Pardubice toNode:Brno    cost:110],
	[DJKEdge edgeFromNode:Pardubice toNode:Praha   cost:90],
	[DJKEdge edgeFromNode:Pardubice toNode:Plzen   cost:140],
	[DJKEdge edgeFromNode:Pardubice toNode:Ostrava cost:290],
	[DJKEdge edgeFromNode:Plzen     toNode:Praha   cost:70],
	[DJKEdge edgeFromNode:Adamov    toNode:Adamov  cost:0],
];

// Initialize the graph itself

DJKGraph *G = [DJKGraph graphWithEdges:edges];

// Look for shortest paths and print'em

NSLog(@"%@", [G shortestPathFromNode:Praha toNode:Ostrava]);
// [Praha, Pardubice, Ostrava]
NSLog(@"%@", [G shortestPathFromNode:Ostrava toNode:Plzen]);
// [Ostrava, Pardubice, Plzen]
NSLog(@"%@", [G shortestPathFromNode:Ostrava toNode:Ostrava]);
// [Ostrava]
NSLog(@"%@", [G shortestPathFromNode:Brno toNode:Kolin]);
// []
```

## License

Dijkstra example is released under the MIT license. See the LICENSE file for details.