//
//  BaseCollectionView.m
//  zhangqiu
//
//  Created by dllo on 16/4/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
