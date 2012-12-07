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

@end
