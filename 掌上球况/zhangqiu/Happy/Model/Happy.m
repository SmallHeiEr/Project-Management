//
//  Happy.m
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Happy.h"

@implementation Happy
- (void)dealloc
{
    [_share_url release];
    [_text release];
    [_passtime release];
    [_video release];
    [_gif release];
    [_image release];
    [_type release];
    [_vi release];
    [_im release];
    [_width release];
    [_height release];
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.video = [NSMutableDictionary dictionary];
        self.image = [NSMutableDictionary dictionary];
        self.gif = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
