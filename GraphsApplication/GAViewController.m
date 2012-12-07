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

@interface GAViewController () <GAAlgorithmDelegate>

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
        
#warning CHECK IF AN EDGE EXISTS THEERE ALREADY!
        
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
    GAVertex *vertex;
    
    vertex = [self vertexForPoint:[tapGestureRecongnizer locationInView:self.mapView]];
    
    // if vertex had edge, delete it and also remove from neighbors
    
    [self.vertexesArray removeObject:vertex];
}

- (void)deleteEdgeWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    // Delete after selecting to vertexes.
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
