//
//  FavoriteVideoCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FavoriteVideoCollectionViewCell.h"
@interface FavoriteVideoCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation FavoriteVideoCollectionViewCell
- (void)dealloc
{
    [_mainArr release];
    
    [_number release];
    [_mainTableV release];
    [super dealloc];
}
- (void)createSubViews
{
    self.mainTableV = [[[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight  - liuHeight) style:UITableViewStylePlain]autorelease];
    _mainTableV.delegate = self;
    _mainTableV.dataSource = self;
    _mainTableV.rowHeight = newCellHeight;
    [self.contentView addSubview:_mainTableV];
    [self.mainTableV registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"Videocell"];
    _mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self viewController].navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"全部删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)]autorelease];
    
}
- (void)rightAction
{
    [[DataBaseHandle shareDataBase] openDB];

        if ([@"1" isEqualToString:_number]) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteVideo"];
            }];
            [alert1 addAction:alert2];
            UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert1 addAction:alert3];
            [[self viewController] presentViewController:alert1 animated:YES completion:nil];

        
    } else {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注意" message:@"将清除你的收藏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [[DataBaseHandle shareDataBase] deleteTableName:@"historyVideo"];
        }];
        [alert1 addAction:alert2];
        UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:alert3];
        [[self viewController] presentViewController:alert1 animated:YES completion:nil];
        
    }
    [[DataBaseHandle shareDataBase] closeDB];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [[self viewController] setEditing:editing animated:animated];
    [_mainTableV setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (0 != _mainArr.count) {
    VideoInfo *video = [_mainArr objectAtIndex:indexPath.row];
    [[DataBaseHandle shareDataBase] openDB];
    if ([@"1" isEqualToString:_number]) {
        [[DataBaseHandle shareDataBase] deleteVideoDataWithName:@"favoriteVideo" url:video.url];
        [_mainArr removeObject:video];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteVideo"];
        }
    } else {
        [[DataBaseHandle shareDataBase] deleteVideoDataWithName:@"historyVideo" url:video.url];
        [_mainArr removeObject:video];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"historyVideo"];
        }
        
    }
    
    
    
    [_mainTableV reloadData];
     }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (0 != _mainArr.count) {
    VideoInfo *videoInfo = [_mainArr objectAtIndex:indexPath.row];
    VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc]init];
    videoPlayVC.videoInfo = videoInfo;
    [[self viewController].navigationController pushViewController:videoPlayVC animated:YES];
    [videoPlayVC release];
     }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Videocell" forIndexPath:indexPath];
     if (0 != _mainArr.count) {
    VideoInfo *video =[_mainArr objectAtIndex:indexPath.row];
    [cell.imageV sd_setImageWithURLStr:video.img];
    cell.label1.text = [BackgrountViewController Html:video.name].string;
     }
         return cell;
}
//  在view中获取controller的方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
