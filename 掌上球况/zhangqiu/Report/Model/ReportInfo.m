//
//  ReportInfo.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReportInfo.h"

@implementation ReportInfo
- (void)dealloc
{
//    [ release];
    [_order release];
    [_team release];
    [_win release];
    [_lost release];
    [_winning release];
    [_shengcha release];
    [_jinkuang release];
    [super dealloc];
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
