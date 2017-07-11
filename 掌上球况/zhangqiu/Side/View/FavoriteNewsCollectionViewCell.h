//
//  FavoriteNewsCollectionViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteNewsCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain) NSMutableArray *mainArr;
@property (nonatomic, retain) BaseTableView *mainTableV;
- (void)createSubViews;
@property (nonatomic, copy) NSString *number;
@end
