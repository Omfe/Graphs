//
//  GAViewController.m
//  GraphsApplication
//
//  Created by Omar Gudino on 11/29/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAViewController.h"

@interface GAViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;

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
    //Clear current state
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
    NSLog(@"VERTEX");
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
