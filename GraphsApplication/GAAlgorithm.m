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
    
    
    originVertex.permanentWeight = 0;
    for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
   //     neightborVertex.tempWeight = currentVertex.permanentWeight + distancia;
    }
    for (GAVertex *neightborVertex in currentVertex.neighborsArray) {
        //
    }
    
    
}

//1. Poner permanentWieght 0 al vértice inicial.
//2. Iterar al arreglo de vecinos.
//   1. Por cada vecino: el peso temporal del vecino es la suma de la distancia más el peso permanente del vértice actual.
//3. Iterar el arreglo de vecinos
//   1. El más pequeño se le asigna permanentWeight y locked = YES.
//   2. currentVertex = ese vecino.//
//4. Hacer paso 2 y 3 otra vez hasta que todos estén locked (se acaba el while(!finishedRouting)).

@end
