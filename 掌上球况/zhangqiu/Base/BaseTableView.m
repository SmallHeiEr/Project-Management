//
//  BaseTableView.m
//  zhangqiu
//
//  Created by dllo on 16/4/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
