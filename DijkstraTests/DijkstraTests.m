//
//  DijkstraTests.m
//  DijkstraTests
//
//  Created by Michi on 23/04/2020.
//  Copyright © 2020 Michal Zelinka. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Dijkstra/Dijkstra.h>

@interface DijkstraTests : XCTestCase

@end

@implementation DijkstraTests

- (void)test
{
	// Prepare weak Node handlers for later

	__weak DJKNode *weakBrno = nil;
	__weak DJKNode *weakPraha = nil;
	__weak DJKNode *weakOstrava = nil;
	__weak DJKNode *weakPardubice = nil;
	__weak DJKNode *weakKolin = nil;
	__weak DJKNode *weakPlzen = nil;
	__weak DJKNode *weakAdamov = nil;
	__weak DJKNode *weakPrcice = nil;

	@autoreleasepool {

		// Define the nodes

		DJKNode *Brno      = [DJKNode nodeWithID:@"Brno"];
		DJKNode *Praha     = [DJKNode nodeWithID:@"Praha"];
		DJKNode *Ostrava   = [DJKNode nodeWithID:@"Ostrava"];
		DJKNode *Pardubice = [DJKNode nodeWithID:@"Pardubice"];
		DJKNode *Kolin     = [DJKNode nodeWithID:@"Kolin"];
		DJKNode *Plzen     = [DJKNode nodeWithID:@"Plzen"];
		DJKNode *Adamov    = [DJKNode nodeWithID:@"Adamov"];

		DJKNode *Prcice      = [DJKNode nodeWithID:@"Prcice"];
		DJKEdge *doPrcicEdge = [DJKEdge edgeFromNode:Prcice toNode:Prcice];
		[Prcice setValue:@[ doPrcicEdge ] forKey:@"_outEdges"];

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

		// Define some stuff...

		NSArray<DJKNode *> *result = nil;
		NSArray<DJKNode *> *expectation = nil;

		#define joinedArr(x)     ([x componentsJoinedByString:@", "])
		#define printArr(x, y)   NSLog(@"\n\t[%@] == [%@]", joinedArr(x), joinedArr(y))
		#define EQ(x, y)         ([x isEqual:y])

		// Look for shortest paths and print'em

		result = [G shortestPathFromNode:Praha toNode:Ostrava];
		expectation = @[Praha, Pardubice, Ostrava];
		XCTAssert(EQ(result, expectation));
		printArr(result, expectation);

		result = [G shortestPathFromNode:Ostrava toNode:Plzen];
		expectation = @[Ostrava, Pardubice, Plzen];
		XCTAssert(EQ(result, expectation));
		printArr(result, expectation);

		result = [G shortestPathFromNode:Ostrava toNode:Ostrava];
		expectation = @[Ostrava];
		XCTAssert(EQ(result, expectation));
		printArr(result, expectation);

		result = [G shortestPathFromNode:Brno toNode:Kolin];
		expectation = @[];
		XCTAssert(EQ(result, expectation));
		printArr(result, expectation);

		weakBrno      = Brno;      Brno      = nil;
		weakPraha     = Praha;     Praha     = nil;
		weakOstrava   = Ostrava;   Ostrava   = nil;
		weakPardubice = Pardubice; Pardubice = nil;
		weakKolin     = Kolin;     Kolin     = nil;
		weakPlzen     = Plzen;     Plzen     = nil;
		weakAdamov    = Adamov;    Adamov    = nil;
		weakPrcice    = Prcice;    Prcice    = nil;
	}

	// Test Node addresses for dealloc failures

	XCTAssert(weakBrno      == nil);
	XCTAssert(weakPraha     == nil);
	XCTAssert(weakOstrava   == nil);
	XCTAssert(weakPardubice == nil);
	XCTAssert(weakKolin     == nil);
	XCTAssert(weakPlzen     == nil);
	XCTAssert(weakAdamov    == nil);

	XCTAssert(weakPrcice    != nil);
	[weakPrcice setValue:nil forKey:@"_outEdges"];
	XCTAssert(weakPrcice    == nil);

	// Done

	NSLog(@"Finished!");
}

@end
