//
//  SeachViewController.m
//  zhangqiu
//
//  Created by dllo on 16/4/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SeachViewController.h"

@interface SeachViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, assign) BOOL isUpState;
@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(sWidth * 60, 20, myWidth - sWidth * 120, sHeight * 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 35, 50, 25);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.arr = [NSMutableArray array];
    
    self.searchBar.keyboardType = UIKeyboardAppearanceDefault;// 键盘风格
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.placeholder = @"请输入搜索关键字";
   
    self.searchBar.delegate = self;
    
//    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"coverImage.png"]];
    
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //搜索框风格 ----1
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;// 搜索框风格 ----2
    //self.searchBar.searchBarStyle = UISearchBarStyleMinimal;// 搜索框风格 ----3
    
    
    [self.view addSubview:self.searchBar];
    
    
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, myHeight, myWidth, myHeight - 100) style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 100;
    [self.tableV registerClass:[NewSearchTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    
    [_tableV release];
    
    //    UIView *hotView = [[UIView alloc] initWithFrame:CGRectMake(0, 100 * sHeight, bWidth, bHeight - 100)];
    //    [self.view addSubview:hotView];

}
- (void)buttonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;// 取消字体颜色
    [searchBar setShowsCancelButton:YES animated:YES];
    
    
    
    NSLog(@"🐻  开始编辑我就出来啦  顺便调用了tableview");
    
    // 这是改变取消字体的部分 默认为Cancel (不写也可以)
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            
            [cancel setTitle:@"确定" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    
}
// 结束调用的编辑方法
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"🐶");
}
// 输入的方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    NSString *string = [NSString stringWithFormat:@"%@", searchText];
    //  NSString *str = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //汉字转码
//    NSString *escapedString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
     NSString *baseString = [GTMBase64 encodeBase64String:searchText];
    self.key = baseString;
    NSLog(@"%@", self.key);
    if (self.key.length == 0) {
        [self.arr removeAllObjects];
        [UIView animateWithDuration:1 animations:^{
            self.tableV.frame = CGRectMake(0, myHeight, myWidth, myHeight - 100);
        }];
        [self.tableV reloadData];
        
    }
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"🐰  你一点确定我就出来啦");
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.isUpState = NO;
    [self postDate];
}
- (void)postDate
{
    NSString *strFirst = @"http://c.3g.163.com/search/comp/MA%3D%3D/20/";
    NSString *strLast = @"deviceId=ODYwNDYzMDIyNzQ5MTIw&version=bmV3c2NsaWVudC41LjYuMi5hbmRyb2lk&channel=VDEzNDg2NDc5MDkxMDc%3D";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@.html?%@", strFirst, _key, strLast];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    设置支持所有的接口类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *docDic = responseObject[@"doc"];
        for (NSDictionary *dic in [docDic objectForKey:@"result"]) {
            NewSearch *newS = [[NewSearch alloc] init];
            [newS setValuesForKeysWithDictionary:dic];
            [self.arr addObject:newS];
        }
        if (self.arr.count != 0) {
            [UIView animateWithDuration:1 animations:^{
                self.tableV.frame = CGRectMake(0, 100, myWidth, myHeight - 100);
                
            }];
            
        } else {
            [UIView animateWithDuration:1 animations:^{
                self.tableV.frame = CGRectMake(0, myHeight, myWidth, myHeight - 100);
            }];
        }
        [self.tableV reloadData];
        
        
        
        NSLog(@"111111111111%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];

}
// 键盘上的Search 响应的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"🐲  你一点键盘上的搜索我就出来啦");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;// 设置为NO 无法回收键盘
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewSearch *search = [self.arr objectAtIndex:indexPath.row];
//    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html", search.docid];
    searchInfoViewController *searchInfo = [[searchInfoViewController alloc] init];
    searchInfo.newSearch = search;
    [self presentViewController:searchInfo animated:YES completion:nil];
    [searchInfo release];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NewSearch *newS = [[NewSearch alloc] init];
    if (self.arr.count != 0) {
         newS =[self.arr objectAtIndex:indexPath.row];
    
//
//    cell.titleL.attributedText = [BackgrountViewController Html:newS.title];
    NSString *title = [BackgrountViewController Html:newS.title].string;
    NSMutableAttributedString *AttTitle =[[NSMutableAttributedString alloc] initWithString:title];
    NSRange range = [title rangeOfString:_key];
    [AttTitle setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:20]} range:range];
//        NSLog(@"%lf", range);
    cell.titleL.attributedText = AttTitle;
    cell.timeL.text = newS.ptime;
    }
    return cell;
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
