//
//  NewViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//





@interface NewViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)UIScrollView *scrollV;
@property (nonatomic, retain)UISegmentedControl *segC;
@property (nonatomic, retain)NSMutableArray *sportArr;
@property (nonatomic, retain)BaseTableView *sportTableV;
@property (nonatomic, retain)BaseTableView *footballTableV;
@property (nonatomic, retain)BaseTableView *NBATableV;
@property (nonatomic, retain)RotationView *sportRV;
@property (nonatomic, retain)RotationView *footballRV;
@property (nonatomic, retain)RotationView *NBARV;

@property (nonatomic, retain)NSMutableArray *footArr;
@property (nonatomic, retain)NSMutableArray *NBAArr;
@property (nonatomic, retain)LiuXSegmentView *liuView;
@property (nonatomic, assign) BOOL isUpState;
@property (nonatomic, assign)NSInteger sportPage;
@property (nonatomic, assign)NSInteger footPage;
@property (nonatomic, copy)NSString *footTime;
@property (nonatomic, assign)NSInteger NBAPage;
@property (nonatomic, copy)NSString *NBATime;
@end

@implementation NewViewController
- (void)dealloc
{
    [_scrollV release];
    [_segC release];
    [_sportArr release];
    [_sportTableV release];
    [_footballTableV release];
    [_NBATableV release];
    [_sportRV release];
    [_footballRV release];
    [_NBARV release];
    [_footArr release];
    [_NBAArr release];
    [_liuView release];
    [_footTime release];
    [_NBATime release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sportPage = 0;
    [self getDateSport];
    [[DataBaseHandle shareDataBase] openCB];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.footTime = [dateFormat stringFromDate:[NSDate date]];
    self.footPage = 0;
    [self getDateFoot];
    self.NBATime = [dateFormat stringFromDate:[NSDate date]];
    self.NBAPage = 0;
    [self getDateNBA];
    // Do any additional setup after loading the view.
    
    self.sportArr = [NSMutableArray array];
    self.footArr = [NSMutableArray array];
    self.NBAArr = [NSMutableArray array];

    self.navigationController.navigationBar.translucent = YES;
    
    self.liuView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, navigationAppHeight, myWidth , liuHeight) titles:@[@"体育", @"足球", @"篮球"] clickBlick:^(NSInteger index) {
        _scrollV.contentOffset = CGPointMake(myWidth * (index - 1), 0);
        
    }];
   
    _liuView.defaultIndex = 1;
    self.navigationItem.titleView = _liuView;
   self.automaticallyAdjustsScrollViewInsets = NO;
    
// 创建scrollView
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight - tabBarheight)];
    _scrollV.contentSize = CGSizeMake(myWidth * 3, myHeight  - tabBarheight);
    
    [self.view addSubview:_scrollV];
    //    翻页效果
    _scrollV.pagingEnabled = YES;
    //    水平滚动条是否存在
    _scrollV.showsHorizontalScrollIndicator = NO;
    //    第一页和最后一页的回弹效果
    _scrollV.bounces = NO;
    _scrollV.delegate = self;
    [_scrollV release];
    
#warning     sportTableView
    self.sportTableV = [[BaseTableView alloc]initWithFrame:CGRectMake(0, navigationAppHeight, myWidth, _scrollV.frame.size.height - navigationAppHeight) style:UITableViewStylePlain];
    _sportTableV.delegate = self;
    _sportTableV.dataSource = self;
    
    _sportTableV.rowHeight = newCellHeight;
    _sportTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_sportTableV registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"oneCell"];
     [_sportTableV registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"twoCell"];
    [_sportTableV registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    [_scrollV addSubview:_sportTableV];
    [_sportTableV release];

//体育界面
     //轮播图
    self.sportRV = [[RotationView alloc]initWithFrame:CGRectMake(0, 0, 0, rotationHeight)];
    _sportTableV.tableHeaderView = _sportRV;
    [_sportRV release];
    
    
//    block
    
    
    
//    self.sportRV.layer.masksToBounds = YES;
//    self.sportRV.layer.cornerRadius = 10;
#warning    footballTableView
    //    //足球界面
    self.footballTableV = [[BaseTableView alloc]initWithFrame:CGRectMake(myWidth, navigationAppHeight, myWidth, _scrollV.frame.size.height - navigationAppHeight) style:UITableViewStylePlain];
    _footballTableV.delegate = self;
    _footballTableV.dataSource = self;
    _footballTableV.rowHeight = newCellHeight;
    _footballTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_footballTableV registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"footCell"];
    
    [_scrollV addSubview:_footballTableV];
    [_footballTableV release];
    
//    //足球界面
//    //轮播图
    self.footballRV = [[RotationView alloc]initWithFrame:CGRectMake(0, 0, 0, rotationHeight)];
    _footballTableV.tableHeaderView = _footballRV;
    [_footballRV release];
    
   
    
    
    
    
    
#warning    NBAballTableView
    //    //NBA界面
    self.NBATableV = [[BaseTableView alloc]initWithFrame:CGRectMake(myWidth * 2, navigationAppHeight, myWidth, _scrollV.frame.size.height - navigationAppHeight) style:UITableViewStylePlain];
    _NBATableV.delegate = self;
    _NBATableV.dataSource = self;
    _NBATableV.rowHeight = newCellHeight;
    _NBATableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_NBATableV registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"NBACell"];
    
    [_scrollV addSubview:_NBATableV];
    [_NBATableV release];
    
    //    //NBA界面
    //    //轮播图
    self.NBARV = [[RotationView alloc]initWithFrame:CGRectMake(0, 0, 0, rotationHeight)];
    _NBATableV.tableHeaderView = _NBARV;
    [_NBARV release];

//缓存赋值
    NSMutableArray *arr = [[DataBaseHandle shareDataBase] selectCachAllNewsName:@"footHeadNews"];
    if (0 != arr.count ) {
            _footballRV.rotationArr =[[DataBaseHandle shareDataBase] selectCachAllNewsName:@"footHeadNews"];
            [_footballRV createSubviews];
            self.footArr = [[DataBaseHandle shareDataBase] selectCachAllNewsName:@"footNews"];
        
            _NBARV.rotationArr =[[DataBaseHandle shareDataBase] selectCachAllNewsName:@"NBAHeadNews"];
            [_footballRV createSubviews];
            self.NBAArr = [[DataBaseHandle shareDataBase] selectCachAllNewsName:@"NBANews"];
    }
    
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"souWhite.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];

    
    
}
- (void)leftAction
{
    SeachViewController *seach = [[SeachViewController alloc] init];
//    seach.isFav = YES;
//    seach.number = seach.number;
    [self presentViewController:seach animated:YES completion:^{
        
        
    }];
    //    [seach release];
}

- (void)getDateSport
{
#warning 请求数据
      //     轮播图（
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"NewPage" ofType:@"json"];
      NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *roArr = [NSMutableArray array];

    for (NSDictionary *dic in jsonArr) {
        NSString *url = dic[@"URL"];
        NSString *dickey = dic[@"dicKey"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    设置支持所有的接口类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];

        [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *smallArr = responseObject[dickey];
            for (NSDictionary *dic in smallArr) {
                News *new = [[News alloc]init];
                [new setValuesForKeysWithDictionary:dic];
//           取头视图加入数组组成轮播图
                    if ([dic.allKeys containsObject:@"hasHead"]) {
                        [roArr addObject:new];
                    }
            }
             //轮播图赋值
           
            self.sportRV.rotationArr = [NSMutableArray array];
            [_sportRV.rotationArr addObjectsFromArray:roArr];
            [_sportRV createSubviews];
            
//            Block回调
//            __block NewViewController *vc = self;
//            [_sportRV setGoodBlock:^(NSInteger index) {
//                
//                News *news = [_sportRV.rotationArr objectAtIndex:index];
//                SportInfoViewController *lunIVC = [[SportInfoViewController alloc]init];
//                
//                lunIVC.news = news;
//               
//                [vc.navigationController pushViewController:lunIVC animated:YES];
//                [lunIVC release];
//            }];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"失败");
        }];
    }
//    体育网址解析
   NSString *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348649079062/%ld-20.html", _sportPage];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    设置支持所有的接口类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (NO == _isUpState) {
            [_sportArr removeAllObjects];
        }
        NSArray *smallArr = responseObject[@"T1348649079062"];
        NSMutableArray *smallTableArr = [NSMutableArray array];
        for (NSDictionary *dic in smallArr) {
            News *new = [[News alloc]init];
            [new setValuesForKeysWithDictionary:dic];
                [smallTableArr addObject:new];
         }
        //tableView赋值
        [_sportArr addObjectsFromArray:smallTableArr];
        [_sportTableV reloadData];
        [_sportTableV headerEndRefreshing];
        [_sportTableV footerEndRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];

    
    
    
}
- (void)getDateFoot
{
//    足球界面网址
//    轮播图网址
    NSString *urlFootH = @"http://m.zhibo8.cc/json/news/zuqiu_top.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    设置支持所有的接口类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:urlFootH parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *footArr = [NSMutableArray array];
        NSMutableArray *arr = responseObject[@"toplist"];
        [[DataBaseHandle shareDataBase] openCB];
        [[DataBaseHandle shareDataBase] deleteCachTableName:@"footHeadNews"];
        [[DataBaseHandle shareDataBase] createCachTableNewsName:@"footHeadNews"];
        for (NSDictionary *dic in arr) {
            News *new = [[News alloc]init];
            [new setValuesForKeysWithDictionary:dic];
            [footArr addObject:new];
        }
       
        //轮播图赋值
        _footballRV.rotationArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            [[DataBaseHandle shareDataBase] insertCachNewsDataWithName:@"footHeadNews" News:[footArr objectAtIndex:i]];
            [_footballRV.rotationArr addObject:[footArr objectAtIndex:i]];
        }
         [[DataBaseHandle shareDataBase] closeCB];
        [_footballRV createSubviews];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@", error);
        
    }];
//      足球TableView网址
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long i=time;      //NSTimeInterval返回的是double类型
    
   
    NSString *urlFoot = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/news/zuqiu/%@.json?aabbccddeeff=%ld", _footTime, i];

    [manager GET:urlFoot parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (NO == _isUpState) {
            [_footArr removeAllObjects];
        }
        NSMutableArray *arr = responseObject[@"video_arr"];
        [[DataBaseHandle shareDataBase] openCB];
        [[DataBaseHandle shareDataBase] deleteCachTableName:@"footNews"];
        [[DataBaseHandle shareDataBase] createCachTableNewsName:@"footNews"];
        for (NSDictionary *dic in arr) {
            News *foot = [[News alloc]init];
            [foot setValuesForKeysWithDictionary:dic];
            [_footArr addObject:foot];
            [foot release];
            [[DataBaseHandle shareDataBase] insertCachNewsDataWithName:@"footNews" News:foot];
        }
        [[DataBaseHandle shareDataBase] closeCB];

        
        [_footballTableV reloadData];
        [_footballTableV headerEndRefreshing];
        [_footballTableV footerEndRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"失败%@", error);
    }];
}
- (void)getDateNBA
{
#warning NBA网络请求
    //    界面网址
    //    轮播图网址
    NSString *urlNBAH = @"http://m.zhibo8.cc/json/news/nba_top.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    设置支持所有的接口类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];

     [manager GET:urlNBAH parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *footArr = [NSMutableArray array];
        NSMutableArray *arr = responseObject[@"toplist"];
         [[DataBaseHandle shareDataBase] openCB];
         [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBAHeadNews"];
         [[DataBaseHandle shareDataBase] createCachTableNewsName:@"NBAHeadNews"];
        for (NSDictionary *dic in arr) {
            News *new = [[News alloc]init];
            [new setValuesForKeysWithDictionary:dic];
            [footArr addObject:new];
            
        }
         
        //轮播图赋值
        self.NBARV.rotationArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
             [[DataBaseHandle shareDataBase] insertCachNewsDataWithName:@"NBAHeadNews" News:[footArr objectAtIndex:i]];
            [_NBARV.rotationArr addObject:[footArr objectAtIndex:i]];
        }
         [[DataBaseHandle shareDataBase] closeCB];
        [_NBARV createSubviews];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@", error);
    }];
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long i=time;      //NSTimeInterval返回的是double类型
   
       NSString *urlNBA = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/news/nba/%@.json?aabbccddeeff=%ld", _NBATime, i];
    
    [manager GET:urlNBA parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (NO == _isUpState) {
            [_NBAArr removeAllObjects];
        }
       NSMutableArray *arr = responseObject[@"video_arr"];
        [[DataBaseHandle shareDataBase] openCB];
        [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBANews"];
        [[DataBaseHandle shareDataBase] createCachTableNewsName:@"NBANews"];
        for (NSDictionary *dic in arr) {
            News *foot = [[News alloc]init];
            [foot setValuesForKeysWithDictionary:dic];
           
            [_NBAArr addObject:foot];
            [foot release];
            [[DataBaseHandle shareDataBase] insertCachNewsDataWithName:@"NBANews" News:foot];
        }
        [[DataBaseHandle shareDataBase] closeCB];
        [_NBATableV reloadData];
        [_NBATableV headerEndRefreshing];
        [_NBATableV footerEndRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@", error);
    }];
}
- (void)createDataBaseHandleNews:(News *)news
{
    [[DataBaseHandle shareDataBase] openDB];
    [[DataBaseHandle shareDataBase] createTableNewsName:@"historyNews"];
    [[DataBaseHandle shareDataBase] insertNewsDataWithName:@"historyNews" News:news];
    [[DataBaseHandle shareDataBase] closeDB];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sportTableV == tableView) {
        SportInfoViewController *sportIVC = [[SportInfoViewController alloc]init];
        sportIVC.news = [_sportArr objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:sportIVC animated:YES];
     //        [sportIVC.tableView reloadData];
        [self createDataBaseHandleNews:[_sportArr objectAtIndex:indexPath.row]];
        [sportIVC release];
    }
    else if (_footballTableV == tableView){
        FootInfoViewController *footIVC = [[FootInfoViewController alloc] init];
        footIVC.news = [_footArr objectAtIndex:indexPath.row];
         [self.navigationController pushViewController:footIVC animated:YES];        [footIVC release];
    } else {
        NBAInfoViewController *NBAIVC = [[NBAInfoViewController alloc] init];
        NBAIVC.news = [_NBAArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:NBAIVC animated:YES];        [NBAIVC release];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sportTableV == tableView) {
        News *new = [_sportArr objectAtIndex:indexPath.row];
        if (0 != new.imgextra.count) {
            return newCellHeight + 30;
        }
    }
    return newCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_sportTableV == tableView) {
       
        return _sportArr.count;
    }
    else if (_footballTableV == tableView){
        return _footArr.count;
        
    } else {
        return _NBAArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sportTableV == tableView) {
       
        
          News *new = [_sportArr objectAtIndex:indexPath.row];
          if (3 == new.imgextra.count) {
              NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
              [cell getThreeTitle:new.title ImageL:[[new.imgextra objectAtIndex:0] objectForKey:@"imgsrc"] ImageC:[[new.imgextra objectAtIndex:1] objectForKey:@"imgsrc"] ImageR:[[new.imgextra objectAtIndex:2]objectForKey:@"imgsrc"]];
              return cell;

         } else if (2 == new.imgextra.count) {
              NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
              [cell getTwoTitle:new.title ImageL:[[new.imgextra objectAtIndex:0] objectForKey:@"imgsrc"]  ImageR:[[new.imgextra objectAtIndex:1] objectForKey:@"imgsrc"]];
              return cell;
         } else {
              NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
              [cell getLeftTitle:new.title Digest:new.digest Image:new.imgsrc];
              return cell;
         }
   }
    else if (_footballTableV == tableView) {
        NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
        News *foot = [[News alloc]init];
        foot = [_footArr objectAtIndex:indexPath.row];
        
        NSString *time = [BackgrountViewController intervalSinceNow:foot.createtime];
        if ([time isEqualToString:@"60分钟前"]) {
            [cell getLeftTitle:foot.title Digest:foot.createtime Image:foot.imgsrc];
                    } else {
                [cell getLeftTitle:foot.title Digest:[BackgrountViewController intervalSinceNow:foot.createtime] Image:foot.imgsrc];

        }
        return cell;
    } else {
        NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NBACell"];
        News *foot = [[News alloc]init];
        foot = [_NBAArr objectAtIndex:indexPath.row];
        

        NSString *time = [BackgrountViewController intervalSinceNow:foot.createtime];
        if ([time isEqualToString:@"60分钟前"]) {
            [cell getLeftTitle:foot.title Digest:foot.createtime Image:foot.imgsrc];
        } else {
            [cell getLeftTitle:foot.title Digest:[BackgrountViewController intervalSinceNow:foot.createtime] Image:foot.imgsrc];
        }
        return cell;
    }
}
//- (void)segAction:(UISegmentedControl *)sender
//{
//    self.scrollV.contentOffset = CGPointMake(myWidth * sender.selectedSegmentIndex, 0);
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollV == scrollView) {
        NSInteger currentPageIndex =  scrollView.contentOffset.x / scrollView.frame.size.width;
//        if (self.segC.selectedSegmentIndex != currentPageIndex) {
//            self.segC.selectedSegmentIndex = currentPageIndex;
//            
//        }
        if (_liuView.defaultIndex != currentPageIndex + 1) {
            _liuView.defaultIndex = currentPageIndex + 1;
        }
        //    [self.segC bringSubviewToFront:self.view];
    }
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//刷新加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self addHeader];
    [self addFooter];
    
}
- (void)addHeader {
    
    // 添加一个下拉刷新头部控件
    
    [_sportTableV addHeaderWithCallback:^{
        
        _isUpState = NO;
        
        [self getDateSport];
    }];
    // 添加一个下拉刷新头部控件
    
    [_footballTableV addHeaderWithCallback:^{
        
        _isUpState = NO;
        
        [self getDateFoot];
    }];
    // 添加一个下拉刷新头部控件
    
    [_NBATableV addHeaderWithCallback:^{
        
        _isUpState = NO;
        
        [self getDateNBA];
    }];
    
    
}
- (void)addFooter {
    
    // 添加一个上拉刷新头部控件
    [_sportTableV addFooterWithCallback:^{
        
        _isUpState = YES;
        _sportPage = _sportPage + 20;
        [self getDateSport];
        
    }];
    // 添加一个上拉刷新头部控件
    [_footballTableV addFooterWithCallback:^{
        
        _isUpState = YES;
        _footPage++;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _footPage)];

        _footTime = [dateFormat stringFromDate:yesterday];
        [self getDateFoot];
        
    }];
    // 添加一个上拉刷新头部控件
    [_NBATableV addFooterWithCallback:^{
        
        _isUpState = YES;
        _NBAPage++;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _NBAPage)];
        
        _NBATime = [dateFormat stringFromDate:yesterday];
        [self getDateNBA];
        
    }];
    
}
- (void)dataHandle {
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
