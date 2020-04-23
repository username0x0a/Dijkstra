//
//  ObjectiveDijkstra.h
//  Dijkstra
//
//  Created by Michi on 23/04/2020.
//  Copyright © 2020 Michal Zelinka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJKNode : NSObject

@property (nonatomic, copy) NSString *ID;

+ (instancetype)new  UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithID:(NSString *)ID;
+ (instancetype)nodeWithID:(NSString *)ID;

@end

@interface DJKEdge : NSObject

+ (instancetype)new  UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode;             // Cost: 1, Bidirectional: YES
- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode cost:(NSInteger)cost; // Bidirectional: YES
- (instancetype)initFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
                        cost:(NSInteger)cost bidirectional:(BOOL)bidirectional;

+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode;
+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode cost:(NSInteger)cost;
+ (instancetype)edgeFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode
                        cost:(NSInteger)cost bidirectional:(BOOL)bidirectional;

@end

@interface DJKGraph : NSObject

@property (nonatomic, copy, readonly) NSArray<DJKEdge *> *edges;

+ (instancetype)new  UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithEdges:(NSArray<DJKEdge *> *)edges;
+ (instancetype)graphWithEdges:(NSArray<DJKEdge *> *)edges;

- (NSArray<DJKNode *> *)shortestPathFromNode:(DJKNode *)fromNode toNode:(DJKNode *)toNode;

@end

NS_ASSUME_NONNULL_END
