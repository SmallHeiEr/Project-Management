//
//  TagView.h
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView
@property (nonatomic, retain)UILabel *order;
@property (nonatomic, retain)UILabel *team;
@property (nonatomic, retain)UILabel *win;
@property (nonatomic, retain)UILabel *lost;
@property (nonatomic, retain)UILabel *winning;
@property (nonatomic, retain)UILabel *shengcha;
@property (nonatomic, retain)UILabel *jinkuang;
@property (nonatomic, retain)UILabel *integral;
- (void)getSeven;
- (void)getFive;
- (void)getEight;
- (void)getSix;
- (void)getFour;
@end
