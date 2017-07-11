//
//  VideoInfo.m
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//


@implementation VideoInfo
- (void)dealloc
{
    [_url release];
    [_name release];
    [_img release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
