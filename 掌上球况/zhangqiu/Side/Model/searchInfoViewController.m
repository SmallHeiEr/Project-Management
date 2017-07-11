//
//  searchInfoViewController.m
//  zhangqiu
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "searchInfoViewController.h"

@interface searchInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (nonatomic, copy)NSString *time;
@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic, retain)UILabel *titleL;
@property (nonatomic, retain)UILabel *timel;
@property (nonatomic, retain)UIView *headView;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) FootInfo *foot;
@property (nonatomic, assign)CGFloat sizeHeight;

@end
@implementation searchInfoViewController

- (void)dealloc
{
    [_newSearch release];
    [_time release];
    [_webView release];
    [_titleL release];
    [_timel release];
    [_headView release];
    [_tableV release];
    [_foot release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    头视图
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, newCellHeight)];
    
    
    [self.headView release];
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, newCellHeight / 5, myWidth - 20, newCellHeight / 2)];
    self.titleL.attributedText =[BackgrountViewController Html:_newSearch.title];
    [self.headView addSubview:self.titleL];
    [self.titleL release];
    
    self.timel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.titleL.frame.origin.y + self.titleL.frame.size.height + 5, myWidth - 20, newCellHeight * 3 / 10)];
    self.timel.text = self.newSearch.ptime;
    [self.headView addSubview:self.timel];
    [self.timel release];
    [self getDate];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationAppHeight, myWidth, myHeight - navigationAppHeight) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    [self.tableV release];
    self.tableV.tableHeaderView = self.headView;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, myWidth, 20)];
    self.webView.scrollView.scrollEnabled = NO;
    


    [self.webView release];
    self.webView.delegate = self;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    //    [cell.webView loadHTMLString:self.foot.content baseURL:nil];
    //    [cell getWebHeight:self.sizeHeight url:self.foot.content];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning 问题一  怎么获取webView高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 0;
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    //    if (self.webView == webView) {
    //        self.sizeHeight = self.webView.scrollView.contentSize.height;
    //        [self.tableV reloadData];
    //        self.webView.frame.size.height = self.sizeHeight;
    //    }
    //    获取到webview的高度
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    self.webView.frame = CGRectMake(0,newCellHeight, myWidth, height);
    self.tableV.tableFooterView = self.webView;
    //    self.sizeHeight = height;
    //    [self.tableV reloadData];
    //    CGRect rect = webView.frame;
    //    rect.size.height = webView.scrollView.contentSize.height;
    //    webView.frame = rect;
    //    self.sizeHeight = rect.size.height;
    //     [self.tableV reloadData];
}

- (void)getDate
{
    
      NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.newSearch.docid];
   
    
    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    
    man.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
    [man GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
       bodyDic = [responseObject objectForKey:[NSString stringWithFormat:@"%@", self.newSearch.docid]];
        NSString *info = [bodyDic objectForKey:@"body"];
        [self.webView loadHTMLString:info baseURL:nil];

        
        
        
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
    
}
@end