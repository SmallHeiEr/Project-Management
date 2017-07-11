//
//  BaseCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
