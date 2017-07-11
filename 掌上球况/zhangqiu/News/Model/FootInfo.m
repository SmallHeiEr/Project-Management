//
//  FootInfo.m
//  zhangqiu
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FootInfo.h"

@implementation FootInfo
- (void)dealloc
{
    [_title release];
    [_content release];
    [_createtime release];
    [_pc_url release];
    [_thumbnail release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
