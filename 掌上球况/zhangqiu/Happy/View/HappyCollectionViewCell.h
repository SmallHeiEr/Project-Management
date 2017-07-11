//
//  HappyCollectionViewCell.h
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface HappyCollectionViewCell : BaseCollectionViewCell

@property (nonatomic, retain) NSMutableArray *InArr;
@property (nonatomic, retain) BaseTableView *table;
@property (nonatomic, retain)UIImageView *headImageV;
@property (nonatomic, retain) NSMutableArray *hotArr;
@property (nonatomic, retain) NSMutableArray *mainArr;
@end
