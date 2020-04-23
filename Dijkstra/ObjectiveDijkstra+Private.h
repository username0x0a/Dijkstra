//
//  ObjectiveDijkstra+Private.h
//  Dijkstra
//
//  Created by Michi on 23/04/2020.
//  Copyright © 2020 Michal Zelinka. All rights reserved.
//

#import "ObjectiveDijkstra.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJKNode ()

@property (atomic) NSInteger pathCost;
@property (nonatomic, weak, nullable) DJKNode *parentNode;
@property (nonatomic, copy) NSArray<DJKEdge *> *outEdges;

@end

@interface DJKEdge ()

@property (nonatomic, strong) DJKNode *fromNode;
@property (nonatomic, strong) DJKNode *toNode;
@property (atomic) NSInteger cost;
@property (atomic) BOOL bidirectional;

@end

@interface DJKGraph ()

@property (nonatomic, strong) NSLock *processingLock;

@end

NS_ASSUME_NONNULL_END
