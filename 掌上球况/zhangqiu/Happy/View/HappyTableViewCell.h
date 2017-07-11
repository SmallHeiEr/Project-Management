//
//  HappyTableViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseTableViewCell.h"
@class AVPlayerView;
@class BaseButton;
@interface HappyTableViewCell : BaseTableViewCell
@property (nonatomic, retain) BaseLabel *label;
@property (nonatomic, retain) UIImageView *imageV;
@property (nonatomic, retain) BaseButton *buttonL;
@property (nonatomic, retain) BaseButton *buttonR;
@property (nonatomic, retain) AVPlayerView *playView;
@property (nonatomic, retain) UIImageView *imageT;
@property (nonatomic, retain) Happy *happy;

- (void)getImageHappy:(Happy *)happy;
- (void)getVideoHappy:(Happy *)happy;
- (void)getGifHappy:(Happy *)happy;
- (void)getTextHappy:(Happy *)happy;

@end
