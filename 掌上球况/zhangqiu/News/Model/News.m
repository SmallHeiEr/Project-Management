//
//  News.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "News.h"

@implementation News
- (void)dealloc
{
    [_type release];
    [_title release];
    [_imgsrc release];
    [_digest release];
    [_skipID release];
    [_url release];
    [_createtime release];
    [_filename release];
    [_imgextra release];
    [_hasHead release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"indextitle" isEqualToString:key]) {
        self.title = value;
    }
    if ([@"thumbnail" isEqualToString:key]) {
        self.imgsrc = value;
    }
    
}


@end
