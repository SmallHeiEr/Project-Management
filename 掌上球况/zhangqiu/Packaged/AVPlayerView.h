//
//  AVPlayerView.h
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVPlayerView : UIView
//@property (nonatomic, retain) NSString *urlStr;
- (void)createPlayerurl:(NSString *)urlStr;
- (void)createSubViews;
//- (void)getFrame;
@property (nonatomic, copy)NSString *urlStr;
- (void)pause;
- (void)start;
@end
