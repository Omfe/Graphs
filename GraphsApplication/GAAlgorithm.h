//
//  GAAlgorithm.h
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAVertex.h"

@class GAAlgorithm;

@protocol GAAlgorithmDelegate

- (void)algorithm:(GAAlgorithm *)algorithm didPassThroughEdge:(GAEdge *)edge andFinished:(BOOL)finished;

@end


@interface GAAlgorithm : NSObject

@property (assign, nonatomic) id<GAAlgorithmDelegate> delegate;

- (void)routeShortestPathFromOriginVertex:(GAVertex *)originVertex toDestinationVertex:(GAVertex *)destinationVertex;

@end
