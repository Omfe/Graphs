//
//  GAEdge.h
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAVertex;

@interface GAEdge : UIView

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) CGFloat distanceValue;
@property (strong, nonatomic) GAVertex *originVertex;
@property (strong, nonatomic) GAVertex *destinationVertex;

@end
