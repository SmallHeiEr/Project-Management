//
//  RotationView.h
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotationView : UIView
@property (nonatomic, retain)UICollectionView *rotationCV;
@property (nonatomic, retain)NSMutableArray *rotationArr;
- (void)createSubviews;
@property (nonatomic, copy) void (^goodBlock)(NSInteger);
@end
