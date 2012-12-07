//
//  GAAlgorithm.h
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAVertex.h"

@interface GAAlgorithm : NSObject

@property(assign, nonatomic) GAVertex *initialVertex;

- (void)addVertex:(GAVertex *)vertex;
- (void)deleteVertex:(GAVertex *)vertex;
- (void)connectOriginVertex:(GAVertex *)originVertex withDestinationVertex:(GAVertex *)destinationVertex;
- (void)routeShortestPathFromOriginVertex:(GAVertex *)originVertex toDestinationVertex:(GAVertex *)destinationVertex;

@end
