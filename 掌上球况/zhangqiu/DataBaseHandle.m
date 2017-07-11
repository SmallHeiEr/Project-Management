//
//  DataBaseHandle.m
//  zhangqiu
//
//  Created by dllo on 16/4/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "DataBaseHandle.h"

@interface DataBaseHandle ()

@property (nonatomic, retain) FMDatabase *fmdbD;
@property (nonatomic, retain) FMDatabase *fmdbC;

@end

@implementation DataBaseHandle
- (void)dealloc
{
    [_fmdbC release];
    [_fmdbD release];
    [super dealloc];
}
+ (instancetype)shareDataBase
{
    static DataBaseHandle *dataBase = nil;
    if (nil == dataBase) {
        dataBase = [[DataBaseHandle alloc]init];
    }
    return dataBase;
}
- (void)openDB
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileD = [filePath stringByAppendingPathComponent:@"dataBase.db"];
    NSLog( @"%@", fileD);
    //打开数据库
    self.fmdbD = [[FMDatabase alloc] initWithPath:fileD];
    BOOL ret = [_fmdbD open];
    if (ret) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败");
    }
}
- (void)openCB
{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileC = [cachPath stringByAppendingPathComponent:@"dataBase.db"];
    NSLog( @"%@", fileC);
    //打开数据库
    self.fmdbC = [[FMDatabase alloc] initWithPath:fileC];
    
    BOOL ret = [_fmdbC open];
    if (ret) {
        NSLog(@"打开缓存数据库成功！");
    } else {
        NSLog(@"打开缓存数据库失败");
    }
}

- (void)closeDB
{
    BOOL ret = [_fmdbD close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    } else {
        NSLog(@"关闭数据库失败");
    }
    
}

- (void)closeCB
{
    BOOL ret = [_fmdbC close];
    if (ret) {
        NSLog(@"关闭数据库成功！");
    } else {
        NSLog(@"关闭数据库失败");
    }
}

- (void)createTableNewsName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number integer PRIMARY KEY AUTOINCREMENT, filename TEXT, createtime TEXT, title TEXT, imgsrc TEXT, url TEXT)", name];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"创建表单成功");
    } else {
        NSLog(@"创建表单失败");
    }
}
- (void)deleteTableName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", name];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"删除表单成功");
    } else {
        NSLog(@"删除表单失败");
    }
}
- (void)insertNewsDataWithName:(NSString *)name News:(News *)news
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(filename, createtime, title, imgsrc, url) VALUES ('%@', '%@', '%@', '%@', '%@')", name, news.filename, news.createtime, news.title, news.imgsrc, news.url];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}
//- (void)updataWithStu:(Student *)stu num:(NSInteger)num
//{
//    NSString *sql = [NSString stringWithFormat:@"UPDATE student SET name = '%@', sex = '%@', age = '%ld' WHERE number = '%ld'", stu.name, stu.sex, stu.age, num];
//    BOOL ret = [self.fmdb executeUpdate:sql];
//    if (ret) {
//        NSLog(@"更新数据成功！");
//    } else {
//        NSLog(@"更新数据失败！");
//    }
//}
- (void)deleteNewsDataWithName:(NSString *)name Title:(NSString *)title
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE title = '%@'", name, title];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败！");
    }
}
- (NSMutableArray *)selectNewsName:(NSString *)name Title:(NSString *)title
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  title LIKE '%%%@%%'", name, title];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *newArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        News *news = [[News alloc]init];
        news.filename = [resSet stringForColumn:@"filename"];
        news.createtime = [resSet stringForColumn:@"createtime"];
        news.title = [resSet stringForColumn:@"title"];
        news.imgsrc = [resSet stringForColumn:@"imgsrc"];
        news.url = [resSet stringForColumn:@"url"];
        [newArr addObject:news];
        [news release];
    }
    return newArr;
}
- (NSMutableArray *)selectAllNewsName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", name];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *newArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        News *news = [[News alloc]init];
        news.filename = [resSet stringForColumn:@"filename"];
        news.createtime = [resSet stringForColumn:@"createtime"];
        news.title = [resSet stringForColumn:@"title"];
        news.imgsrc = [resSet stringForColumn:@"imgsrc"];
        news.url = [resSet stringForColumn:@"url"];
        [newArr addObject:news];
        [news release];
    }
    return newArr;
}
//缓存NEWS
- (void)createCachTableNewsName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number integer PRIMARY KEY AUTOINCREMENT, filename TEXT, createtime TEXT, title TEXT, imgsrc TEXT, url TEXT)", name];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"创建表单成功");
    } else {
        NSLog(@"创建表单失败");
    }
}
- (void)deleteCachTableName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", name];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"删除表单成功");
    } else {
        NSLog(@"删除表单失败");
    }
}
- (void)insertCachNewsDataWithName:(NSString *)name News:(News *)news
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(filename, createtime, title, imgsrc, url) VALUES ('%@', '%@', '%@', '%@', '%@')", name, news.filename, news.createtime, news.title, news.imgsrc, news.url];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}
- (void)deleteCachNewsDataWithName:(NSString *)name Title:(NSString *)title
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE title = '%@'", name, title];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败！");
    }
}
- (NSMutableArray *)selectCachNewsName:(NSString *)name Title:(NSString *)title
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  title LIKE '%%%@%%'", name, title];
    FMResultSet *resSet = [_fmdbC executeQuery:sql];
    
    NSMutableArray *newArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        News *news = [[News alloc]init];
        news.filename = [resSet stringForColumn:@"filename"];
        news.createtime = [resSet stringForColumn:@"createtime"];
        news.title = [resSet stringForColumn:@"title"];
        news.imgsrc = [resSet stringForColumn:@"imgsrc"];
        news.url = [resSet stringForColumn:@"url"];
        [newArr addObject:news];
        [news release];
    }
    return newArr;
}
- (NSMutableArray *)selectCachAllNewsName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", name];
    FMResultSet *resSet = [_fmdbC executeQuery:sql];
    
    NSMutableArray *newArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        News *news = [[News alloc]init];
        news.filename = [resSet stringForColumn:@"filename"];
        news.createtime = [resSet stringForColumn:@"createtime"];
        news.title = [resSet stringForColumn:@"title"];
        news.imgsrc = [resSet stringForColumn:@"imgsrc"];
        news.url = [resSet stringForColumn:@"url"];
        [newArr addObject:news];
        [news release];
    }
    return newArr;
}
//
//- (void)insertMoreStudent:(Student *)stu
//{
//    //创建队列
//    FMDatabaseQueue *dataQ = [FMDatabaseQueue databaseQueueWithPath:self.filePath];
//    
//    //队列中任务要做的操作
//    [dataQ inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        
//        NSString *sql = [NSString stringWithFormat:@"INSERT INTO student(name, sex, age) VALUES ('%@', '%@', '%ld')", stu.name, stu.sex, stu.age];
//        BOOL ret = [db executeUpdate:sql];
//        if (ret) {
//            NSLog(@"插入数据成功");
//        } else {
//            NSLog(@"插入数据失败");
//        }
//    }];
//    
//}
- (void)createTableHappyName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number integer PRIMARY KEY AUTOINCREMENT, type TEXT, text TEXT, im TEXT, vi TEXT, height TEXT, width TEXT)", name];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"创建表单成功");
    } else {
        NSLog(@"创建表单失败");
    }
}

- (void)insertDataWithName:(NSString *)name Happy:(Happy *)happy
{
    NSString *sql = @"";
    if ([happy.type isEqualToString:@"video"]) {
        sql = [NSString stringWithFormat:@"INSERT INTO %@(type, text, im, vi, height, width) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", name, happy.type, happy.text, [[happy.video objectForKey:@"thumbnail"] firstObject], [[happy.video objectForKey:@"video"] firstObject], [happy.video objectForKey:@"height"], [happy.video objectForKey:@"width"]];
        
    } else if ([happy.type isEqualToString:@"image"]){
        sql = [NSString stringWithFormat:@"INSERT INTO %@(type, text, im, vi, height, width) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", name, happy.type, happy.text, [[happy.image objectForKey:@"big"] firstObject], nil, [happy.image objectForKey:@"height"], [happy.image objectForKey:@"width"]];

    } else if ([happy.type isEqualToString:@"gif"]){
        sql = [NSString stringWithFormat:@"INSERT INTO %@(type, text, im, vi, height, width) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", name, happy.type, happy.text, [[happy.gif objectForKey:@"images"] firstObject], nil, [happy.gif objectForKey:@"height"], [happy.gif objectForKey:@"width"]];
    } else {
        sql = [NSString stringWithFormat:@"INSERT INTO %@(type, text, im, vi, height, width) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", name, happy.type, happy.text, nil, nil, nil, nil];
    }
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}
- (void)deleteHappyDataWithName:(NSString *)name Text:(NSString *)text
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE text = '%@'", name, text];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败！");
    }
}
- (NSMutableArray *)selectHappyName:(NSString *)name Text:(NSString *)text
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  text LIKE '%%%@%%'", name, text];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *happyArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        Happy *happy = [[Happy alloc]init];
        happy.type = [resSet stringForColumn:@"type"];
        happy.text = [resSet stringForColumn:@"text"];
        happy.im = [resSet stringForColumn:@"im"];
        happy.vi = [resSet stringForColumn:@"vi"];
        happy.height = [resSet stringForColumn:@"height"];
        happy.width = [resSet stringForColumn:@"width"];
        [happyArr addObject:happy];
        [happy release];
    }
    return happyArr;
}
- (NSMutableArray *)selectAllHappyName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", name];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *happyArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        Happy *happy = [[Happy alloc]init];
        happy.type = [resSet stringForColumn:@"type"];
        happy.text = [resSet stringForColumn:@"text"];
        happy.im = [resSet stringForColumn:@"im"];
        happy.vi = [resSet stringForColumn:@"vi"];
        happy.height = [resSet stringForColumn:@"height"];
        happy.width = [resSet stringForColumn:@"width"];
        [happyArr addObject:happy];
        [happy release];
    }
    return happyArr;
}
//视频收藏
- (void)createTableVideoName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number integer PRIMARY KEY AUTOINCREMENT, name TEXT, img TEXT, url TEXT)", name];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"创建表单成功");
    } else {
        NSLog(@"创建表单失败");
    }
}
- (void)insertVideoDataWithName:(NSString *)name video:(VideoInfo *)video
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(name, img, url) VALUES ('%@', '%@', '%@')", name, video.name, video.img, video.url];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}
- (void)deleteVideoDataWithName:(NSString *)name url:(NSString *)url
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE url = '%@'", name, url];
    BOOL ret = [_fmdbD executeUpdate:sql];
    if (ret) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败！");
    }
}
- (NSMutableArray *)selectVideoName:(NSString *)name url:(NSString *)url
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  url LIKE '%%%@%%'", name, url];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *videoArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        VideoInfo *video = [[VideoInfo alloc]init];
        video.name = [resSet stringForColumn:@"name"];
        video.img = [resSet stringForColumn:@"img"];
        video.url = [resSet stringForColumn:@"url"];
        [videoArr addObject:video];
        [video release];
    }
    return videoArr;
}
- (NSMutableArray *)selectAllVideoName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", name];
    FMResultSet *resSet = [_fmdbD executeQuery:sql];
    
    NSMutableArray *videoArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        VideoInfo *video = [[VideoInfo alloc]init];
        video.name = [resSet stringForColumn:@"name"];
        video.img = [resSet stringForColumn:@"img"];
        video.url = [resSet stringForColumn:@"url"];
        [videoArr addObject:video];
        [video release];
    }
    return videoArr;
}
//视频首页缓存
- (void)createCachTableVideoName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(number integer PRIMARY KEY AUTOINCREMENT, title TEXT, type TEXT, createtime TEXT, url TEXT, filename TEXT, saishiid TEXT, image TEXT)", name];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"创建表单成功");
    } else {
        NSLog(@"创建表单失败");
    }
}
- (void)insertCachVideoDataWithName:(NSString *)name video:(Video *)video
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(title, type, createtime, url, filename, saishiid, image) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@')", name, video.title, video.type, video.createtime, video.url, video.filename, video.saishiid, video.image];
    BOOL ret = [_fmdbC executeUpdate:sql];
    if (ret) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}

- (NSMutableArray *)selectCachVideoName:(NSString *)name title:(NSString *)title
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  url LIKE '%%%@%%'", name, title];
    FMResultSet *resSet = [_fmdbC executeQuery:sql];
    
    NSMutableArray *videoArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        Video *video = [[Video alloc]init];
        video.title = [resSet stringForColumn:@"title"];
        video.type = [resSet stringForColumn:@"type"];
        video.createtime = [resSet stringForColumn:@"createtime"];
        video.url = [resSet stringForColumn:@"url"];
        video.filename = [resSet stringForColumn:@"filename"];
        video.saishiid = [resSet stringForColumn:@"saishiid"];
        video.image = [resSet stringForColumn:@"image"];
       
        [videoArr addObject:video];
        [video release];
    }
    return videoArr;
}
- (NSMutableArray *)selectCachAllVideoName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", name];
    FMResultSet *resSet = [_fmdbC executeQuery:sql];
    
    NSMutableArray *videoArr = [NSMutableArray array];
    //解析每一行
    while ([resSet next]) {
        Video *video = [[Video alloc]init];
        video.title = [resSet stringForColumn:@"title"];
        video.type = [resSet stringForColumn:@"type"];
        video.createtime = [resSet stringForColumn:@"createtime"];
        video.url = [resSet stringForColumn:@"url"];
        video.filename = [resSet stringForColumn:@"filename"];
        video.saishiid = [resSet stringForColumn:@"saishiid"];
        video.image = [resSet stringForColumn:@"image"];        [videoArr addObject:video];
        [video release];
    }
    return videoArr;
}

@end
