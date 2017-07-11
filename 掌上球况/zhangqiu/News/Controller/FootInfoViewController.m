//
//  FootInfoViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//


@interface FootInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (nonatomic, copy)NSString *time;
@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic, retain)UILabel *titleL;
@property (nonatomic, retain)UILabel *timel;
@property (nonatomic, retain)UIView *headView;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) FootInfo *foot;
@property (nonatomic, assign)CGFloat sizeHeight;

@end

@implementation FootInfoViewController
- (void)dealloc
{
    [_news release];
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
    [self.headView addSubview:self.titleL];
    [self.titleL release];
  
    self.timel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.titleL.frame.origin.y + self.titleL.frame.size.height + 5, myWidth - 20, newCellHeight * 3 / 10)];
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
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)]autorelease];
    
    
    
    
    
   
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, myWidth, 20)];
    self.webView.scrollView.scrollEnabled = NO;

    [self.webView release];
    self.webView.delegate = self;
    
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
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
    
     NSTimeInterval time=[[NSDate date] timeIntervalSince1970] * 1000;
     long i = time;
//     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//     [dateFormat setDateFormat:@"yyyy-MM-dd"];
//     self.time = [dateFormat stringFromDate:[NSDate date]];
    
    NSString *url = @"";
//    if (nil == self.news) {
//        self.time = [self.footInfo.createtime substringToIndex:10];
//        url =[NSString stringWithFormat:@"http://m.zhibo8.cc/news/android/json/zuqiu/%@/%@.json?aabbccddeeff=%ld", self.time, self.footInfo.filename, i];
//        
//    } else {
         self.time = [self.news.createtime substringToIndex:10];
        url =[NSString stringWithFormat:@"http://m.zhibo8.cc/news/android/json/zuqiu/%@/%@.json?aabbccddeeff=%ld", self.time, self.news.filename, i];
//    }
    
    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    
    [man GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        self.foot = [[FootInfo alloc]init];
        [self.foot setValuesForKeysWithDictionary:dic];
        [self.webView loadHTMLString:self.foot.content baseURL:nil];
//        self.webView.frame = CGRectMake(0, 0, myWidth, self.sizeHeight);
        
        
        self.titleL.text = self.foot.title;
        self.timel.text = self.foot.createtime;
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
    
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
