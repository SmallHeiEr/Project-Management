//
//  FavoriteHappyCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FavoriteHappyCollectionViewCell.h"
@interface FavoriteHappyCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation FavoriteHappyCollectionViewCell
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
    [_mainTableV registerClass:[FavoriteHappyTableViewCell class] forCellReuseIdentifier:@"VideoCell"];
    [_mainTableV registerClass:[FavoriteHappyTableViewCell class] forCellReuseIdentifier:@"gifCell"];
    [_mainTableV registerClass:[FavoriteHappyTableViewCell class] forCellReuseIdentifier:@"textCell"];
    [_mainTableV registerClass:[FavoriteHappyTableViewCell class] forCellReuseIdentifier:@"imageCell"];
    [_mainTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    _mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [[self viewController] setEditing:editing animated:animated];
    [_mainTableV setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (0 != _mainArr.count) {
    Happy *happy = [_mainArr objectAtIndex:indexPath.row];
    [[DataBaseHandle shareDataBase] openDB];
    if ([@"1" isEqualToString:_number]) {
        [[DataBaseHandle shareDataBase] deleteHappyDataWithName:@"favoriteHappy" Text:happy.text];
        [_mainArr removeObject:happy];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"favoriteHappy"];
        }
    } else {
        [[DataBaseHandle shareDataBase] deleteHappyDataWithName:@"historyHappy" Text:happy.text];
        [_mainArr removeObject:happy];
        if (nil == _mainArr) {
            [[DataBaseHandle shareDataBase] deleteTableName:@"historyHappy"];
        }
        
    }
    
    
    
    [_mainTableV reloadData];
     }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (0 != _mainArr.count) {
    Happy *ha = [[Happy alloc] init];
    ha = [_mainArr objectAtIndex:indexPath.row];
    CGFloat textHeight = [BackgrountViewController getHeightWithStr:ha.text width:(myWidth - newsCellImageLeft * 4) fontSize:cornerR];
    NSNumber *height = nil;
    NSNumber *width = nil;
    CGFloat imageHeight = 0;
    if ([ha.type isEqualToString:@"video"]) {
        height = [NSNumber numberWithInteger:[ha.height integerValue]];
        width = [NSNumber numberWithInteger:[ha.width integerValue]];
        imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else if ([ha.type isEqualToString:@"image"]){
        height = [NSNumber numberWithInteger:[ha.height integerValue]];
        width = [NSNumber numberWithInteger:[ha.width integerValue]];
        imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else if ([ha.type isEqualToString:@"gif"]){
        height = [NSNumber numberWithInteger:[ha.height integerValue]];
        width = [NSNumber numberWithInteger:[ha.width integerValue]];
        imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else {
        imageHeight = 0;
        
    }
    return textHeight + imageHeight;
     }
     else {
         return 0;
     }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (0 != _mainArr.count) {
    Happy *ha = [[Happy alloc] init];
    ha = [_mainArr objectAtIndex:indexPath.row];
    if ([ha.type isEqualToString:@"video"]) {
        
      
        NSNumber *height = [NSNumber numberWithInteger:[ha.height integerValue]];
        NSNumber *width = [NSNumber numberWithInteger:[ha.width integerValue]];
        playViewController *playVC = [[playViewController alloc] init];
        playVC.height = height;
        playVC.width = width;
        
        playVC.playUrl = ha.vi;
        [[self viewController] presentViewController:playVC animated:YES completion:nil];
    }
     }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _mainArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (0 != _mainArr.count) {
    Happy *ha = [_mainArr objectAtIndex:indexPath.row];
    
    if ([ha.type isEqualToString:@"video"]) {
        FavoriteHappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
        
        cell.happy = ha;
        [cell getVideoHappy:ha];
        return cell;
    } else if ([ha.type isEqualToString:@"image"]){
        FavoriteHappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
        cell.happy = ha;
        [cell getImageHappy:ha];
        return cell;
    } else if ([ha.type isEqualToString:@"gif"]){
        FavoriteHappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gifCell" forIndexPath:indexPath];
        cell.happy = ha;
        [cell getGifHappy:ha];
        return cell;
    } else {
        FavoriteHappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
        cell.happy = ha;
        [cell getTextHappy:ha];
        return cell;
    }
     } else {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
         return cell;
     }
    
    
    
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

