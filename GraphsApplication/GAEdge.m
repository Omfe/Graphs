//
//  GAEdge.m
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAEdge.h"

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

@end
