//
//  ReportTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReportTableViewCell.h"

@implementation ReportTableViewCell
- (void)dealloc
{
    [_tagView release];
    [_label release];
    [_reportI release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    self.tagView = [[TagView alloc]initWithFrame:CGRectMake(0, 0, myWidth, reportTableRowH)];
    [self.contentView addSubview:_tagView];
    [_tagView release];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, myWidth, reportTableRowH)];
    _label.font = [UIFont systemFontOfSize:Videofont];
    [self.contentView addSubview:_label];
    [_label release];
    _label.textAlignment = NSTextAlignmentCenter;
    
  
}

- (void)getModel:(ReportInfo *)reporInfo
{
    
    _tagView.order.text = reporInfo.order;
   _tagView.team.text = reporInfo.team;
    _tagView.win.text = reporInfo.win;
    _tagView.lost.text =reporInfo.lost;
    _tagView.winning.text = reporInfo.winning;
    _tagView.shengcha.text = reporInfo.shengcha;
    _tagView.jinkuang.text = reporInfo.jinkuang;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
