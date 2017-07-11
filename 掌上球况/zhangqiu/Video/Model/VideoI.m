//
//  VideoI.m
//  zhangqiu
//
//  Created by dllo on 16/3/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "VideoI.h"

@implementation VideoI
- (void)dealloc
{
    [_match_id release];
    [_title release];
    [_home_team release];
    [_visit_team release];
    [_home_logo release];
    [_visit_logo release];
    [_match_time release];
    [_zhibo_url release];
    [_zhanbao_url release];
    [_jijin_url release];
    [_luxiang_url release];
    [_home_score release];
    [_visit_score release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
