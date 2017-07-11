//
//  BackImageCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BackImageCollectionViewCell.h"

@implementation BackImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    self.imageV = [[UIImageView alloc]init];
     _imageV.frame = CGRectMake(0, 0, sWidth * 150, sHeight * 200);
    self.imageV.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.imageV.layer.borderWidth = 2;
    [self.contentView addSubview:_imageV];
    [_imageV release];
    self.label = [[BaseLabel alloc]init];
    self.label.frame = CGRectMake(0, sHeight * 200, sWidth * 150, sHeight * 40);
    [self.contentView addSubview:self.label];
    [_label release];
    
    
    
    
    
    
}
@end
