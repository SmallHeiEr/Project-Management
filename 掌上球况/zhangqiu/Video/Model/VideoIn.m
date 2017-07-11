//
//  VideoIn.m
//  zhangqiu
//
//  Created by dllo on 16/4/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "VideoIn.h"

@implementation VideoIn
- (void)dealloc
{
    [_VideoArr release];
    [_channel release];
    [_content release];
    [_title release];
    [_createtime release];
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channel = [NSMutableArray array];
        self.VideoArr = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
