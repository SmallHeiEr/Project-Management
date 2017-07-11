//
//  BaseTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
       
        [self createSubviews];

    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"normal" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"black" object:nil];
    [super dealloc];
}


- (void)createSubviews
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *back = [userD objectForKey:@"BackImage"];
    
    if (back.length == 0) {
         self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
    }
    
    if ([@"black" isEqualToString:back]) {
         self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
    }
    else {
       self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackImage.jpg"]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];
    
    
    
}

- (void)blackAction
{
    self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
}
- (void)normalAction
{
   self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackImage.jpg"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
