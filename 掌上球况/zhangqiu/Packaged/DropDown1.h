//
//  DropDown1.h
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDown1 : UIView<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    UIButton *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}

@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UIButton *textField;
@end
