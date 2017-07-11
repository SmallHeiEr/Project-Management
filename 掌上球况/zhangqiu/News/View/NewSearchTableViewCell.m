//
//  NewSearchTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NewSearchTableViewCell.h"

@implementation NewSearchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(sWidth * 10, sHeight * 10, myWidth - sWidth * 20, sHeight * 50)];
        self.titleL.numberOfLines = 0;
        [self addSubview:self.titleL];
        [_titleL release];
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(sWidth * 10, sHeight * 65, myWidth - sWidth * 20, sHeight * 25)];
        [self addSubview:self.timeL];
        [_timeL release];
        
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
