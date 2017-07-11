//
//  ReportViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/26.
//  Copyright © 2016年 dllo. All rights reserved.
//
#import "ReportViewController.h"

@interface ReportViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) LiuXSegmentView *liuHView;
@property (nonatomic, retain) BaseCollectionView *mainCollectionView;
@property (nonatomic, retain) NSMutableDictionary *dicName;
@property (nonatomic, copy) NSString *urlInfo;
@property (nonatomic, retain) NSArray *headArr;
@property (nonatomic, retain) NSMutableDictionary *reportDic;

@property (nonatomic, retain) NSMutableArray *footItemArr;

@property (nonatomic, copy) NSString *reportURL;
@end

@implementation ReportViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReportURL" object:nil];
    [_liuHView release];
    [_mainCollectionView release];
    [_dicName release];
    [_urlInfo release];
    [_headArr release];
    [_reportDic release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReportURLAction:) name:@"ReportURL" object:nil];
    
    
    [self getDate];
    _reportURL = @"http://data.zhibo8yx.com/match/xijia.htm";
    [self getDateNBA];
    
    self.dicName = [NSMutableDictionary dictionary];
    self.reportDic = [NSMutableDictionary dictionary];
//    self.headArr = [NSArray arrayWithObjects:@"NBA", @"中超", @"英超", @"西甲", @"意甲", @"德甲", @"欧冠", @"亚冠", @"欧联杯", @"法甲", @"世亚预", @"中甲", @"中乙", @"CBA", @"欧洲杯", nil];
    
    
    self.navigationItem.title = @"实时数据";
    
    self.headArr = [NSArray arrayWithObjects:@"NBA", @"中超", @"英超", @"西甲", @"意甲", @"德甲", @"法甲", nil];
    self.liuHView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, liuHeight + newsCellImageLeft * 2) titles:_headArr clickBlick:^(NSInteger index) {
        _mainCollectionView.contentOffset = CGPointMake(myWidth * (index - 1), 0);
        
    }];
    _liuHView.defaultIndex = 4;
    [self.view addSubview:_liuHView];
    [_liuHView release];
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init]autorelease];
    layout.itemSize = CGSizeMake(myWidth, myHeight - (liuHeight + navigationAppHeight + newsCellImageLeft * 2) - tabBarheight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.mainCollectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, liuHeight + newsCellImageLeft * 2, myWidth, myHeight - (liuHeight + navigationAppHeight + newsCellImageLeft * 2) - tabBarheight) collectionViewLayout:layout];
    //    self.mainCollectionView.backgroundColor = [UIColor cyanColor];
    _mainCollectionView.delegate = self;
   _mainCollectionView.dataSource = self;
    //    整页滚动
    _mainCollectionView.contentOffset = CGPointMake(myWidth * 3, 0);
    _mainCollectionView.pagingEnabled = YES;
    
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView release];
    //    关闭边缘反弹
    _mainCollectionView.bounces = NO;

    [_mainCollectionView registerClass:[ReportCollectionViewCell class] forCellWithReuseIdentifier:@"maincell"];
    
    for (NSInteger i = 1; i < 7; i++) {
        [_mainCollectionView registerClass:[FootReportCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"Footmaincell%ld", i]];
    }
    
    
    
    
    
    
}
- (void)ReportURLAction:(NSNotification *)sender
{
    
    self.reportURL = sender.userInfo[@"URL"];
    [self getDateNBA];
    NSLog(@"傻蛋%@", self.reportURL);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_mainCollectionView == scrollView) {
        NSInteger currentPageIndex =  scrollView.contentOffset.x / myWidth;
        NSInteger current = (NSInteger)scrollView.contentOffset.x % (NSInteger)myWidth;
        if (_liuHView.defaultIndex != currentPageIndex + 1 && current == 0) {
            _liuHView.defaultIndex = currentPageIndex + 1;
            ReportTag *report = [[self.dicName objectForKey:[_headArr objectAtIndex:(_liuHView.defaultIndex - 1)]] firstObject];
            self.reportURL = report.url;
            NSLog(@"网址是%@", self.reportURL);
            [self getDateNBA];
        }
    }
}
- (void)getDate
{
    NSString *urlStr = @"http://m.zhibo8.cc/json/paihang/api/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *resArr = responseObject[@"league"];
        
        for (NSDictionary *dic in resArr) {
            NSMutableArray *arrList = [NSMutableArray array];
            for (NSDictionary *dicTag in dic[@"list"]) {
                ReportTag *report = [[ReportTag alloc] init];
                [report setValuesForKeysWithDictionary:dicTag];
                [arrList addObject:report];
                [report release];
            }
            [_dicName setObject:arrList forKey:[dic objectForKey:@"name"]];
        }
        [_mainCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@", error);
        
    }];
    
}
- (void)getDateNBA
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long i=time;      //NSTimeInterval返回的是double类型
    NSString *urlNBA = [NSString stringWithFormat:@"%@?abcde=%ld", _reportURL, i];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
    [manager GET:urlNBA parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.reportDic removeAllObjects];
        if (nil != responseObject[@"west"]) {
            NSDictionary *westDic = responseObject[@"west"];
            NSMutableArray *westArr = [NSMutableArray array];
            for (NSDictionary *dic in [westDic objectForKey:@"list"]) {
                ReportInfo *reportI = [[ReportInfo alloc] init];
                [reportI setValuesForKeysWithDictionary:dic];
                [westArr addObject:reportI];
            }
            [_reportDic setObject:westArr forKey:@"NBA西部排名"];
            NSDictionary *eastDic = responseObject[@"east"];
            NSMutableArray *eastArr = [NSMutableArray array];
            for (NSDictionary *dic in [eastDic objectForKey:@"list"]) {
                ReportInfo *reportI = [[ReportInfo alloc] init];
                [reportI setValuesForKeysWithDictionary:dic];
                [eastArr addObject:reportI];
            }
            [_reportDic setObject:eastArr forKey:@"NBA东部排名"];
            [_mainCollectionView reloadData];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新停止" object:nil];
        }
        else if (nil != responseObject[@"data"] && nil == responseObject[@"name_cn"]) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSMutableArray *listArr = [NSMutableArray array];
            for (NSDictionary *dic in [dataDic objectForKey:@"list"]) {
                ReportInfo *reportI = [[ReportInfo alloc] init];
                [reportI setValuesForKeysWithDictionary:dic];
                [listArr addObject:reportI];
            }
            [_reportDic setObject:listArr forKey:@"NBA其他"];
            [_mainCollectionView reloadData];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新停止" object:nil];
        }
        else if (nil != responseObject[@"data"] && nil != responseObject[@"name_cn"]) {
            
            NSMutableArray *dataArr = [NSMutableArray array];
            dataArr = responseObject[@"data"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = 0; i < dataArr.count - 1; i++) {
                NSMutableArray *listArr = [NSMutableArray array];
                //                tagArr = [dataArr objectAtIndex:i];
                for (NSDictionary *dic in [dataArr objectAtIndex:i]) {
                    
                    ReportInfo *reportI = [[ReportInfo alloc] init];
                    [reportI setValuesForKeysWithDictionary:dic];
                    [listArr addObject:reportI];
                }
                [arr addObject:listArr];
            }
            [self.reportDic setObject:arr forKey:@"足球赛程"];
            [_mainCollectionView reloadData];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新停止" object:nil];
        }
        else if (nil != responseObject[@"items"]) {
            
            if (nil != responseObject[@"list"]) {
                self.footItemArr = [NSMutableArray array];
                self.footItemArr = responseObject[@"items"];
                
                NSMutableArray *listArr = [NSMutableArray array];
                
                for (NSDictionary *dic in responseObject[@"list"]) {
                    ReportInfo *reportI = [[ReportInfo alloc] init];
                    [reportI setValuesForKeysWithDictionary:dic];
                    [listArr addObject:reportI];
                }
//                [self.reportDic setObject:self.footItemArr forKey:@"标题"];
                [self.reportDic setObject:listArr forKey:@"足球积分"];
                [_mainCollectionView reloadData];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新停止" object:nil];
            } else {
                self.footItemArr = [NSMutableArray array];
                self.footItemArr = responseObject[@"items"];
                NSMutableArray *listArr = [NSMutableArray array];
                
                for (NSDictionary *dic in responseObject[@"playerlist"]) {
                    ReportInfo *reportI = [[ReportInfo alloc] init];
                    [reportI setValuesForKeysWithDictionary:dic];
                    [listArr addObject:reportI];
                }
//                [self.reportDic setObject:self.footItemArr forKey:@"标题"];
                [self.reportDic setObject:listArr forKey:@"足球其他"];
                [_mainCollectionView reloadData];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新停止" object:nil];
            }
            
        }

        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@", error);
        
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.headArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.item) {
                ReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"maincell" forIndexPath:indexPath];
        //   将标题传过去
        NSMutableArray *arr = [NSMutableArray array];
        arr = [_dicName objectForKey:[_headArr objectAtIndex:indexPath.item]];
        
        cell.infoArr = arr;
//        if (0 == indexPath.item) {
//            cell.isNBA = YES;
//        } else {
//            cell.isNBA = NO;
//        }
        
        cell.NBADic = _reportDic;
        //    [cell createSubViews];
        [cell.mainTableV reloadData];
        return cell;

    } else {
        
    FootReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"Footmaincell%ld", indexPath.item]  forIndexPath:indexPath];
    //   将标题传过去
    NSMutableArray *arr = [NSMutableArray array];
    arr = [_dicName objectForKey:[_headArr objectAtIndex:indexPath.item]];
    
    cell.infoArr = arr;
//    if (0 == indexPath.item) {
//        cell.isNBA = YES;
//    } else {
//        cell.isNBA = NO;
//    }
    
    cell.NBADic = _reportDic;
//    [cell createSubViews];
    [cell.mainTableV reloadData];
    return cell;
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
