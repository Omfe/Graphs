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
@property (assign, nonatomic) BOOL locked;
@property (assign, nonatomic) CGFloat tempWeight;
@property (assign, nonatomic) CGFloat permanentWeight;
@property (strong, nonatomic) NSMutableArray *neighborsArray;

@end
