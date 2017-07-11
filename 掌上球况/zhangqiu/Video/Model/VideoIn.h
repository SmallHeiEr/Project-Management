//
//  VideoIn.h
//  zhangqiu
//
//  Created by dllo on 16/4/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoIn : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSMutableArray *channel;
@property (nonatomic, retain) NSMutableArray *VideoArr;
@end
