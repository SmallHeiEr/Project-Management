//
//  VideoI.h
//  zhangqiu
//
//  Created by dllo on 16/3/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoI : NSObject
@property (nonatomic, copy)NSString *match_id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *home_team;
@property (nonatomic, copy)NSString *visit_team;
@property (nonatomic, copy)NSString *home_logo;
@property (nonatomic, copy)NSString *visit_logo;
@property (nonatomic, copy)NSString *match_time;
@property (nonatomic, copy)NSString *zhibo_url;
@property (nonatomic, copy)NSString *zhanbao_url;
@property (nonatomic, copy)NSString *jijin_url;
@property (nonatomic, copy)NSString *luxiang_url;

@property (nonatomic, copy)NSString *home_score;
@property (nonatomic, copy)NSString *visit_score;
@end
