//
//  playViewController.h
//  zhangqiu
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface playViewController : UIViewController
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSNumber *width;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, retain) AVPlayerView *playView;
@end
