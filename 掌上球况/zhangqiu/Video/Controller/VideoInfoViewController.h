//
//  VideoInfoViewController.h
//  zhangqiu
//
//  Created by dllo on 16/3/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BackgrountViewController.h"

@interface VideoInfoViewController : BackgrountViewController
@property (nonatomic, retain) NSMutableDictionary *infoDic;
//@property (nonatomic, copy) NSString *titlee;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, assign) BOOL isZuQiu;
@end
