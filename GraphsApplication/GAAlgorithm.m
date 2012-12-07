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
    BOOL finishedRouting;
    GAVertex *currentVertex;
    GAVertex *nearestVertex;
    CGFloat distance;
    
    distance = 0;
    finishedRouting = NO;
    originVertex.permanentWeight = 0;
    currentVertex = originVertex;
    
    while (!finishedRouting) {
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            neightborVertex.tempWeight = currentVertex.permanentWeight + distance;
        }
        for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
            if (!nearestVertex) {
                nearestVertex = neightborVertex;
            }
            if (neightborVertex.tempWeight < nearestVertex.tempWeight) {
                nearestVertex = neightborVertex;
            }
            nearestVertex.permanentWeight = nearestVertex.tempWeight;
            nearestVertex.locked = YES;
        }
        nearestVertex = nil;
    }
}

//1. Poner permanentWieght 0 al vértice inicial.
//2. Iterar al arreglo de vecinos.
//   1. Por cada vecino: el peso temporal del vecino es la suma de la distancia más el peso permanente del vértice actual.
//3. Iterar el arreglo de vecinos
//   1. El más pequeño se le asigna permanentWeight y locked = YES.
//   2. currentVertex = ese vecino.//
//4. Hacer paso 2 y 3 otra vez hasta que todos estén locked (se acaba el while(!finishedRouting)).


- (GAEdge *)edgeBetweenOriginVertex:(GAVertex *)originVertex andDestinationVertex:(GAVertex *)destinationVertex
{
    GAEdge *edge;
    
    return edge;
}

@end
