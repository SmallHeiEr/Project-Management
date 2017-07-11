//
//  FavoriteHappyTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FavoriteHappyTableViewCell.h"

@implementation FavoriteHappyTableViewCell
- (void)dealloc
{
    [_label release];
    [_imageV release];
    [_playView release];
    [_imageT release];
    [_happy release];
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
    self.label = [[BaseLabel alloc] init];
    [self.contentView addSubview:_label];
    _label.font = [UIFont systemFontOfSize:Videofont];
    _label.numberOfLines = 0;
    [_label release];
    
    self.imageV = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageV];
    [_imageV release];
    
    self.imageT = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageT];
    _imageT.image = [UIImage imageNamed:@"iconfont-iconkaishi (1).png"];
    [_imageT release];
}

- (void)getImageHappy:(Happy *)happy
{
    //    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:cornerR]);
    NSNumber *height = [NSNumber numberWithInteger:[happy.height integerValue]];
    NSNumber *width = [NSNumber numberWithInteger:[happy.width integerValue]];
    _imageV.frame =CGRectMake(newsCellImageLeft * 2, _label.frame.origin.y + _label.frame.size.height, myWidth - newsCellImageLeft * 4, [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue]);
    
    //    赋值
    _label.text = happy.text;

    [_imageV sd_setImageWithURL:[NSURL URLWithString:happy.im] placeholderImage:[UIImage imageNamed:@"near.png"]];
}
- (void)getVideoHappy:(Happy *)happy
{
    //    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 5, newsCellImageLeft, myWidth - sideCellHeight, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - sideCellHeight) fontSize:cornerR]);
    
    NSNumber *height = [NSNumber numberWithInteger:[happy.height integerValue]];
    NSNumber *width = [NSNumber numberWithInteger:[happy.width integerValue]];
    _imageV.frame = CGRectMake(newsCellImageLeft * 4, _label.frame.origin.y + _label.frame.size.height, myWidth - sideImageWidth, [height doubleValue] * (myWidth - sideImageWidth) / [width doubleValue]);
    _imageT.frame = CGRectMake(myWidth / 2 - sideImageWidth / 2, _imageV.frame.origin.y + self.imageV.frame.size.height / 2 - sideImageWidth / 2, sideCellHeight, sideCellHeight);
    //    赋值
    _label.text = happy.text;

    [_imageV sd_setImageWithURL:[NSURL URLWithString:happy.im] placeholderImage:[UIImage imageNamed:@"near.png"]];
}
- (void)getGifHappy:(Happy *)happy
{
    //    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:cornerR]);
    NSNumber *height = [NSNumber numberWithInteger:[happy.height integerValue]];
    NSNumber *width = [NSNumber numberWithInteger:[happy.width integerValue]];
    _imageV.frame = CGRectMake(newsCellImageLeft * 2, _label.frame.origin.y + _label.frame.size.height, myWidth - newsCellImageLeft * 4, [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue]);
    //    赋值
    _label.text = happy.text;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:happy.im] placeholderImage:[UIImage imageNamed:@"near.png"]];
}
- (void)getTextHappy:(Happy *)happy
{
    //    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:cornerR]);
    //    赋值
    _label.text = happy.text;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
