//
//  Happy.h
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Happy : NSObject
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *passtime;
@property (nonatomic, retain)NSMutableDictionary *video;
@property (nonatomic, retain)NSMutableDictionary *gif;
@property (nonatomic, retain)NSMutableDictionary *image;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy) NSString *share_url;


@property (nonatomic, copy)NSString *im;
@property (nonatomic, copy)NSString *vi;
@property (nonatomic, copy)NSString *height;
@property (nonatomic, copy)NSString *width;
@end
