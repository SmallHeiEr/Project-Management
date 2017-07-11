//
//  ReportCollectionViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) NSMutableArray *infoArr;
@property (nonatomic, retain) UITableView *mainTableV;
@property (nonatomic, retain) LiuXSegmentView *liuView;
@property (nonatomic, retain) NSMutableDictionary *dicName;
@property (nonatomic, retain) NSMutableDictionary *NBADic;
@property (nonatomic, assign) BOOL isNBA;
- (void)createSubViews;
//- (void)getDateliuViewArr:(NSArray *)arr;

@end
