//
//  GAEdge.m
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAEdge.h"
#import "GAVertex.h"

@implementation GAEdge

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        
        if (_selected) {
            self.backgroundColor = [UIColor redColor];
        } else {
            self.backgroundColor = [UIColor greenColor];
        }
    }
}

- (CGFloat)distanceValue
{
    CGFloat dx;
    CGFloat dy;
    
    dx = self.destinationVertex.center.x - self.originVertex.center.x;
    dy = self.destinationVertex.center.y - self.originVertex.center.y;
    
    return sqrt(dx*dx + dy*dy);
}

- (CGPoint)middlePoint
{
    CGFloat dx;
    CGFloat dy;
    CGFloat x;
    CGFloat y;
    
    dx = (self.destinationVertex.center.x - self.originVertex.center.x) / 2;
    dy = (self.destinationVertex.center.y - self.originVertex.center.y) / 2;
    
    if (self.originVertex.center.x < self.destinationVertex.center.x) {
        x = self.originVertex.center.x + dx - 30;
    } else {
        x = self.destinationVertex.center.x + dx - 30;
    }
    
    if (self.originVertex.center.y < self.destinationVertex.center.y) {
        y = self.destinationVertex.center.y - dy;
    } else {
        y = self.originVertex.center.y + dy;
    }
    
    return CGPointMake(x, y);
}

@end
