//
//  WebTableViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebTableViewCell : UITableViewCell
@property (nonatomic, retain)UIWebView *webView;
- (void)getWebHeight:(NSInteger)height url:(NSString *)url;

@end
