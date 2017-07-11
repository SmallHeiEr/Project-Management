//
//  DataBaseHandle.h
//  zhangqiu
//
//  Created by dllo on 16/4/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseHandle : NSObject
+ (instancetype)shareDataBase;
//缓存
- (void)openCB;
- (void)closeCB;
//收藏
- (void)openDB;
- (void)closeDB;
  //新闻收藏
- (void)createTableNewsName:(NSString *)name;
- (void)deleteTableName:(NSString *)name;
- (void)insertNewsDataWithName:(NSString *)name News:(News *)news;
- (void)deleteNewsDataWithName:(NSString *)name Title:(NSString *)title;
- (NSMutableArray *)selectNewsName:(NSString *)name Title:(NSString *)title;
- (NSMutableArray *)selectAllNewsName:(NSString *)name;
//新闻缓存
- (void)createCachTableNewsName:(NSString *)name;
- (void)deleteCachTableName:(NSString *)name;
- (void)insertCachNewsDataWithName:(NSString *)name News:(News *)news;
- (void)deleteCachNewsDataWithName:(NSString *)name Title:(NSString *)title;
- (NSMutableArray *)selectCachNewsName:(NSString *)name Title:(NSString *)title;
- (NSMutableArray *)selectCachAllNewsName:(NSString *)name;
  //笑点收藏
- (void)createTableHappyName:(NSString *)name;
- (void)insertDataWithName:(NSString *)name Happy:(Happy *)happy;
- (void)deleteHappyDataWithName:(NSString *)name Text:(NSString *)text;
- (NSMutableArray *)selectHappyName:(NSString *)name Text:(NSString *)text;
- (NSMutableArray *)selectAllHappyName:(NSString *)name;
  //视频收藏
- (void)createTableVideoName:(NSString *)name;
- (void)insertVideoDataWithName:(NSString *)name video:(VideoInfo *)video;
- (void)deleteVideoDataWithName:(NSString *)name url:(NSString *)url;
- (NSMutableArray *)selectVideoName:(NSString *)name url:(NSString *)url;
- (NSMutableArray *)selectAllVideoName:(NSString *)name;
//视频首页缓存
- (void)createCachTableVideoName:(NSString *)name;
- (void)insertCachVideoDataWithName:(NSString *)name video:(Video *)video;
- (NSMutableArray *)selectCachVideoName:(NSString *)name title:(NSString *)title;
- (NSMutableArray *)selectCachAllVideoName:(NSString *)name;
@end
