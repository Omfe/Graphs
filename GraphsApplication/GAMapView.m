//
//  GAMapView.m
//  GraphsApplication
//
//  Created by Rogelio Gudino on 12/6/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAMapView.h"
#import "GAEdge.h"
#import "GAVertex.h"

@implementation GAMapView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.edgesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context;
    CGPoint originPoint;
    CGPoint destinationPoint;
    
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"Map.png"] drawInRect:rect];
    
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    
    for (GAEdge *edge in self.edgesArray) {
        originPoint = edge.originVertex.center;
        destinationPoint = edge.destinationVertex.center;
        
        CGContextSetStrokeColorWithColor(context, edge.backgroundColor.CGColor);
        CGContextMoveToPoint(context, originPoint.x, originPoint.y);
        CGContextAddLineToPoint(context, destinationPoint.x, destinationPoint.y);
        
        CGContextStrokePath(context);
    }
}


@end
