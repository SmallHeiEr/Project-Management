//
//  ReportTableViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagView;
@class ReportInfo;

@interface ReportTableViewCell : UITableViewCell
@property (nonatomic, retain) TagView *tagView;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) ReportInfo *reportI;
- (void)getModel:(ReportInfo *)reporInfo;

//- (void)createSubViews;
@end
