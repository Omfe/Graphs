//
//  GAVertex.m
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "GAVertex.h"

@implementation GAVertex

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        
        if (_selected) {
            self.backgroundColor = [UIColor redColor];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
