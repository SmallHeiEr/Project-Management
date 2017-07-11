//
//  Video.h
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *createtime;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *filename;
@property (nonatomic, copy)NSString *saishiid;
@property (nonatomic, retain)NSString *image;
@property (nonatomic, retain)NSMutableDictionary *infoDic;
@end
