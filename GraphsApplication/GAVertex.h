//
//  GAVertex.h
//  GraphsApplication
//
//  Created by Omar Gudino on 12/2/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAVertex : UIView

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) NSMutableArray *neighborsArray;
@property (assign, nonatomic) NSInteger vertexID;
@property (assign, nonatomic) BOOL locked;
@property (assign, nonatomic) NSInteger tempWeight;
@property (assign, nonatomic) NSInteger permanentWeight;

@end
