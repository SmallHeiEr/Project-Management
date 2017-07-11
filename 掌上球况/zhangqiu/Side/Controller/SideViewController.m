//
//  SideViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//
#import "SideViewController.h"

@interface SideViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)BaseTableView *tableV;
@end

@implementation SideViewController
- (void)dealloc
{
    [_button release];
    [_tableV release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    我的收藏
//    我的图片
//    我的视频
//    我的背景
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackImage.jpg"]];
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(myWidth - sideButtonWidth, sHeight * 20, sideButtonWidth, sideButtonWidth);
    [_button setBackgroundImage:[UIImage imageNamed:@"fanhui (3).png"] forState:UIControlStateNormal];
   
//    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    
    self.tableV = [[BaseTableView alloc]initWithFrame:CGRectMake(myWidth - sideSideWidth + newsCellImageLeft * 3, sideSideWidth / 3 * 2, sideSideWidth / 5 * 4, sideCellHeight * 6) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV .dataSource = self;
    _tableV.rowHeight = sideCellHeight;
    [self.view addSubview:_tableV];
    [_tableV release];
//    self.tableV.alpha = 0;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.backgroundColor = [UIColor clearColor];
    [_tableV registerClass:[SideTableViewCell class] forCellReuseIdentifier:@"cell"];
}
//- (void)buttonAction
//{
//    [UIView animateWithDuration:1.0 animations:^{
//        self.rootTBC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        self.view.frame = CGRectMake(- myWidth, 0, myWidth, myHeight);
//        
//    }];
//
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        BackImageViewController *backImageVC = [[BackImageViewController alloc] init];
        UINavigationController *backImageNC = [[UINavigationController alloc] initWithRootViewController:backImageVC];
        [self presentViewController:backImageNC animated:YES completion:^{
         }];
       [backImageNC release];
        [backImageVC release];
    } if (indexPath.row == 4) {
        [BackgrountViewController getAlertWithTitle:@"注意" message:@"将清除缓存和历史记录等" buttonLeft:@"是" leftBlock:^(UIAlertAction * _Nonnull action) {
            //    清除内存缓存
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            //    清除磁盘缓存
            [[SDWebImageManager sharedManager].imageCache clearDisk];
            
            [[DataBaseHandle shareDataBase] openCB];
            [[DataBaseHandle shareDataBase] deleteCachTableName:@"footHeadNews"];
            [[DataBaseHandle shareDataBase] deleteCachTableName:@"footNews"];
            [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBAHeadNews"];
            [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBANews"];
            
            
            
            [[SDWebImageManager sharedManager].imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
                
                NSLog(@"缓存文件大小：%ld， 总大小：%ld", fileCount, totalSize);
            }];
            //    清除内存缓存
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            //    清除磁盘缓存
            [[SDWebImageManager sharedManager].imageCache clearDisk];
            
            for (NSInteger i = 0; i < 6; i++) {
                [[DataBaseHandle shareDataBase] deleteCachTableName:[NSString stringWithFormat:@"VideoHomePage%ld", i]];
            }
            [[DataBaseHandle shareDataBase] closeCB];
            
        } buttonRight:@"否" leftBlock:nil vc:self time:MAXFLOAT];
        
        
//        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除缓存和历史记录等" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //    清除内存缓存
//            [[SDWebImageManager sharedManager].imageCache clearMemory];
//            //    清除磁盘缓存
//            [[SDWebImageManager sharedManager].imageCache clearDisk];
//
//            [[DataBaseHandle shareDataBase] openCB];
//            [[DataBaseHandle shareDataBase] deleteCachTableName:@"footHeadNews"];
//            [[DataBaseHandle shareDataBase] deleteCachTableName:@"footNews"];
//            [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBAHeadNews"];
//            [[DataBaseHandle shareDataBase] deleteCachTableName:@"NBANews"];
//            for (NSInteger i = 0; i < 6; i++) {
//                [[DataBaseHandle shareDataBase] deleteCachTableName:[NSString stringWithFormat:@"VideoHomePage%ld", i]];
//            }
//            [[DataBaseHandle shareDataBase] closeCB];
//            
//        }];
//        [alert1 addAction:alert2];
//        UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alert1 addAction:alert3];
//        [self presentViewController:alert1 animated:YES completion:nil];
    } else if (indexPath.row == 5) {
        SeachViewController *seach = [[SeachViewController alloc] init];
        //    seach.isFav = YES;
        //    seach.number = seach.number;
        [self presentViewController:seach animated:YES completion:^{
            
            
        }];
    }
    FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] init];
    favoriteVC.number = [@(indexPath.row) description];
    UINavigationController *favoriteNC = [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    [self presentViewController:favoriteNC animated:YES completion:^{
        
       
    }];
    [NSNumber numberWithInteger:[favoriteVC.number integerValue]];
    [favoriteVC release];
    [favoriteNC release];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.alpha = 0;
            cell.backgroundColor = [UIColor clearColor];

    if (0 == indexPath.row) {
         cell.imageV.image = [UIImage imageNamed:@"newwhite.png"];
    cell.label.text = @"我的新闻";
    } else if (1 == indexPath.row) {
        cell.imageV.image = [UIImage imageNamed:@"shipinwhite.png"];
        cell.label.text = @"我的视频";
    }else if (2 == indexPath.row) {
        cell.imageV.image = [UIImage imageNamed:@"happywhite.png"];
        cell.label.text = @"我的片场";
    } else if (3 == indexPath.row) {
        cell.imageV.image = [UIImage imageNamed:@"backwhite .png"];
        cell.label.text = @"我的背景";
    } else if (4 == indexPath.row) {
        cell.imageV.image = [UIImage imageNamed:@"remwhite.png"];
        cell.label.text = @"清除缓存";
    } else {
        cell.imageV.image = [UIImage imageNamed:@"searchwhite.png"];
        cell.label.text = @"新闻搜索";

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
