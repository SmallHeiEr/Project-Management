//
//  ReportTag.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReportTag.h"

@implementation ReportTag
- (void)dealloc
{
    [_name release];
    
    [_url release];
    [_type release];
    [_model release];
    [super dealloc];
}





- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
