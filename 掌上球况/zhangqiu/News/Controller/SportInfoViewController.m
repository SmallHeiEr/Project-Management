//
//  SportInfoViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SportInfoViewController.h"
#import <WebKit/WebKit.h>
@interface SportInfoViewController ()
@end

@implementation SportInfoViewController
- (void)dealloc
{
    [_news release];
    [super dealloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.news.url]]];
    [self.view addSubview:webView];
//    头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, navigationAppHeight)];
    [webView addSubview:headView];
    [headView release];
  webView.scrollView.bounces = NO;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)]autorelease];

}
- (void)rightAction
{
    [[DataBaseHandle shareDataBase] openDB];
    
    NSMutableArray *arr = [NSMutableArray array];
    arr = [[DataBaseHandle shareDataBase] selectNewsName:@"favoriteNews" Title:self.news.title];
    if (0 == arr.count) {
        [[DataBaseHandle shareDataBase] createTableNewsName:@"favoriteNews"];
        [[DataBaseHandle shareDataBase] insertNewsDataWithName:@"favoriteNews" News:self.news];
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"请到我的收藏查看" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:alert2];
        [self presentViewController:alert1 animated:YES completion:nil];
    } else {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"已收藏" message:@"请不要重复收藏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:alert2];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
    [[DataBaseHandle shareDataBase] closeDB];
}
- (void)leftButtonAction
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
