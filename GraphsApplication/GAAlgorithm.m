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
    CGFloat distance;
    
    
    distance = 0;
    originVertex.permanentWeight = 0;
    currentVertex = originVertex;
    
    while (currentVertex) {
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            if (neightborVertex.locked) {
                continue;
            }
            neightborVertex.tempWeight = currentVertex.permanentWeight + distance;
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
            nearestVertex.permanentWeight = nearestVertex.tempWeight;
            nearestVertex.locked = YES;
        }
        currentVertex = nearestVertex;
        nearestVertex = nil;
    }
    
    currentVertex = destinationVertex;
    while (currentVertex) {
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            if (neightborVertex == originVertex) {
                //Highlight Path to origin vertex
                return;
            }
            if (currentVertex.permanentWeight - distance == neightborVertex.permanentWeight) {
                vertexToGo = neightborVertex;
            }
        }
        currentVertex = vertexToGo;
        vertexToGo = nil;
        //highligh path to current vertex
    }
}



@end
