//
//  NewSearch.m
//  zhangqiu
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NewSearch.h"

@implementation NewSearch
- (void)dealloc
{
    [_docid release];
    [_title release];
    [_ptime release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
