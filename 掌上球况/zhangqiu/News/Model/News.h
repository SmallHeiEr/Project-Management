//
//  News.h
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *imgsrc;
@property (nonatomic, copy)NSString *digest;
@property (nonatomic, copy)NSString *skipID;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *createtime;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *hasHead;
@property (nonatomic, retain)NSMutableArray *imgextra;
@property (nonatomic, copy)NSString *filename;
@end
