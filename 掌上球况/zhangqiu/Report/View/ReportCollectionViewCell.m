//
//  ReportCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

@interface ReportCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) TagView *viewTag;
@end

@implementation ReportCollectionViewCell
- (void)dealloc
{
    [_infoArr release];
    [_mainTableV release];
    [_liuView release];
    [_dicName release];
    [_NBADic release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    
    NSMutableArray *infoArr = [NSMutableArray array];
    
    self.isNBA = YES;
        infoArr = [NSMutableArray arrayWithObjects:@"排名", @"得分", @"篮板", @"助攻", @"抢断", @"盖帽", @"失误", @"神投", @"三分", @"罚球", nil];
//    if (self.isNBA == NO)  {
//        infoArr = [NSMutableArray arrayWithObjects:@"赛程", @"积分榜", @"射手榜", @"助攻榜", @"传威胁球", @"抢断", @"射门", @"传球", @"传中", @"扑救", @"犯规",@"被侵犯",@"解围",@"红黄牌",@"出场时间",nil];
//    }
    
        self.liuView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:infoArr clickBlick:^(NSInteger index) {
            
            ReportTag *report = [_infoArr objectAtIndex:(index - 1)];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:report.url forKey:@"URL"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReportURL" object:nil userInfo:dic];
            
            
//                    [_mainTableV reloadData];
        }];
        [self.contentView addSubview:_liuView];
        [_liuView release];

    
    
    
    self.mainTableV = [[[UITableView alloc]initWithFrame:CGRectMake(0, liuHeight+ sideCellHeight, myWidth, myHeight - (liuHeight + newsCellImageLeft * 2) - (liuHeight + navigationAppHeight) - tabBarheight - sideCellHeight) style:UITableViewStyleGrouped]autorelease];
    _mainTableV.delegate = self;
    _mainTableV.dataSource = self;
    _mainTableV.rowHeight = reportTableRowH;
    [self.contentView addSubview:_mainTableV];
    [_mainTableV registerClass:[ReportTableViewCell class] forCellReuseIdentifier:@"Reportcell"];
    [_mainTableV registerClass:[ReportTableViewCell class] forCellReuseIdentifier:@"Blackcell"];
//    self.automaticallyAdjustsScrollViewInsets = NO;
  [_mainTableV addHeaderWithCallback:^{
      NSMutableDictionary *dic = [NSMutableDictionary dictionary];
      ReportTag *report = [_infoArr objectAtIndex:self.liuView.defaultIndex - 1];

      [dic setObject:report.url forKey:@"URL"];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:@"ReportURL" object:nil userInfo:dic];
      
  }];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAction) name:@"刷新停止" object:nil];
    self.viewTag = [[TagView alloc]initWithFrame:CGRectMake(0, liuHeight, myWidth, sideCellHeight)];
    self.viewTag.backgroundColor = [UIColor grayColor];
    
    
    [self.contentView addSubview:self.viewTag];
        [self.viewTag release];
}
- (void)stopAction
{
    [_mainTableV headerEndRefreshing];
}
- (void)getTagViewtext
{
//    if (self.isNBA) {
        [self.viewTag getSeven];
        switch (self.liuView.defaultIndex) {
            case 1:
                self.viewTag.order.text = @"排名";
                self.viewTag.team.text = @"球队";
                self.viewTag.win.text = @"胜";
                self.viewTag.lost.text =@"负";
                self.viewTag.winning.text = @"胜率";
                self.viewTag.shengcha.text = @"胜差";
                self.viewTag.jinkuang.text = @"近况";
                break;
            case 2:
                _viewTag.order.text = @"排名";
                _viewTag.team.text = @"球员";
                _viewTag.win.text = @"球队";
                _viewTag.lost.text =@"场均";
                _viewTag.winning.text = @"命中率";
                _viewTag.shengcha.text = @"场次";
                _viewTag.jinkuang.text = @"时间";
                break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
                _viewTag.order.text = @"排名";
                _viewTag.team.text = @"球员";
                _viewTag.win.text = @"球队";
                _viewTag.lost.text =@"场均";
                _viewTag.winning.text = @"总数";
                _viewTag.shengcha.text = @"场次";
                _viewTag.jinkuang.text = @"时间";
                break;
            case 8:
            case 9:
            case 10:
                _viewTag.order.text = @"排名";
                _viewTag.team.text = @"球员";
                _viewTag.win.text = @"球队";
                _viewTag.lost.text =@"命中率";
                _viewTag.winning.text = @"命中数";
                _viewTag.shengcha.text = @"出手数";
                _viewTag.jinkuang.text = @"场次";
                break;
            default:
                break;
        }
        
//    }
//    else {
//        switch (self.liuView.defaultIndex) {
//            case 1:
//                [self.viewTag getFive];
//                _viewTag.order.text = @"日期";
//                _viewTag.team.text = @"时间";
//                _viewTag.win.text = @"主队";
//                _viewTag.lost.text =@"客队";
//                _viewTag.winning.text = @"比分";
//
//                break;
//            case 2:
//                [self.viewTag getEight];
//                _viewTag.order.text = @"排名";
//                _viewTag.team.text = @"球队";
//                _viewTag.win.text = @"场次";
//                _viewTag.lost.text =@"胜";
//                _viewTag.winning.text = @"平";
//                _viewTag.shengcha.text = @"负";
//                _viewTag.jinkuang.text = @"净胜球";
//                _viewTag.integral.text = @"积分";
//                break;
//            case 3:
//                [self.viewTag getSix];
//                _viewTag.order.text = @"排名";
//                _viewTag.team.text = @"球员";
//                _viewTag.win.text = @"球队";
//                _viewTag.lost.text =@"进球";
//                _viewTag.winning.text = @"普通进球";
//                _viewTag.shengcha.text = @"点球";
//                break;
//            case 4:
//            case 5:
//            case 6:
//            case 8:
//            case 9:
//            case 10:
//            case 11:
//            case 12:
//            case 13:
//            case 15:
//                [self.viewTag getFour];
//                _viewTag.order.text = @"排名";
//                _viewTag.team.text = @"球员";
//                _viewTag.win.text = @"球队";
//                _viewTag.lost.text =@"总计";
//                break;
//            case 7:
//                [self.viewTag getSeven];
//                _viewTag.order.text = @"排名";
//                _viewTag.team.text = @"球员";
//                _viewTag.win.text = @"球队";
//                _viewTag.lost.text =@"总计";
//                _viewTag.winning.text = @"左脚";
//                _viewTag.shengcha.text = @"右脚";
//                _viewTag.jinkuang.text = @"其他部分";
//                break;
//            case 14:
//                [self.viewTag getSix];
//                _viewTag.order.text = @"排名";
//                _viewTag.team.text = @"球员";
//                _viewTag.win.text = @"球队";
//                _viewTag.lost.text =@"红牌";
//                _viewTag.winning.text = @"黄牌";
//                _viewTag.shengcha.text = @"两黄";
//                break;
//            
//            default:
//                break;
//        }
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.liuView.defaultIndex == 1) {
        return sideCellHeight;
    }else {
        return 0;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //区头视图
    //    坐标无效
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, sideCellHeight)]autorelease];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, myWidth, sideCellHeight)];
    if (self.isNBA == YES && self.liuView.defaultIndex == 1) {
        if (0 == section) {
            label.text = @"NBA东部排名";
        } else {
            label.text = @"NBA西部排名";
        }
    } else if (self.liuView.defaultIndex == 1){
        label.text = [NSString stringWithFormat:@"第%ld组", section];
    }
        
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        [label release];
    view.backgroundColor = [UIColor colorWithWhite:0.594 alpha:1.000];
    return view;
}

//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isNBA == YES && self.liuView.defaultIndex == 1) {
        return 2;
    } else if (self.liuView.defaultIndex == 1) {
        NSMutableArray *arr = [NSMutableArray array];
        arr = [self.NBADic objectForKey:@"足球赛程"];
        return arr.count;
    } else {
        return 1;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self getTagViewtext];
    if (self.isNBA == YES && self.liuView.defaultIndex == 1) {
    return 15;
} else if (self.liuView.defaultIndex == 1) {
    NSMutableArray *arr = [NSMutableArray array];
    arr = [[self.NBADic objectForKey:@"足球赛程"] objectAtIndex:section];
    return arr.count;
} else if (self.isNBA == YES ){
    NSMutableArray *arr = [NSMutableArray array];
    arr = [self.NBADic objectForKey:@"NBA其他"];
           return arr.count;
} else if(self.liuView.defaultIndex == 2){
    NSMutableArray *arr = [NSMutableArray array];
    arr = [self.NBADic objectForKey:@"足球积分"];
    return arr.count;

} else {
    NSMutableArray *arr = [NSMutableArray array];
    arr = [self.NBADic objectForKey:@"足球其他"];
    return arr.count;
}
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    篮球排行
    if (self.isNBA == YES && self.liuView.defaultIndex == 1) {
        if (indexPath.section == 0) {
            NSMutableArray *arr = [NSMutableArray array];
            ReportInfo *reportI = [[ReportInfo alloc] init];
            arr = [_NBADic objectForKey:@"NBA东部排名"];
            reportI = [arr objectAtIndex:indexPath.row];
            
            if (0 == indexPath.row % 2) {
                ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
                cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
                [cell.tagView getSeven];
                [cell getModel:reportI];
                
                return cell;
            } else {
                ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
                [cell.tagView getSeven];
                [cell getModel:reportI];
                return cell;
            }
        } else {
            NSMutableArray *arr = [NSMutableArray array];
            ReportInfo *reportI = [[ReportInfo alloc] init];
            arr = [_NBADic objectForKey:@"NBA西部排名"];
            reportI = [arr objectAtIndex:indexPath.row];
            if (0 == indexPath.row % 2) {
                ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
                cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
                [cell.tagView getSeven];
                [cell getModel:reportI];
                return cell;
            } else {
                ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
                [cell.tagView getSeven];
                [cell getModel:reportI];
                return cell;
            }
        }

    }
//    篮球其他
    else if (self.isNBA == YES) {
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"NBA其他"];
        reportI = [arr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getSeven];
            cell.tagView.order.text = reportI.order;
            cell.tagView.team.text = reportI.name;
            cell.tagView.win.text = reportI.team;
            
            if (self.liuView.defaultIndex == 2) {
                cell.tagView.winning.text = reportI.shooting;
                cell.tagView.shengcha.text = reportI.count;
                cell.tagView.jinkuang.text = reportI.time;
                cell.tagView.lost.text = reportI.average;

            } else if (self.liuView.defaultIndex == 8 || self.liuView.defaultIndex == 9 || self.liuView.defaultIndex == 10){
                cell.tagView.winning.text = reportI.hit;
                cell.tagView.shengcha.text = reportI.shoot;
                cell.tagView.jinkuang.text = reportI.count;
                cell.tagView.lost.text = reportI.stat;
            } else {
                cell.tagView.winning.text = reportI.total;
                cell.tagView.shengcha.text = reportI.count;
                cell.tagView.jinkuang.text = reportI.time;
                cell.tagView.lost.text = reportI.average;

            }
            
            
            return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getSeven];
            cell.tagView.order.text = reportI.order;
            cell.tagView.team.text = reportI.name;
            cell.tagView.win.text = reportI.team;
            if (self.liuView.defaultIndex == 2) {
                cell.tagView.winning.text = reportI.shooting;
                cell.tagView.shengcha.text = reportI.count;
                cell.tagView.jinkuang.text = reportI.time;
                cell.tagView.lost.text = reportI.average;
                
            } else if (self.liuView.defaultIndex == 8 || self.liuView.defaultIndex == 9 || self.liuView.defaultIndex == 10){
                cell.tagView.winning.text = reportI.hit;
                cell.tagView.shengcha.text = reportI.shoot;
                cell.tagView.jinkuang.text = reportI.count;
                cell.tagView.lost.text = reportI.stat;
            } else {
                cell.tagView.winning.text = reportI.total;
                cell.tagView.shengcha.text = reportI.count;
                cell.tagView.jinkuang.text = reportI.time;
                cell.tagView.lost.text = reportI.average;
                
            }

            return cell;
        }

    }
//    足球赛程
    else if (self.liuView.defaultIndex == 1) {
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"足球赛程"];
        NSMutableArray *bigArr = [NSMutableArray array];
        bigArr = [arr objectAtIndex:indexPath.section];
        reportI = [bigArr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getFive];
            cell.tagView.order.text = reportI.date;
            cell.tagView.team.text = reportI.time;
            cell.tagView.win.text = reportI.home;
            cell.tagView.lost.text = reportI.visiting;
            cell.tagView.winning.text = [NSString stringWithFormat:@"%@-%@", reportI.h_score, reportI.V_score];
            
            
            return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getFive];
            cell.tagView.order.text = reportI.date;
            cell.tagView.team.text = reportI.time;
            cell.tagView.win.text = reportI.home;
            cell.tagView.lost.text = reportI.visiting;
            cell.tagView.winning.text = [NSString stringWithFormat:@"%@-%@", reportI.h_score, reportI.V_score];
            
            return cell;
        }

    }
//    足球积分榜
    else if (self.liuView.defaultIndex == 2) {
        
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"足球积分"];
        reportI = [arr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getEight];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球队;
            cell.tagView.win.text = reportI.场次;
            cell.tagView.lost.text = reportI.胜;
            cell.tagView.winning.text = reportI.平;
            cell.tagView.shengcha.text = reportI.负;
            cell.tagView.jinkuang.text = reportI.净胜球;
            cell.tagView.integral.text = reportI.积分;
            return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getEight];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球队;
            cell.tagView.win.text = reportI.场次;
            cell.tagView.lost.text = reportI.胜;
            cell.tagView.winning.text = reportI.平;
            cell.tagView.shengcha.text = reportI.负;
            cell.tagView.jinkuang.text = reportI.净胜球;
            cell.tagView.integral.text = reportI.积分;
            return cell;
        }

    }
//    足球射手榜
    else if(self.liuView.defaultIndex == 3){
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"足球其他"];
        reportI = [arr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getSix];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.进球;
            cell.tagView.winning.text = reportI.普通进球;
            cell.tagView.shengcha.text = reportI.点球;
         return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getSix];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.进球;
            cell.tagView.winning.text = reportI.普通进球;
            cell.tagView.shengcha.text = reportI.点球;
            return cell;
        }

    } else if (self.liuView.defaultIndex == 14) {
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"足球其他"];
        reportI = [arr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getSix];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.红牌;
            cell.tagView.winning.text = reportI.黄牌;
            cell.tagView.shengcha.text = reportI.两黄;
            return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getSix];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.红牌;
            cell.tagView.winning.text = reportI.黄牌;
            cell.tagView.shengcha.text = reportI.两黄;

            return cell;
        }
    } else {
        NSMutableArray *arr = [NSMutableArray array];
        ReportInfo *reportI = [[ReportInfo alloc] init];
        arr = [_NBADic objectForKey:@"足球其他"];
        reportI = [arr objectAtIndex:indexPath.row];
        if (0 == indexPath.row % 2) {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blackcell"];
            cell.backgroundColor = [UIColor colorWithWhite:0.783 alpha:1.000];
            [cell.tagView getFour];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.总计;
           
            return cell;
        } else {
            ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reportcell"];
            [cell.tagView getFour];
            cell.tagView.order.text = reportI.排名;
            cell.tagView.team.text = reportI.球员;
            cell.tagView.win.text = reportI.球队;
            cell.tagView.lost.text = reportI.总计;
            return cell;
        }

    }
    
}
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