//
//  VideoCollectionViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class BaseTableView;
@interface VideoCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, retain) NSMutableArray *collectionArr;
@property (nonatomic, retain) BaseTableView *mainTableV;
@property (nonatomic, assign) BOOL isZuQiu;
@end
