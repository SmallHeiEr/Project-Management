//
//  VideoCollectionViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//
@interface VideoCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>



@end

@implementation VideoCollectionViewCell





- (void)dealloc
{
    [_collectionArr release];
    [_mainTableV release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.mainTableV = [[[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight - liuHeight - navigationAppHeight - tabBarheight) style:UITableViewStylePlain]autorelease];
        _mainTableV.delegate = self;
        _mainTableV.dataSource = self;
        _mainTableV.rowHeight = newCellHeight;
        [self.contentView addSubview:_mainTableV];
        [_mainTableV registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"Videocell"];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAction) name:@"停止" object:nil];
        _mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mainTableV addHeaderWithCallback:^{
            
            [self viewController].isUpState = 0;
            
            [[self viewController] getDate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_mainTableV headerEndRefreshing];
            });
        }];
        
        
    }
   
    
    return self;
}
//- (void)stopAction
//{
////    [_mainTableV headerEndRefreshing];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
   
    
    
    VideoInfoViewController *videoIVC = [[VideoInfoViewController alloc]init];
    Video *video = [_collectionArr objectAtIndex:indexPath.row];
    if ([@"zuqiujijin" isEqualToString:video.type] || [@"nbajijin" isEqualToString:video.type]) {
        [userD setObject:@"jijin" forKey:@"offset"];
    } else if ([@"zuqiuluxiang" isEqualToString:video.type] || [@"nbaluxiang" isEqualToString:video.type]) {
         [userD setObject:@"luxiang" forKey:@"offset"];
    }
    videoIVC.infoDic = video.infoDic;
    videoIVC.isZuQiu = self.isZuQiu;
//    videoIVC.title = video.title;
//    videoIVC.createtime = video.createtime;
   [[self viewController].navigationController pushViewController:videoIVC animated:YES];
    [videoIVC release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _collectionArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Videocell"];
//    cell.backgroundColor = [UIColor redColor];
    Video *foot = [[Video alloc]init];
    foot = [self.collectionArr objectAtIndex:indexPath.row];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:foot.image] placeholderImage:[UIImage imageNamed:backImage]];
    cell.label1.text = foot.title;
  
 
    return cell;
}
- (VideoViewController *)viewController {
      for (UIView* next = [self superview]; next; next = next.superview) {
         UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                  return (VideoViewController *)nextResponder;
           }
       }
          return nil;
}

@end