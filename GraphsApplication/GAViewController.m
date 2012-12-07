//
//  GAViewController.m
//  GraphsApplication
//
//  Created by Omar Gudino on 11/29/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAViewController.h"
#import "GAVertex.h"
#import "GAEdge.h"
#import "GAAlgorithm.h"
#import "GAMapView.h"

@interface GAViewController () <GAAlgorithmDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet GAMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;

@property (strong, nonatomic) GAAlgorithm *algorithm;
@property (strong, nonatomic) NSMutableArray *vertexesArray;
@property (strong, nonatomic) GAVertex *vertexHolder;

@end

@implementation GAViewController

- (void)viewDidLoad
{
    UITapGestureRecognizer *tapGestureRecognizer;
    
    [super viewDidLoad];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapWasTapped:)];
    [self.mapView addGestureRecognizer:tapGestureRecognizer];
    
    self.vertexesArray = [[NSMutableArray alloc] init];
    self.algorithm = [[GAAlgorithm alloc] init];
    self.algorithm.delegate = self;
}


#pragma mark - GAAlgorithmDelegate Methods
- (void)algorithm:(GAAlgorithm *)algorithm didPassThroughEdge:(GAEdge *)edge andFinished:(BOOL)finished
{
    edge.selected = YES;
    if (finished) {
        [self.mapView setNeedsDisplay];
    }
}

- (GAEdge *)edgeBetweenOriginVertex:(GAVertex *)originVertex andDestinationVertex:(GAVertex *)destinationVertex
{
    for (GAEdge *edge in self.mapView.edgesArray) {
        if (edge.originVertex == originVertex && edge.destinationVertex == destinationVertex) {
            return edge;
        }
        if (edge.originVertex == destinationVertex && edge.destinationVertex == originVertex) {
            return edge;
        }
    }
    return nil;
}


#pragma mark - UIAlerViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: //"No"
            break;
        case 1: //"Yes"
            [self deleteVertexHolderFromMap];
            break;
        default:
            break;
    }
}


#pragma mark - Action Methods
- (IBAction)modeValueChanged:(UISegmentedControl *)sender
{
    for (GAVertex *vertex in self.vertexesArray) {
        vertex.selected = NO;
    }
    
    for (GAEdge *edge in self.mapView.edgesArray) {
        edge.selected = NO;
    }
    
    self.vertexHolder = nil;
    [self.mapView setNeedsDisplay];
}

- (void)mapWasTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    switch (self.modeSegmentedControl.selectedSegmentIndex) {
        case 0:
            [self addVertexWasTapped:tapGestureRecognizer];
            break;
        case 1:
            [self addEdgeWasTapped:tapGestureRecognizer];
            break;
        case 2:
            [self dijkstraWasTapped:tapGestureRecognizer];
            break;
        case 3:
            [self deleteVertexWasTapped:tapGestureRecognizer];
            break;
        case 4:
            [self deleteEdgeWasTapped:tapGestureRecognizer];
            break;
        default:
            break;
    }
}


#pragma mark - Private Methods
- (void)addVertexWasTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    GAVertex *vertex;
    NSArray *mapSubviews;
    CGPoint tapLocation;
    CGRect frame;
    CGRect intersectionFrame;
    
    tapLocation = [tapGestureRecognizer locationInView:self.mapView];
    frame = CGRectMake(tapLocation.x - 20, tapLocation.y - 20, 40, 40);
    
    mapSubviews = self.mapView.subviews;
    for (UIView *view in mapSubviews) {
        if (CGRectContainsPoint(view.frame, tapLocation)) {
            if ([view isKindOfClass:[GAVertex class]]) {
                [[[UIAlertView alloc] initWithTitle:@"Overlapping!" message:@"There's a Vertex there already!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                return;
            } else {
                // Something unknown :S
            }
        }
        
        intersectionFrame = CGRectIntersection(view.frame, frame);
        if (!CGRectIsEmpty(intersectionFrame)) {
            [[[UIAlertView alloc] initWithTitle:@"Too close!" message:@"The Vertex is too close to another object!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            return;
        }
    }

    vertex = [[GAVertex alloc] initWithFrame:frame];
    vertex.backgroundColor = [UIColor greenColor];
    
    [self.mapView addSubview:vertex];
    [self.vertexesArray addObject:vertex];
}

- (void)addEdgeWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    GAVertex *vertex;
    GAEdge *edge;
    CGPoint tapLocation;
    
    tapLocation = [tapGestureRecongnizer locationInView:self.mapView];
    vertex = [self vertexForPoint:tapLocation];
    
    if (!vertex) {
        return;
    }
    
    if (self.vertexHolder) {
        self.vertexHolder.selected = NO;
        
        if (self.vertexHolder == vertex) {
            self.vertexHolder = nil;
            return;
        }
        
        if ([self edgeBetweenOriginVertex:self.vertexHolder andDestinationVertex:vertex]) {
            self.vertexHolder = nil;
            return;
        }
        
        edge = [[GAEdge alloc] initWithFrame:CGRectZero];
        edge.backgroundColor = [UIColor greenColor];
        edge.originVertex = self.vertexHolder;
        edge.destinationVertex = vertex;
        [edge.originVertex.neighborsArray addObject:edge.destinationVertex];
        [edge.destinationVertex.neighborsArray addObject:edge.originVertex];
        [self.mapView.edgesArray addObject:edge];
        [self.mapView setNeedsDisplay];
        
        self.vertexHolder = nil;
        return;
    }
    
    vertex.selected = YES;
    self.vertexHolder = vertex;
}

- (void)dijkstraWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    GAVertex *vertex;
    CGPoint tapLocation;
    
    tapLocation = [tapGestureRecongnizer locationInView:self.mapView];
    vertex = [self vertexForPoint:tapLocation];
    
    if (!vertex) {
        return;
    }
    
    if (self.vertexHolder) {
        self.vertexHolder.selected = NO;
        
        if (self.vertexHolder == vertex) {
            self.vertexHolder = nil;
            return;
        }
        
        [self.algorithm routeShortestPathFromOriginVertex:self.vertexHolder toDestinationVertex:vertex];
        
        self.vertexHolder = nil;
        return;
    }
    
    vertex.selected = YES;
    self.vertexHolder = vertex;
}

- (void)deleteVertexWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    self.vertexHolder = [self vertexForPoint:[tapGestureRecongnizer locationInView:self.mapView]];
    [[[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Are you sure you want to delete this Vertex?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
}

- (void)deleteEdgeWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    // Delete after selecting two vertexes.
}

- (void)deleteVertexHolderFromMap
{
    GAVertex *vertex;
    GAEdge *edge;
    
    vertex = self.vertexHolder;
    
    if (vertex.neighborsArray.count != 0) {
        // Removing this vertex from all of its neighbor's "neighborsArray".
        for (GAVertex *neighborVertex in vertex.neighborsArray) {
            edge = [self edgeBetweenOriginVertex:vertex andDestinationVertex:neighborVertex];
            [self.mapView.edgesArray removeObject:edge];
            [neighborVertex.neighborsArray removeObject:vertex];
        }
    }
    
    [vertex removeFromSuperview];
    [self.vertexesArray removeObject:vertex];
    self.vertexHolder = nil;
    [self.mapView setNeedsDisplay];
}

- (GAVertex *)vertexForPoint:(CGPoint)point
{
    NSArray *mapSubviews;
    
    mapSubviews = self.mapView.subviews;
    for (UIView *view in mapSubviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            if ([view isKindOfClass:[GAVertex class]]) {
                return (GAVertex *)view;
            }
        }
    }
    return nil;
}

@end
