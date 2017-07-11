//
//  VideoTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//



#import "VideoTableViewCell.h"

@implementation VideoTableViewCell
- (void)dealloc
{
    
    [_imageV release];
    [_label1 release];
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
    self.imageV = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageV];
    _imageV.layer.masksToBounds = YES;
    _imageV.layer.cornerRadius = cornerR;
    [_imageV release];
    self.label1 = [[BaseLabel alloc]init];
    _label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont / 18 * 20];
    _label1.numberOfLines = 0;
    [self.contentView addSubview:_label1];
    [_label1 release];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageV.frame = CGRectMake(newsCellImageLeft, newsCellImageLeft * 3, self.frame.size.height - newsCellImageLeft * 2, self.frame.size.height - newsCellImageLeft * 6);
    _label1.frame = CGRectMake(self.frame.size.height + newsCellImageLeft * 2, newsCellImageLeft * 3, self.frame.size.width - self.frame.size.height - newsCellImageLeft * 4, self.frame.size.height - newsCellImageLeft * 4);
   }

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
