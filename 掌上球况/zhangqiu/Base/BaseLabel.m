//
//  BaseLabel.m
//  zhangqiu
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"normal" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"black" object:nil];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        
    }
    return self;
}

- (void)createSubviews
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
     NSString *back = [userD objectForKey:@"BackImage"];
    
    if (back.length == 0) {
        self.textColor = [UIColor whiteColor];
    }
    
    if ([@"black" isEqualToString:back]) {
        self.textColor = [UIColor whiteColor];
    }
    else {
        self.textColor = [UIColor blackColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];

    
    
}

- (void)blackAction
{
    self.textColor = [UIColor whiteColor];
}
- (void)normalAction
{
    self.textColor = [UIColor blackColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
