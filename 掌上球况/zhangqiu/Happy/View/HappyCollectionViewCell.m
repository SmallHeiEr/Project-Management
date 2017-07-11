//
//  HappyCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "HappyCollectionViewCell.h"


@interface HappyCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)LiuXSegmentView *liuView;
@end


@implementation HappyCollectionViewCell
- (void)dealloc
{
    [_liuView release];
    [_InArr release];
    [_table release];
    [_headImageV release];
    [_hotArr release];
    [_mainArr release];
    
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
    self.mainArr = [NSMutableArray array];
    _mainArr = _InArr;
     self.headImageV = [[UIImageView alloc] init];
     _headImageV.frame = CGRectMake(0, 0, myWidth, myHeight / 4);
   
    self.table = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, myWidth, myHeight  - tabBarheight - navigationAppHeight -  liuHeight) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.tableHeaderView =  self.headImageV;
    [self.contentView addSubview:_table];
    _table.rowHeight = myHeight / 3;
    [_table release];
    [_table registerClass:[HappyTableViewCell class] forCellReuseIdentifier:@"VideoCell"];
    [_table registerClass:[HappyTableViewCell class] forCellReuseIdentifier:@"gifCell"];
    [_table registerClass:[HappyTableViewCell class] forCellReuseIdentifier:@"textCell"];
    [_table registerClass:[HappyTableViewCell class] forCellReuseIdentifier:@"imageCell"];
    [ _headImageV release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Happy *ha = [[Happy alloc] init];
    ha = [_mainArr objectAtIndex:indexPath.row];
    CGFloat textHeight = [BackgrountViewController getHeightWithStr:ha.text width:(myWidth - newsCellImageLeft * 4) fontSize:Videofont];
    NSNumber *height = nil;
    NSNumber *width = nil;
    CGFloat imageHeight = 0;
    if ([ha.type isEqualToString:@"video"]) {
        height = [ha.video objectForKey:@"height"];
        width = [ha.video objectForKey:@"width"];
    imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else if ([ha.type isEqualToString:@"image"]){
        height = [ha.image objectForKey:@"height"];
       width = [ha.image objectForKey:@"width"];
        imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else if ([ha.type isEqualToString:@"gif"]){
        height = [ha.gif objectForKey:@"height"];
        width = [ha.gif objectForKey:@"width"];
        imageHeight = [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue];
    } else {
        imageHeight = - 10;
      
    }
    return textHeight + imageHeight + liuHeight + 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Happy *ha = [[Happy alloc] init];
    ha = [_mainArr objectAtIndex:indexPath.row];
    if ([ha.type isEqualToString:@"video"]) {

        NSNumber *height = [ha.video objectForKey:@"height"];
        NSNumber *width = [ha.video objectForKey:@"width"];
        playViewController *playVC = [[playViewController alloc] init];
        playVC.height = height;
        playVC.width = width;
        
        playVC.playUrl = [[ha.video objectForKey:@"video"] firstObject];
        [[self viewController] presentViewController:playVC animated:YES completion:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return liuHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)]autorelease];
    self.liuView = [[LiuXSegmentView alloc]initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:@[@"最新", @"最热"] clickBlick:^(NSInteger index) {
        if (1 == index) {
            self.mainArr = _InArr;
            self.liuView.defaultIndex = 1;
        } else {
            self.mainArr = _hotArr;
            self.liuView.defaultIndex = 2;
        }
        [_table reloadData];
    }];
    [view addSubview:_liuView];
    [_liuView release];
//    view.backgroundColor = [UIColor grayColor];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _mainArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Happy *ha = [self.mainArr objectAtIndex:indexPath.row];
    
    if ([ha.type isEqualToString:@"video"]) {
        HappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
        
        cell.happy = ha;
        [cell getVideoHappy:ha];
        return cell;
     } else if ([ha.type isEqualToString:@"image"]){
         HappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
         cell.happy = ha;
         [cell getImageHappy:ha];
           return cell;
     } else if ([ha.type isEqualToString:@"gif"]){
         HappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gifCell" forIndexPath:indexPath];
         cell.happy = ha;
         [cell getGifHappy:ha];
          return cell;
     } else {
         HappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
         cell.happy = ha;
         [cell getTextHappy:ha];
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
