//
//  SportViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SportViewController.h"

@interface SportViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) LiuXSegmentView *liuHView;
@property (nonatomic, retain) NSMutableArray *tagArr;
@property (nonatomic, retain) NSMutableDictionary *ballDic;
@property (nonatomic, retain) NSUserDefaults *userD;

@end

@implementation SportViewController
- (void)dealloc
{
    [_maincollectionV release];
    [_liuHView release];
    [_tagArr release];
    [_ballDic release];
    [_userD release];
    
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDate];
    
    self.ballDic = [NSMutableDictionary dictionary];
    self.userD = [NSUserDefaults standardUserDefaults];
    
    self.liuHView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:@[@"体育", @"足球", @"篮球"] clickBlick:^(NSInteger index) {
        _maincollectionV.contentOffset = CGPointMake(myWidth * (index - 1), 0);
    }];
    [self.view addSubview:_liuHView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(myWidth, myHeight - navigationAppHeight - tabBarheight - liuHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //间距为0
    layout.minimumLineSpacing = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.maincollectionV= [[BaseCollectionView alloc]initWithFrame:CGRectMake(0,  liuHeight, myWidth, myHeight -  liuHeight - navigationAppHeight - tabBarheight) collectionViewLayout:layout];
//    self.number = [self.userD objectForKey:@"index"];
    NSInteger num = 0;
    if ([@"1" isEqualToString:[_userD objectForKey:@"index"]]) {
        num = 1;
    } else if ([@"2" isEqualToString:[_userD objectForKey:@"index"]]){
        num = 2;
    }
    
    _maincollectionV.contentOffset = CGPointMake(myWidth * num, 0);
    _liuHView.defaultIndex = num + 1;

    
    _maincollectionV.delegate = self;
    _maincollectionV.dataSource = self;
    //    整页滚动
    _maincollectionV.pagingEnabled = YES;
    
    [self.view addSubview:_maincollectionV];
    [_maincollectionV release];
    //    关闭边缘反弹
    _maincollectionV.bounces = NO;
#warning 创建自定义cell
    for (NSInteger i = 0; i < 3; i++) {
        [_maincollectionV registerClass:[HappyCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%ld", i]];
    }
   
    
    
    
    
}
- (void)getDate
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Happy" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic  in jsonArr) {
        NSString *url = dic[@"URL"];
        NSString *tag = dic[@"type"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    设置支持所有的接口类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
        
        [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSArray *arr = responseObject[@"list"];
            self.tagArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                Happy *happy = [[Happy alloc] init];
            [happy setValuesForKeysWithDictionary:dic];
                [_tagArr addObject:happy];
            }
            [_ballDic setObject:_tagArr forKey:tag];
            [_maincollectionV reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败%@", error);
            
        }];
 
        
        
        
    }
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        HappyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%ld", indexPath.item] forIndexPath:indexPath];
        cell.InArr = [_ballDic objectForKey:[@(indexPath.item) description]];
        cell.hotArr = [_ballDic objectForKey:[@(indexPath.item + 3) description]];
    cell.mainArr = cell.InArr;
        cell.headImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"head%ld.png", indexPath.item]];
        [cell.table reloadData];
        return cell;
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSInteger currentPageIndex =  scrollView.contentOffset.x / scrollView.frame.size.width;
        if (_liuHView.defaultIndex != currentPageIndex + 1) {
            _liuHView.defaultIndex = currentPageIndex + 1;
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
