//
//  ObjectiveDijkstra.m
//  Dijkstra
//
//  Created by Michi on 23/04/2020.
//  Copyright © 2020 Michal Zelinka. All rights reserved.
//

#import "ObjectiveDijkstra+Private.h"

@implementation DJKNode

+ (instancetype)nodeWithID:(NSString *)ID
{
	return [[self alloc] initWithID:ID];
}

- (instancetype)initWithID:(NSString *)ID
{
	if (self = [super init])
	{
		_ID = ID;
		[self reset];
	}

	return self;
}

- (void)appendOutEdge:(DJKEdge *)edge
{
	NSMutableArray<DJKEdge *> *edges = [_outEdges mutableCopy];
	[edges addObject:edge];
	_outEdges = [edges copy];
}

- (void)reset
{
	_pathCost = NSIntegerMax;
	_parentNode = nil;
	_outEdges = @[ ];
}

- (NSString *)description
{
	return _ID;
}

@end

@implementation DJKEdge

+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
{
	return [[self alloc] initFromNode:fromNode toNode:toNode];
}

+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode cost:(NSInteger)cost
{
	return [[self alloc] initFromNode:fromNode toNode:toNode cost:cost];
}

+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
                        cost:(NSInteger)cost bidirectional:(BOOL)bidirectional
{
	return [[self alloc] initFromNode:fromNode toNode:toNode cost:cost bidirectional:bidirectional];
}

- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
{
	return [self initFromNode:fromNode toNode:toNode cost:1 bidirectional:YES];
}

- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode cost:(NSInteger)cost
{
	return [self initFromNode:fromNode toNode:toNode cost:cost bidirectional:YES];
}

- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
                        cost:(NSInteger)cost bidirectional:(BOOL)bidirectional
{
	if (self = [super init])
	{
		_fromNode = fromNode;
		_toNode = toNode;
		_cost = cost;
		_bidirectional = bidirectional;
	}

	return self;
}

- (instancetype)reversedEdge
{
	return [[DJKEdge alloc] initFromNode:_toNode toNode:_fromNode cost:_cost bidirectional:_bidirectional];
}

- (NSString *)description
{
	NSString *bi = (_bidirectional) ? @"<":@"";

	return [NSString stringWithFormat:@"%@ %@-(%zd)-> %@",
	        _fromNode.ID, bi, _cost, _toNode];
}

@end

@implementation DJKGraph

+ (instancetype)graphWithEdges:(NSArray<DJKEdge *> *)edges
{
	return [[self alloc] initWithEdges:edges];
}

- (instancetype)initWithEdges:(NSArray<DJKEdge *> *)edges
{
	if (self = [super init])
	{
		_edges = edges;
		_processingLock = [NSLock new];
		_processingLock.name = @"Graph processing lock";
	}

	return self;
}

- (void)resetElements
{
	for (DJKEdge *e in _edges)
	{
		[e.fromNode reset];
		[e.toNode reset];
	}
}

- (NSArray<DJKNode *> *)shortestPathFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
{
	if (fromNode == toNode) return @[ fromNode ];

	[_processingLock lock];

	for (DJKEdge *e in _edges)
	{
		[e.fromNode appendOutEdge:e];

		if (e.bidirectional)
			[e.toNode appendOutEdge:[e reversedEdge]];
	}

	fromNode.pathCost = 0;

	NSMutableArray<DJKNode *> *queue = [NSMutableArray arrayWithCapacity:32];
	[queue addObject:fromNode];

	while (queue.count > 0) {

		DJKNode *current = [queue firstObject];
		[queue removeObject:current];

		for (DJKEdge *e in current.outEdges)
		{
			DJKNode *dest = e.toNode;

			if ([current.ID isEqualToString:dest.ID])
				continue;

			if (dest.pathCost <= current.pathCost + e.cost)
				continue;

			dest.pathCost = current.pathCost + e.cost;
			dest.parentNode = current;

			[queue addObject:dest];
		}
	}

	DJKNode *top = toNode;
	NSMutableArray<DJKNode *> *path = [NSMutableArray arrayWithCapacity:32];

	while (top != nil) {
		[path insertObject:top atIndex:0];
		top = top.parentNode;
	}

	[self resetElements];

	[_processingLock unlock];

	if (path.count <= 1) return @[ ];

	return path;
}

@end
