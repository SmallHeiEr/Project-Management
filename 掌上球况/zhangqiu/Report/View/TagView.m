//
//  TagView.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "TagView.h"

@implementation TagView
- (void)dealloc
{
    [_order release];
    [_team release];
    [_win release];
    [_lost release];
    [_winning release];
    [_shengcha release];
    [_jinkuang release];
    [_integral release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
self.order = [[UILabel alloc] init];
    self.order.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_order];
[_order release];
self.team = [[UILabel alloc] init];
    _team.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_team];
[_team release];
self.win = [[UILabel alloc] init];
    _win.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_win];
[_win release];
self.lost = [[UILabel alloc] init];
    _lost.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_lost];
[_lost release];
self.winning = [[UILabel alloc] init];
    _winning.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_winning];
[_winning release];
self.shengcha = [[UILabel alloc] init];
    _shengcha.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_shengcha];
[_shengcha release];
self.jinkuang = [[UILabel alloc] init];
    _jinkuang.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
[self addSubview:_jinkuang];
[_jinkuang release];
    self.integral = [[UILabel alloc] init];
    _integral.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
    [self addSubview:_integral];
    [_integral release];
    
_order.textAlignment = NSTextAlignmentCenter;
_team.textAlignment = NSTextAlignmentCenter;
_win.textAlignment = NSTextAlignmentCenter;
_lost.textAlignment = NSTextAlignmentCenter;
_winning.textAlignment = NSTextAlignmentCenter;
_shengcha.textAlignment = NSTextAlignmentCenter;
_jinkuang.textAlignment = NSTextAlignmentCenter;
    _integral.textAlignment = NSTextAlignmentCenter;

   
    
}
- (void)getSeven
{
    _order.frame = CGRectMake(0, 0, myWidth / 12, reportTableRowH);
    _team.frame = CGRectMake(_order.frame.origin.x + _order.frame.size.width, 0, myWidth / 3, reportTableRowH);
    _win.frame = CGRectMake(_team.frame.origin.x + _team.frame.size.width, 0, myWidth / 12, reportTableRowH);
    _lost.frame = CGRectMake(_win.frame.origin.x + _win.frame.size.width, 0, myWidth / 8, reportTableRowH);
    _winning.frame = CGRectMake(_lost.frame.origin.x + _lost.frame.size.width, 0, myWidth / 8, reportTableRowH);
    _shengcha.frame = CGRectMake(_winning.frame.origin.x + _winning.frame.size.width, 0, myWidth / 8, reportTableRowH);
    _jinkuang.frame = CGRectMake(_shengcha.frame.origin.x + _shengcha.frame.size.width, 0, myWidth / 8, reportTableRowH);
}
- (void)getFive
{
    _order.frame = CGRectMake(0, 0, myWidth / 4, reportTableRowH);
    _team.frame = CGRectMake(_order.frame.origin.x + _order.frame.size.width, 0, myWidth / 16 * 2.5, reportTableRowH);
    _win.frame = CGRectMake(_team.frame.origin.x + _team.frame.size.width, 0, myWidth / 16 * 4, reportTableRowH);
    _lost.frame = CGRectMake(_win.frame.origin.x + _win.frame.size.width, 0, myWidth / 16 * 4, reportTableRowH);
    _winning.frame = CGRectMake(_lost.frame.origin.x + _lost.frame.size.width, 0, myWidth / 16 * 1.5, reportTableRowH);
   
}
- (void)getEight
{
    _order.frame = CGRectMake(0, 0, myWidth / 6, reportTableRowH);
    _team.frame = CGRectMake(_order.frame.origin.x + _order.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _win.frame = CGRectMake(_team.frame.origin.x + _team.frame.size.width, 0, myWidth / 12, reportTableRowH);
    _lost.frame = CGRectMake(_win.frame.origin.x + _win.frame.size.width, 0, myWidth / 12, reportTableRowH);
    _winning.frame = CGRectMake(_lost.frame.origin.x + _lost.frame.size.width, 0, myWidth / 12, reportTableRowH);
    _shengcha.frame = CGRectMake(_winning.frame.origin.x + _winning.frame.size.width, 0, myWidth / 12, reportTableRowH);
    _jinkuang.frame = CGRectMake(_shengcha.frame.origin.x + _shengcha.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _integral.frame = CGRectMake(_jinkuang.frame.origin.x + _jinkuang.frame.size.width, 0, myWidth / 6, reportTableRowH);
}
- (void)getSix
{
    _order.frame = CGRectMake(0, 0, myWidth / 6, reportTableRowH);
    _team.frame = CGRectMake(_order.frame.origin.x + _order.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _win.frame = CGRectMake(_team.frame.origin.x + _team.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _lost.frame = CGRectMake(_win.frame.origin.x + _win.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _winning.frame = CGRectMake(_lost.frame.origin.x + _lost.frame.size.width, 0, myWidth / 6, reportTableRowH);
    _shengcha.frame = CGRectMake(_winning.frame.origin.x + _winning.frame.size.width, 0, myWidth / 6, reportTableRowH);
}
- (void)getFour
{
    _order.frame = CGRectMake(0, 0, myWidth / 4, reportTableRowH);
    _team.frame = CGRectMake(_order.frame.origin.x + _order.frame.size.width, 0, myWidth / 4, reportTableRowH);
    _win.frame = CGRectMake(_team.frame.origin.x + _team.frame.size.width, 0, myWidth / 4, reportTableRowH);
    _lost.frame = CGRectMake(_win.frame.origin.x + _win.frame.size.width, 0, myWidth / 4, reportTableRowH);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
