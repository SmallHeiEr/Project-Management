//
//  NewTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/23.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NewTableViewCell.h"

@implementation NewTableViewCell
- (void)dealloc
{
    [_imageVL release];
    [_imageVC release];
    [_imageVR release];
    [_label2 release];

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
    self.imageVL = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageVL];
        _imageVL.layer.masksToBounds = YES;
        _imageVL.layer.cornerRadius = cornerR;
    [_imageVL release];
    
    self.label1 = [[BaseLabel alloc]init];
    _label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont / 18 * 20];
    [self.contentView addSubview:_label1];
    _label1.textAlignment = NSTextAlignmentCenter;
    [_label1 release];
    
    self.label2 = [[BaseLabel alloc]init];
    [self.contentView addSubview:_label2];
    _label2.font = [UIFont systemFontOfSize:Videofont / 18 * 14];
    self.label2.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    _label2.numberOfLines = 0;
    [_label2 release];
    
    self.imageVC = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageVC];
    _imageVC.layer.masksToBounds = YES;
    _imageVC.layer.cornerRadius = cornerR;
    [_imageVC release];
    
    self.imageVR = [[UIImageView alloc]init];
    _imageVR.layer.masksToBounds = YES;
    _imageVR.layer.cornerRadius = cornerR;
    [self.contentView addSubview:_imageVR];
    [_imageVR release];
    
    
}
- (void)getLeftTitle:(NSString *)title Digest:(NSString *)digest Image:(NSString *)image
{
    _imageVL.frame = CGRectMake(newsCellImageLeft, newsCellImageLeft * 2, newCellHeight, newCellHeight - newsCellImageLeft * 4);
    _label1.frame = CGRectMake(newCellHeight + newsCellImageLeft + 3, newsCellImageLeft * 2, myWidth - newCellHeight - newsCellImageLeft * 3, newCellHeight / 4);
    _label2.frame = CGRectMake(newCellHeight + newsCellImageLeft + 6, newsCellImageLeft * 2 + _label1.frame.size.height + newsCellImageLeft, myWidth - newCellHeight - newsCellImageLeft * 6, newCellHeight / 4 * 2);
//    self.imageL.contentMode = UIViewContentModeScaleAspectFit;
     [_imageVL sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:backImage]];
    _label1.text = title;
    _label2.text = digest;
}
- (void)getTwoTitle:(NSString *)title ImageL:(NSString *)imageL ImageR:(NSString *)imageR
{
        _imageVL.frame = CGRectMake(newsCellImageLeft, (newCellHeight + newsCellImageLeft * 6) / 5 + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 3) / 2, (newCellHeight + newsCellImageLeft * 6) / 5 * 4 - newsCellImageLeft * 2);

        _imageVR.frame = CGRectMake(_imageVL.frame.origin.x + _imageVL.frame.size.width + newsCellImageLeft, (newCellHeight + newsCellImageLeft * 6) / 5 + newsCellImageLeft * 2, _imageVL.frame.size.width, _imageVL.frame.size.height);
        self.label1.frame = CGRectMake(newsCellImageLeft, newsCellImageLeft, myWidth - newsCellImageLeft * 2, (newCellHeight + newsCellImageLeft * 6) / 5 - newsCellImageLeft);
     [_imageVL sd_setImageWithURL:[NSURL URLWithString:imageL] placeholderImage:[UIImage imageNamed:backImage]];
    [_imageVR sd_setImageWithURL:[NSURL URLWithString:imageR] placeholderImage:[UIImage imageNamed:backImage]];
    _label1.text = title;
}

- (void)getThreeTitle:(NSString *)title ImageL:(NSString *)imageL ImageC:(NSString *)imageC ImageR:(NSString *)imageR
{
    _imageVL.frame = CGRectMake(newsCellImageLeft, (newCellHeight + newsCellImageLeft * 6) / 5 + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 3, (newCellHeight + newsCellImageLeft * 6) / 5 * 4 - newsCellImageLeft * 2);
    _imageVC.frame = CGRectMake(_imageVL.frame.origin.x + _imageVL.frame.size.width + newsCellImageLeft, (newCellHeight + newsCellImageLeft * 6) / 5 + newsCellImageLeft * 2, _imageVL.frame.size.width, _imageVL.frame.size.height);
    _imageVR.frame = CGRectMake(_imageVC.frame.origin.x + _imageVC.frame.size.width + newsCellImageLeft, (newCellHeight + newsCellImageLeft * 6) / 5 + newsCellImageLeft * 2, _imageVL.frame.size.width, _imageVL.frame.size.height);
    _label1.frame = CGRectMake(5, 5, myWidth - newsCellImageLeft * 2, (newCellHeight + newsCellImageLeft * 6) / 5 - newsCellImageLeft);
    [_imageVL sd_setImageWithURL:[NSURL URLWithString:imageL] placeholderImage:[UIImage imageNamed:backImage]];
     [_imageVC sd_setImageWithURL:[NSURL URLWithString:imageC] placeholderImage:[UIImage imageNamed:backImage]];
     [_imageVR sd_setImageWithURL:[NSURL URLWithString:imageR] placeholderImage:[UIImage imageNamed:backImage]];
    
    _label1.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
