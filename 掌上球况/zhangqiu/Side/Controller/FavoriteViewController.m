//
//  FavoriteViewController.m
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) BaseCollectionView *maincollectionV;
@property (nonatomic, retain) LiuXSegmentView *liuHView;
@property (nonatomic, retain) NSMutableArray *historyArr;
@property (nonatomic, retain) NSMutableArray *favoriteArr;
@end

@implementation FavoriteViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_maincollectionV reloadData];
}
- (void)dealloc
{
    [_maincollectionV release];
    [_liuHView release];
    [_historyArr release];
    [_favoriteArr release];
    [_number release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.historyArr = [NSMutableArray array];
    self.favoriteArr = [NSMutableArray array];
    [self getDate];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)]autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"全部删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)]autorelease];
    
    
    self.liuHView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:@[@"收藏", @"历史"] clickBlick:^(NSInteger index) {
        
        _maincollectionV.contentOffset = CGPointMake(myWidth * (index - 1), 0);
    }];
    [self.view addSubview:_liuHView];
    [_liuHView release];
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init]autorelease];
    layout.itemSize = CGSizeMake(myWidth, myHeight - navigationAppHeight - liuHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //间距为0
    layout.minimumLineSpacing = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.maincollectionV = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, liuHeight, myWidth, myHeight - navigationAppHeight - liuHeight) collectionViewLayout:layout];
    //    self.mainCollectionView.backgroundColor = [UIColor cyanColor];
    _maincollectionV.delegate = self;
    _maincollectionV.dataSource = self;
    //    整页滚动
    _maincollectionV.pagingEnabled = YES;
    
    [self.view addSubview:_maincollectionV];
    [_maincollectionV release];
    //    关闭边缘反弹
    _maincollectionV.bounces = NO;
    [_maincollectionV registerClass:[FavoriteNewsCollectionViewCell class] forCellWithReuseIdentifier:@"NewscellF"];
    
    [_maincollectionV registerClass:[FavoriteVideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideocellF"];
    [_maincollectionV registerClass:[FavoriteHappyCollectionViewCell class] forCellWithReuseIdentifier:@"HappycellF"];
    [_maincollectionV registerClass:[FavoriteNewsCollectionViewCell class] forCellWithReuseIdentifier:@"NewscellH"];
    
    [_maincollectionV registerClass:[FavoriteVideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideocellH"];
    [_maincollectionV registerClass:[FavoriteHappyCollectionViewCell class] forCellWithReuseIdentifier:@"HappycellH"];
    
    _maincollectionV.scrollEnabled = NO;
    
}
- (void)rightAction
{
    [[DataBaseHandle shareDataBase] openDB];
    
    
    if ([@"0" isEqualToString:_number]) {
        
        if (1 == self.liuHView.defaultIndex) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteNews"];
                [self.favoriteArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
            

        } else {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"historyNews"];
                [self.historyArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
            

        }
        
        
    } else if ([@"1" isEqualToString:_number]) {
        
        if (1 == self.liuHView.defaultIndex) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteVideo"];
                [self.favoriteArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        } else {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"historyVideo"]
            ;
                [self.historyArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
            

        }
    } else if ([@"2" isEqualToString:_number]) {
        if (1 == self.liuHView.defaultIndex) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteHappy"];
                [self.favoriteArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
        } else {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataBaseHandle shareDataBase] deleteTableName:@"historyHappy"];
                [self.historyArr removeAllObjects];
                [self.maincollectionV reloadData];

            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [self presentViewController:alert1 animated:YES completion:nil];
            

        }
    }
    
    
}


- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)getDate
{
    if ([@"0" isEqualToString:_number]) {
        [[DataBaseHandle shareDataBase] openDB];
        self.favoriteArr = [[DataBaseHandle shareDataBase] selectAllNewsName:@"favoriteNews"];
        self.historyArr = [[DataBaseHandle shareDataBase] selectAllNewsName:@"historyNews"];
        [[DataBaseHandle shareDataBase] closeDB];

    } else if ([@"1" isEqualToString:self.number]) {
        [[DataBaseHandle shareDataBase] openDB];
        self.favoriteArr = [[DataBaseHandle shareDataBase] selectAllVideoName:@"favoriteVideo"];
        self.historyArr = [[DataBaseHandle shareDataBase] selectAllVideoName:@"historyVideo"];
        [[DataBaseHandle shareDataBase] closeDB];

    } else if ([@"2" isEqualToString:self.number]) {
        [[DataBaseHandle shareDataBase] openDB];
        self.favoriteArr = [[DataBaseHandle shareDataBase] selectAllHappyName:@"favoriteHappy"];
        self.historyArr = [[DataBaseHandle shareDataBase] selectAllHappyName:@"historyHappy"];
        [[DataBaseHandle shareDataBase] closeDB];

    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([@"0" isEqualToString:_number]) {
       
        if (0 == indexPath.item) {
             FavoriteNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewscellF" forIndexPath:indexPath];
            cell.mainArr = _favoriteArr;
            cell.number = @"1";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;
        } else {
             FavoriteNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewscellH" forIndexPath:indexPath];
            cell.mainArr = _historyArr;
            cell.number = @"0";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;
        }
       

    } else if ([@"1" isEqualToString:_number]) {
       
        if (0 == indexPath.item) {
            FavoriteVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideocellH" forIndexPath:indexPath];

            cell.mainArr = _favoriteArr;
            cell.number = @"1";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;
        } else {
            FavoriteVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideocellF" forIndexPath:indexPath];

            cell.mainArr = _historyArr;
            cell.number = @"0";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;
        }
       

    } else if ([@"2" isEqualToString:_number]) {
       
        if (0 == indexPath.item) {
             FavoriteHappyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HappycellF" forIndexPath:indexPath];
            cell.mainArr = _favoriteArr;
            cell.number = @"1";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;

        } else {
             FavoriteHappyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HappycellH" forIndexPath:indexPath];
            cell.mainArr = _historyArr;
            cell.number = @"0";
//            [cell createSubViews];
            [cell.mainTableV reloadData];
            return cell;
        }
           } else {
        return nil;
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
