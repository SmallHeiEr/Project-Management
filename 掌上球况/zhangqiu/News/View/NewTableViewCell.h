//
//  NewTableViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseTableViewCell.h"
@class BaseLabel;
@interface NewTableViewCell : BaseTableViewCell
@property (nonatomic, retain)UIImageView *imageVL;
@property (nonatomic, retain)BaseLabel *label1;
@property (nonatomic, retain)BaseLabel *label2;
@property (nonatomic, retain)UIImageView *imageVC;
@property (nonatomic, retain)UIImageView *imageVR;
- (void)getLeftTitle:(NSString *)title Digest:(NSString *)digest Image:(NSString *)image;
- (void)getTwoTitle:(NSString *)title ImageL:(NSString *)imageL ImageR:(NSString *)imageR;
- (void)getThreeTitle:(NSString *)title ImageL:(NSString *)imageL ImageC:(NSString *)imageC ImageR:(NSString *)imageR;
@end
