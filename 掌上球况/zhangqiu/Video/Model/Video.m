//
//  Video.m
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Video.h"

@implementation Video
- (void)dealloc
{
    [_title release];
    [_image release];
    [_infoDic release];
    [_type release];
    [_createtime release];
    [_url release];
    [_filename release];
    [_saishiid release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
