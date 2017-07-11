//
//  BaseButton.m
//  zhangqiu
//
//  Created by dllo on 16/4/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton
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
        self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    
    if ([@"black" isEqualToString:back]) {
       
        self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

         self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackImage.jpg"]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];
    
    
    
}

- (void)blackAction
{
self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}
- (void)normalAction
{
     self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackImage.jpg"]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
