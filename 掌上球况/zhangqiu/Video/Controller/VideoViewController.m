//
//  VideoViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//


@interface VideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//@property (nonatomic, retain)UISegmentedControl *segC;
//@property (nonatomic, retain)UISegmentedControl *segN;

@property (nonatomic, retain)BaseCollectionView *mainCollectionView;

@property (nonatomic, copy)NSString *footHotTime;
@property (nonatomic, assign)NSInteger footHotPage;
@property (nonatomic, copy)NSString *footVideoTime;
@property (nonatomic, assign)NSInteger footVideoPage;
@property (nonatomic, retain) LiuXSegmentView *liuC;
@property (nonatomic, retain) LiuXSegmentView *liuN;

@property (nonatomic, copy)NSString *NBAHotTime;
@property (nonatomic, assign)NSInteger NBAHotPage;
@property (nonatomic, copy)NSString *NBAVideoTime;
@property (nonatomic, assign)NSInteger NBAVideoPage;
@property (nonatomic, retain)NSMutableDictionary *bigDic;
//@property (nonatomic, retain)NSMutableDictionary *infoDic;
@end

@implementation VideoViewController
- (void)dealloc
{
//    [_segC release];
//    [_segN release];
    [_mainCollectionView release];
    [_footHotTime release];
    [_footVideoTime release];
    [_NBAHotTime release];
    [_NBAVideoTime release];
    [_bigDic release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];

    self.footHotTime = [dateFormat stringFromDate:[NSDate date]];
    self.footHotPage = 0;
    self.footVideoTime = [dateFormat stringFromDate:[NSDate date]];
    self.footVideoPage = 0;

    self.NBAHotTime = [dateFormat stringFromDate:[NSDate date]];
    self.NBAHotPage = 0;
    self.NBAVideoTime = [dateFormat stringFromDate:[NSDate date]];
    self.NBAVideoPage = 0;
    self.bigDic = [NSMutableDictionary dictionary];
    
    [[DataBaseHandle shareDataBase] openCB];
    for (NSInteger i = 0 ; i < 6; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        arr = [[DataBaseHandle shareDataBase] selectCachAllVideoName:[NSString stringWithFormat:@"VideoHomePage%ld", i]];
        [self.bigDic setObject:arr forKey:[@(i) description]];
    }
    [[DataBaseHandle shareDataBase] closeCB];
    
    
    
    
    
    [self getDate];
//    self.infoDic = [NSMutableDictionary dictionary];
    self.liuC = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:@[@"推荐", @"热门", @"录像"] clickBlick:^(NSInteger index) {
         _mainCollectionView.contentOffset = CGPointMake(myWidth * (index - 1) + myWidth * 3 * (_liuN.defaultIndex - 1), 0);
        
    }];
    _liuC.defaultIndex = 1;
    [self.view addSubview:_liuC];
    [_liuC release];
    self.liuC.titleSelectColor = [UIColor colorWithRed:0.136 green:0.662 blue:1.000 alpha:1.000];

//    self.segC = [[UISegmentedControl alloc]initWithItems:@[@"推荐", @"热门", @"录像"]];
//    _segC.selectedSegmentIndex = 0;
//    _segC.frame = CGRectMake(0, 0, myWidth, liuHeight);
//    //    注意触发方式
//    [_segC addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:_segC];
//    [_segC release];

#warning 1 创建collectionView
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    
    layout.itemSize = CGSizeMake(myWidth, myHeight - navigationAppHeight -  liuHeight - tabBarheight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //间距为0
    layout.minimumLineSpacing = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainCollectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, liuHeight, myWidth, myHeight - navigationAppHeight - liuHeight - tabBarheight) collectionViewLayout:layout];
//    self.mainCollectionView.backgroundColor = [UIColor cyanColor];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    //    整页滚动
    _mainCollectionView.pagingEnabled = YES;
    
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView release];
    //    关闭边缘反弹
    _mainCollectionView.bounces = NO;
#warning 创建自定义cell
    [_mainCollectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"maincell"];
    
    
    self.liuN = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, navigationAppHeight) titles:@[@"篮球", @"足球"] clickBlick:^(NSInteger index) {
        
        _mainCollectionView.contentOffset = CGPointMake(myWidth * (index - 1) * 3 , 0);
        _liuC.defaultIndex = 1;
    }];
    self.liuN.defaultIndex = 1;
    self.navigationItem.titleView = _liuN;
    [_liuN release];
    self.liuN.titleSelectColor = [UIColor colorWithRed:0.000 green:0.890 blue:0.890 alpha:1.000];
//    self.segN = [[UISegmentedControl alloc]initWithItems:@[@"篮球", @"足球"]];
//    _segN.selectedSegmentIndex = 0;
////    self.segN.frame = CGRectMake(0, 64, myWidth, segCHeight);
//    //    注意触发方式
//    [_segN addTarget:self action:@selector(segNAction:) forControlEvents:UIControlEventValueChanged];
////    [self.view addSubview:self.segN];
//    self.navigationItem.titleView = _segN;
//    [_segN release];
    
}

- (void)getDate
{
 
#warning 4 请求数据
    //    当前日期和1970年距今秒数
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long T=time;      //NSTimeInterval返回的是double类型

        NSString *url = @"";
    for (NSInteger i = 0; i < 6; i++) {
       
        if(0 == i) {
            url = @"http://m.zhibo8.cc/json/video/recommend/nba/";
        } else if (1 == i) {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/nba/%@.json?aabbccddeeff=%ld",_NBAHotTime, T];
        } else if (2 == i) {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/luxiang/nba/%@.json?aabbccddeeff=%ld",_NBAVideoTime, T];
        } else if (3 == i) {
            url = @"http://m.zhibo8.cc/json/video/recommend/zuqiu/";
        } else if (4 == i) {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/zuqiu/%@.json?aabbccddeeff=%ld",_footHotTime, T];
        } else {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/luxiang/zuqiu/%@.json?aabbccddeeff=%ld",_footVideoTime, T];
        }
        AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
        [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
        
        
        [man GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            

            
            NSArray *smallArr = [NSArray array];
            if (1 == i || 2 == i || 4 == i || 5 == i) {
                 smallArr = responseObject[@"video_arr"];
            } else {
            smallArr = responseObject;
            }
            NSMutableArray *smallTableArr = [NSMutableArray array];
            
            for (NSInteger j = 0; j < smallArr.count; j++) {
                Video *video = [[Video alloc]init];
                [video setValuesForKeysWithDictionary:[smallArr objectAtIndex:j]];
                video.infoDic = [NSMutableDictionary dictionary];
#warning     //解析详细信息界面，获取图片
                NSString *urlInfo = @"";
                if (2 < i) {
                     urlInfo = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/zuqiu/2016/%@.json?aabbccddeeff=%ld", video.filename, T];
                } else {
                     urlInfo = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/nba/2016/%@.json?aabbccddeeff=%ld", video.filename, T];
                }
               
                [man GET:urlInfo parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSMutableArray *arr1 = responseObject[@"channel"];
                    video.image = [[arr1 firstObject] objectForKey:@"img"];
                    NSMutableArray *infoArr = [NSMutableArray array];
//                获取详细信息
                    for (NSDictionary *dic in arr1) {
                        VideoInfo *videoI = [[VideoInfo alloc] init];
                        [videoI setValuesForKeysWithDictionary:dic];
                        [infoArr addObject:videoI];
            }
//                    j代表cell的row序号，进详情页面传值时依据j将infoArr传入

                    [video.infoDic setObject:infoArr forKey:@"V"];
     
                 
                        [_mainCollectionView reloadData];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"停止" object:nil];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@", error);
                    
                }];
//            详细信息界面2
                if ([video.saishiid isEqualToString:@"0"]) {
                    
                } else {
//                    详细信息界面（上）
                    
                    NSString *urlIn = [NSString stringWithFormat:@"http://bifen.qiumibao.com/json/%@/%@.htm?abcde=%ld", [video.createtime substringToIndex:10], video.saishiid, T];
                    [man GET:urlIn parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        //                获取详细信息
                        NSMutableDictionary *dic = responseObject;
                        VideoI *vi = [[VideoI alloc]init];
                        [vi setValuesForKeysWithDictionary:dic];
                        [video.infoDic setObject:vi forKey:@"S"];
                        [vi release];
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"%@", error);
                        
                    }];

                    //详细信息界面（下）
                    NSString *urlI = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/match/%@.htm?abcde=%ld", video.saishiid, T];
                    [man GET:urlI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        //                获取详细信息
                        NSMutableDictionary *dic = responseObject;
                        VideoI *vi = [[VideoI alloc]init];
                        [vi setValuesForKeysWithDictionary:dic];
                        [video.infoDic setObject:vi forKey:@"U"];
                        [vi release];
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"%@", error);
                        
                    }];
                    
                    
                }

                
                
                
//            一个小数组里面放一个页面的URL请求回来的数据
                [smallTableArr addObject:video];
                
            }
            

            [_bigDic setObject:smallTableArr forKey:[@(i) description]];

    
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
}
- (void)getDateAddFoot
{
    
#warning 4 请求数据
    //    当前日期和1970年距今秒数
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long T=time;      //NSTimeInterval返回的是double类型
    
    NSString *url = @"";
            if (1 == _isUpState) {
        
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/nba/%@.json?aabbccddeeff=%ld",_NBAHotTime, T];
        } else if (2 == _isUpState) {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/luxiang/nba/%@.json?aabbccddeeff=%ld",_NBAVideoTime, T];
       
        } else if (4 == _isUpState) {
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/zuqiu/%@.json?aabbccddeeff=%ld",_footHotTime, T];
        } else if(5 == _isUpState){
            url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/luxiang/zuqiu/%@.json?aabbccddeeff=%ld",_footVideoTime, T];
        }
        AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
        [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
        
        
        [man GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
             NSArray *smallArr = [NSArray array];
            smallArr = responseObject[@"video_arr"];
            NSMutableArray *smallTableArr = [NSMutableArray array];
            
            for (NSInteger j = 0; j < smallArr.count; j++) {
                Video *video = [[Video alloc]init];
                [video setValuesForKeysWithDictionary:[smallArr objectAtIndex:j]];
//                video.infoDic = [NSMutableDictionary dictionary];
#warning     //解析详细信息界面，获取图片
                NSString *urlInfo = @"";
                if (2 < _isUpState) {
                    urlInfo = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/zuqiu/2016/%@.json?aabbccddeeff=%ld", video.filename, T];
                } else {
                    urlInfo = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json/nba/2016/%@.json?aabbccddeeff=%ld", video.filename, T];
                }
                
                [man GET:urlInfo parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSMutableArray *arr1 = responseObject[@"channel"];
                    video.image = [[arr1 firstObject] objectForKey:@"img"];
//                    NSMutableArray *infoArr = [NSMutableArray array];
                    //                获取详细信息
                    for (NSDictionary *dic in arr1) {
                        VideoInfo *videoI = [[VideoInfo alloc] init];
                        [videoI setValuesForKeysWithDictionary:dic];
                        [[video.infoDic objectForKey:@"V"] addObject:videoI];
                    }
                    //                    j代表cell的row序号，进详情页面传值时依据j将infoArr传入
                    
                    
                    
                    [_mainCollectionView footerEndRefreshing];
                    [_mainCollectionView reloadData];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@", error);
                    
                }];
                //            详细信息界面2
                if ([video.saishiid isEqualToString:@"0"]) {
                    
                } else {
                    //                    详细信息界面（上）
                    
                    NSString *urlIn = [NSString stringWithFormat:@"http://bifen.qiumibao.com/json/%@/%@.htm?abcde=%ld", [video.createtime substringToIndex:10], video.saishiid, T];
                    [man GET:urlIn parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        //                获取详细信息
                        NSMutableDictionary *dic = responseObject;
                        VideoI *vi = [[VideoI alloc]init];
                        [vi setValuesForKeysWithDictionary:dic];
//                        [video.infoDic setObject:vi forKey:@"S"];
                        [[video.infoDic objectForKey:@"S"] addObject:vi];
                        [vi release];
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"%@", error);
                        
                    }];
                    
                    //详细信息界面（下）
                    NSString *urlI = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/match/%@.htm?abcde=%ld", video.saishiid, T];
                    [man GET:urlI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        //                获取详细信息
                        NSMutableDictionary *dic = responseObject;
                        VideoI *vi = [[VideoI alloc]init];
                        [vi setValuesForKeysWithDictionary:dic];
                        [[video.infoDic objectForKey:@"U"] addObject:vi];
                        [vi release];
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"%@", error);
                        
                    }];
                    
                    
                }
                
                
                
                
                //            一个小数组里面放一个页面的URL请求回来的数据
                [smallTableArr addObject:video];
                
            }
            
            [[_bigDic objectForKey:[@(_isUpState) description]]addObject:smallTableArr];
            
//            [self.mainCollectionView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _bigDic.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell初始化的时候， 因为tableview创建的时候，签了代理人， 协议方法会走，但是这个时候tableview的数据源数组还没有传值过去
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"maincell" forIndexPath:indexPath];
   
    NSMutableArray *arr = [_bigDic objectForKey:[@(indexPath.item) description]];
    cell.collectionArr = arr;
    [[DataBaseHandle shareDataBase] openCB];
    [[DataBaseHandle shareDataBase] deleteCachTableName:[NSString stringWithFormat:@"VideoHomePage%ld", indexPath.row]];
    [[DataBaseHandle shareDataBase] createCachTableVideoName:[NSString stringWithFormat:@"VideoHomePage%ld", indexPath.row]];
    for (Video *video in arr) {
        [[DataBaseHandle shareDataBase] insertCachVideoDataWithName:[NSString stringWithFormat:@"VideoHomePage%ld", indexPath.row] video:video];
    }
    [[DataBaseHandle shareDataBase] closeCB];
    if (indexPath.item > 2) {
        cell.isZuQiu = YES;
    } else {
        cell.isZuQiu = NO;
    }
    
    
    if (1 == indexPath.item) {
        [cell.mainTableV addFooterWithCallback:^{
            
            _isUpState = 1;
            _NBAHotPage++;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _NBAHotPage)];
            _NBAHotTime = [dateFormat stringFromDate:yesterday];
            [self getDateAddFoot];
        }];
    } else if (2 == indexPath.item) {
        [cell.mainTableV addFooterWithCallback:^{
            
            _isUpState = 2;
            _NBAVideoPage++;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _NBAVideoPage)];
            _NBAVideoTime = [dateFormat stringFromDate:yesterday];
            [self getDateAddFoot];
        }];

    } else if (4 == indexPath.item) {
        [cell.mainTableV addFooterWithCallback:^{
            
            _isUpState = 4;
            _footHotPage++;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _footHotPage)];
            _footHotTime = [dateFormat stringFromDate:yesterday];
            [self getDateAddFoot];
        }];
        
    } else if (5 == indexPath.item) {
        [cell.mainTableV addFooterWithCallback:^{
            
            _isUpState = 5;
            _footVideoPage++;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:- (24 * 60 * 60  * _footVideoPage)];
            _footVideoTime = [dateFormat stringFromDate:yesterday];
            [self getDateAddFoot];
        }];
        
    }
    
    [cell.mainTableV reloadData];

    
    return cell;
    
}
- (void)segNAction:(UISegmentedControl *)sender
{
//    NSInteger currentPageIndex =  _mainCollectionView.contentOffset.x / myWidth;
    _mainCollectionView.contentOffset = CGPointMake(myWidth * (_liuN.defaultIndex - 1) * 3 , 0);
//    _segC.selectedSegmentIndex = 0;
    _liuC.defaultIndex = 1;
}
- (void)segAction:(UISegmentedControl *)sender
{
    _mainCollectionView.contentOffset = CGPointMake(myWidth * (_liuC.defaultIndex - 1) + myWidth * 3 * (_liuN.defaultIndex - 1), 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_mainCollectionView == scrollView) {
        NSInteger currentPageIndex =  scrollView.contentOffset.x / scrollView.frame.size.width;
        if (_liuC.defaultIndex - 1 != currentPageIndex) {
            _liuC.defaultIndex  = currentPageIndex % 3 + 1;
            _liuN.defaultIndex  = currentPageIndex / 3 + 1;
        }
        //    [self.segC bringSubviewToFront:self.view];
    }
    
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
