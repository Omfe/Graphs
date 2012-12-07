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
        _neighborsArray = [[NSMutableArray alloc] init];
        _locked = NO;
        _tempWeight = 0;
        _permanentWeight = 0;
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
            self.backgroundColor = [UIColor greenColor];
        }
    }
}

@end
