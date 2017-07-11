//
//  FavoriteHappyTableViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVPlayerView;
@interface FavoriteHappyTableViewCell : UITableViewCell
@property (nonatomic, retain) BaseLabel *label;
@property (nonatomic, retain) UIImageView *imageV;

@property (nonatomic, retain) AVPlayerView *playView;
@property (nonatomic, retain) UIImageView *imageT;
@property (nonatomic, retain) Happy *happy;

- (void)getImageHappy:(Happy *)happy;
- (void)getVideoHappy:(Happy *)happy;
- (void)getGifHappy:(Happy *)happy;
- (void)getTextHappy:(Happy *)happy;
@end
