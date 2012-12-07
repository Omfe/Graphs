//
//  GAAlgorithm.m
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAAlgorithm.h"
#import "GAVertex.h"
#import "GAEdge.h"

@interface GAAlgorithm()

@end

@implementation GAAlgorithm


#pragma mark - Public methods


- (void)routeShortestPathFromOriginVertex:(GAVertex *)originVertex toDestinationVertex:(GAVertex *)destinationVertex
{
    GAVertex *currentVertex;
    GAVertex *nearestVertex;
    GAVertex *vertexToGo;
    GAEdge *edge;
    CGFloat distance;
    
    originVertex.permanentWeight = 0;
    originVertex.locked = YES;
    currentVertex = originVertex;
    
    while (currentVertex) {
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            if (neightborVertex.locked) {
                continue;
            }
            edge = [self.delegate edgeBetweenOriginVertex:currentVertex andDestinationVertex:neightborVertex];
            distance = edge.distanceValue;
            neightborVertex.tempWeight = currentVertex.permanentWeight + distance;
            
            if (neightborVertex.tempWeight < neightborVertex.permanentWeight || neightborVertex.permanentWeight == 0) {
                neightborVertex.permanentWeight = neightborVertex.tempWeight;
            }
        }
        
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            if (neightborVertex.locked) {
                continue;
            }
            
            if (!nearestVertex) {
                nearestVertex = neightborVertex;
            }
            
            if (neightborVertex.tempWeight < nearestVertex.tempWeight) {
                nearestVertex = neightborVertex;
            }
            
            neightborVertex.visitedTimes++;
            if (neightborVertex.visitedTimes == neightborVertex.neighborsArray.count) {
                neightborVertex.locked = YES;
            }
        }
        
        currentVertex = nearestVertex;
        nearestVertex = nil;
    }
    
    currentVertex = destinationVertex;
    while (currentVertex) {
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            edge = [self.delegate edgeBetweenOriginVertex:currentVertex andDestinationVertex:neightborVertex];
            
            if (neightborVertex == originVertex) {
                [self.delegate algorithm:self didPassThroughEdge:edge andFinished:YES];
                return;
            }
            
            distance = edge.distanceValue;
            if (currentVertex.permanentWeight - distance == neightborVertex.permanentWeight) {
                vertexToGo = neightborVertex;
            }
        }
        
        edge = [self.delegate edgeBetweenOriginVertex:currentVertex andDestinationVertex:vertexToGo];
        [self.delegate algorithm:self didPassThroughEdge:edge andFinished:NO];
        currentVertex = vertexToGo;
        vertexToGo = nil;
    }
}



@end
