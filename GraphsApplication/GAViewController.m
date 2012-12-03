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

@interface GAViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;

@property (strong, nonatomic) id objectHolder;

@end

@implementation GAViewController

- (void)viewDidLoad
{
    UITapGestureRecognizer *tapGestureRecognizer;
    
    [super viewDidLoad];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapWasTapped:)];
    [self.mapView addGestureRecognizer:tapGestureRecognizer];
}


#pragma mark - Action Methods
- (IBAction)modeValueChanged:(UISegmentedControl *)sender
{
    self.objectHolder = nil;
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
            [self deleteWasTapped:tapGestureRecognizer];
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
            } else if ([view isKindOfClass:[GAEdge class]]) {
                [[[UIAlertView alloc] initWithTitle:@"Overlapping!" message:@"There's an Edge in the way!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
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
    vertex.backgroundColor = [UIColor redColor];
    
    [self.mapView addSubview:vertex];
}

- (void)addEdgeWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    NSLog(@"EDGE");
}

- (void)dijkstraWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    NSLog(@"DIJSKTRA");
}

- (void)deleteWasTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
    NSLog(@"DELETE");
}

@end
