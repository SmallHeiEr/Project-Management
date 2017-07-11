//
//  RotaCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RotaCollectionViewCell.h"

@implementation RotaCollectionViewCell
- (void)dealloc
{
    [_imageV release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    self.imageV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageV];
    [self.imageV release];
}
- (void)layoutSubviews
{
    self.imageV.frame = self.frame;
}
@end
