//
//  BackgrountViewController.h
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgrountViewController : UIViewController
+ (NSString *)intervalSinceNow: (NSString *) theDate;
+ (CGFloat)getHeightWithStr:(NSString *)str width:(CGFloat)width fontSize:(CGFloat)size;
+ (NSAttributedString *)Html:(NSString *)string;
+ (void)getAlertWithTitle:(NSString *)title message:(NSString *)massage buttonLeft:(NSString *)buttonL leftBlock:(void(^)(UIAlertAction * _Nonnull action))actL buttonRight:(NSString *)buttonR leftBlock:(void(^)(UIAlertAction * _Nonnull action))actR vc:(UIViewController *)vc time:(NSTimeInterval)time;
@end
