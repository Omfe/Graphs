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
    NSString *distanceValueString;
    CGRect stringRect;
    
    [super drawRect:rect];
    
    context = UIGraphicsGetCurrentContext();
    
    [[UIImage imageNamed:@"Map.png"] drawInRect:rect];
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    for (GAEdge *edge in self.edgesArray) {
        originPoint = edge.originVertex.center;
        destinationPoint = edge.destinationVertex.center;
        distanceValueString = [NSString stringWithFormat:@"%0.2f", edge.distanceValue];
        
        CGContextSetStrokeColorWithColor(context, edge.backgroundColor.CGColor);
        CGContextMoveToPoint(context, originPoint.x, originPoint.y);
        CGContextAddLineToPoint(context, destinationPoint.x, destinationPoint.y);
        
        CGContextStrokePath(context);
        
        stringRect = CGRectMake(edge.middlePoint.x, edge.middlePoint.y, 60, 60);
        [distanceValueString drawInRect:stringRect withFont:[UIFont boldSystemFontOfSize:14] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    }
}

@end
