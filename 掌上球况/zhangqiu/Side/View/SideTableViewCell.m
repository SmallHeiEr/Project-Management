//
//  SideTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 dllo. All rights reserved.
//


@implementation SideTableViewCell
- (void)dealloc
{
    [_imageV release];
    [_label release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, newsCellImageLeft * 2, sideButtonWidth, sideButtonWidth)];
        [self.contentView addSubview:_imageV];
        [_imageV release];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.size.width + newsCellImageLeft * 2, newsCellImageLeft * 2, newCellHeight, sideButtonWidth)];
        self.label.font = [UIFont systemFontOfSize:Videofont / 18 * 16];
        _label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_label];
        [_label release];
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
