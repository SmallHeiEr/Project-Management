//
//  WebTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 dllo. All rights reserved.
//


@implementation WebTableViewCell
- (void)dealloc
{
    [_webView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.webView = [[UIWebView alloc]init];
         
       _webView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_webView];
        [_webView release];
        
    }
    return self;
}

- (void)getWebHeight:(NSInteger)height url:(NSString *)url
{
    _webView.frame = CGRectMake(10, 0, myWidth - 20, height);
    [_webView loadHTMLString:url baseURL:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
