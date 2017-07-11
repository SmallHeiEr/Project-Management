//
//  FavoriteNewsCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FavoriteNewsCollectionViewCell.h"

@interface FavoriteNewsCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation FavoriteNewsCollectionViewCell


- (void)dealloc
{
    [_mainArr release];
    
    [_number release];
    [_mainTableV release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        
    }
    return self;
}

- (void)createSubViews
{
    self.mainTableV = [[[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight - liuHeight) style:UITableViewStylePlain]autorelease];
    _mainTableV.delegate = self;
    _mainTableV.dataSource = self;
    _mainTableV.rowHeight = newCellHeight;
    [self.contentView addSubview:_mainTableV];
    [_mainTableV registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"Videocell"];
    _mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
   
    
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [[self viewController] setEditing:editing animated:animated];
    [_mainTableV setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 != _mainArr.count) {
        
    
    News *news = [_mainArr objectAtIndex:indexPath.row];
        [[DataBaseHandle shareDataBase] openDB];
    if ([@"1" isEqualToString:self.number]) {
        [[DataBaseHandle shareDataBase] deleteNewsDataWithName:@"favoriteNews" Title:news.title];
        [_mainArr removeObject:news];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteNews"];
        }
    } else {
        [[DataBaseHandle shareDataBase] deleteNewsDataWithName:@"historyNews" Title:news.title];
        [_mainArr removeObject:news];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"historyNews"];
        }

    }
    
 
    
    [_mainTableV reloadData];
        }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 != _mainArr.count) {
    
   News *news =[_mainArr objectAtIndex:indexPath.row];
    NSLog(@"%@", [news.url substringToIndex:10]);
    if ([@"http:"isEqualToString:[news.url substringToIndex:5]]) {
        SportInfoViewController *sportIVC = [[SportInfoViewController alloc]init];
        sportIVC.news = news;
        [[self viewController].navigationController pushViewController:sportIVC animated:YES];
        [sportIVC release];
    } else if ([@"/zuqi"isEqualToString:[news.url substringToIndex:5]]){
        FootInfoViewController *footIVC = [[FootInfoViewController alloc] init];
        footIVC.news = news;
        [[self viewController].navigationController pushViewController:footIVC animated:YES];
        [footIVC release];
    } else {
        NBAInfoViewController *NBAIVC = [[NBAInfoViewController alloc] init];
        NBAIVC.news = news;
        [[self viewController].navigationController pushViewController:NBAIVC animated:YES];
        [NBAIVC release];
    }
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
   
    News *news =[self.mainArr objectAtIndex:indexPath.row];
    [cell.imageV sd_setImageWithURLStr:news.imgsrc];
    cell.label1.text = news.title;
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
