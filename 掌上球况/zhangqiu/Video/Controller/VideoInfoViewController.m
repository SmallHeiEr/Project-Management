//
//  VideoInfoViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "VideoInfoViewController.h"

@interface VideoInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIWebViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollV;
@property (nonatomic, retain) LiuXSegmentView *liuView;
@property (nonatomic, retain) NSUserDefaults *userD;
@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, retain) BaseTableView *tableVR;
@property (nonatomic, retain) BaseTableView *tableVL;
@property (nonatomic, retain) VideoI *videoU;
@property (nonatomic, retain) VideoI *videoS;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) BaseLabel *titleLZ;
@property (nonatomic, retain) BaseLabel *timeLZ;
@property (nonatomic, retain) UIView *headView;
@property (nonatomic, retain) BaseTableView *tableVZ;
@property (nonatomic, retain) BaseLabel *titleL;
@property (nonatomic, retain) BaseLabel *timeL;
@property (nonatomic, retain) BaseLabel *titleR;
@property (nonatomic, retain) BaseLabel *timeR;
@end

@implementation VideoInfoViewController
- (void)dealloc
{
    [_scrollV release];
    [_liuView release];
    [_userD release];
    [_dic release];
    [_tableVR release];
    [_tableVL release];
    [_videoU release];
    [_videoS release];
    [_webView release];
    [_titleLZ release];
    [_timeLZ release];
    [_headView release];
    [_tableVZ release];
    [_titleL release];
    [_timeL release];
    [_titleR release];
    [_timeR release];
    [_infoDic release];
    [_createtime release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.userD = [NSUserDefaults standardUserDefaults];
//     self.navigationItem.title = @";
    self.dic = [NSMutableDictionary dictionary];
    self.videoU = [self.infoDic objectForKey:@"U"];
    self.videoS = [self.infoDic objectForKey:@"S"];
//    VideoI *videoV = [self.infoDic objectForKey:@"V"];
    [self getDate];
#warning 头部
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
//    view.backgroundColor = [UIColor redColor];
    [view release];
    if (1 != _infoDic.allKeys.count) {
        view.frame = CGRectMake(0, 0, myWidth, newCellHeight);
    } else {
        view.frame = CGRectMake(0, 0, 0, 0);
    }
    
    UIView *liuV = [[UIView alloc]init];
    [self.view addSubview:liuV];
//    liuV.backgroundColor = [UIColor cyanColor];
    [liuV release];
    if (1 != _infoDic.allKeys.count) {
        liuV.frame =CGRectMake(0, view.frame.origin.y + view.frame.size.height, myWidth, liuHeight);
    } else {
        liuV.frame = CGRectMake(0, 0, 0, 0);
    }
    
    self.scrollV = [[UIScrollView alloc] init];
    
    
    if (1 == _infoDic.allKeys.count) {
       _scrollV.frame = CGRectMake(0, 0, myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight);

        _scrollV.contentSize = CGSizeMake(myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight);
    } else {
         _scrollV.frame = CGRectMake(0, liuV.frame.origin.y + liuV.frame.size.height, myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight);
        _scrollV.contentSize = CGSizeMake(myWidth * 3, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight);
    }
    //    翻页效果
    _scrollV.pagingEnabled = YES;
    //    水平滚动条是否存在
    _scrollV.showsHorizontalScrollIndicator = NO;
    //    第一页和最后一页的回弹效果
    _scrollV.bounces = NO;
    _scrollV.delegate = self;
    [self.view addSubview:_scrollV];
    [_scrollV release];
    
    
    
    self.liuView = [[LiuXSegmentView alloc]initWithFrame:CGRectMake(0, 0, myWidth, liuHeight) titles:@[@"集锦", @"战报", @"录像"] clickBlick:^(NSInteger index) {
        _scrollV.contentOffset = CGPointMake(myWidth * (index - 1), 0);
//        NSLog(@"ssssssss%ld ", index);
    }];
    [liuV addSubview:_liuView];
    [_liuView release];

    
   
    if ([@"jijin" isEqualToString:[_userD objectForKey:@"offset"]]) {
        
    } else {
        _scrollV.contentOffset = CGPointMake(myWidth * 2, 0);
        _liuView.defaultIndex = 3;
    }
    
    


    
    
    UIImageView *imageVL = [[UIImageView alloc]initWithFrame:CGRectMake(VideoImageLeft, newCellHeight / 100 * 15, VideoImageLeft, newCellHeight / 100 * 35)];
    
    if (self.isZuQiu == YES) {
        [imageVL sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png", _videoU.home_logo]] placeholderImage:[UIImage imageNamed:@""]];
    } else {
         [imageVL sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/nba/%@.png", _videoU.home_logo]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    
    
    [view addSubview:imageVL];
    
    BaseLabel *labelL = [[BaseLabel alloc]initWithFrame:CGRectMake(VideoImageLeft * 0.5, newCellHeight / 100 * 65, VideoImageLeft * 2, newCellHeight / 100 * 25)];
     labelL.textAlignment = NSTextAlignmentCenter;
    labelL.font = [UIFont fontWithName:@"Helvetica" size:Videofont];
    labelL.text = _videoU.home_team;
    [view addSubview:labelL];
    
    UIImageView *imageVR = [[UIImageView alloc]initWithFrame:CGRectMake(VideoImageLeft * 5, newCellHeight / 100 * 15, VideoImageLeft, newCellHeight / 100 * 35)];
    
    if (self.isZuQiu == YES) {
         [imageVR sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png", _videoU.visit_logo]] placeholderImage:[UIImage imageNamed:@""]];
    } else {
        [imageVR sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/nba/%@.png", _videoU.visit_logo]] placeholderImage:[UIImage imageNamed:@""]];
    }

    
    [view addSubview:imageVR];
    
    BaseLabel *labelR = [[BaseLabel alloc]initWithFrame:CGRectMake(VideoImageLeft * 4.5, newCellHeight / 100 * 65, VideoImageLeft * 2, newCellHeight / 100 * 25)];
    labelR.textAlignment = NSTextAlignmentCenter;
    labelR.font = [UIFont fontWithName:@"Helvetica" size:Videofont];
        labelR.text = _videoU.visit_team;
    [view addSubview:labelR];

    BaseLabel *labelC = [[BaseLabel alloc]initWithFrame:CGRectMake(myWidth / 3 * 1, newCellHeight / 100 * 30, myWidth / 3, newCellHeight / 3)];
    labelC.textAlignment = NSTextAlignmentCenter;
    labelC.font = [UIFont fontWithName:@"Helvetica" size:Videofont / 18 * 24];
    labelC.text = [NSString stringWithFormat:@"%@ : %@", _videoS.home_score, _videoS.visit_score];
    [view addSubview:labelC];




#warning 集锦
//    VideoIn *videoJi = [[VideoIn alloc] init];
//   VideoIn *videoJi = [self.dic objectForKey:self.videoU.jijin_url];
    
    self.tableVL = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight) style:UITableViewStylePlain];
    _tableVL.rowHeight = newCellHeight;
    _tableVL.delegate = self;
    _tableVL.dataSource = self;
    [_scrollV addSubview:_tableVL];
    
    [_tableVL registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"VLcell"];
    
    UIView *viewHL = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, newCellHeight)];
    _tableVL.tableHeaderView = viewHL;
    [viewHL release];
    
    
    self.titleL = [[BaseLabel alloc]initWithFrame:CGRectMake(newCellHeight / 100 * 40, 10, myWidth - newCellHeight / 100 * 80, newCellHeight / 100 * 50)];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont / 18 * 20];
    _titleL.numberOfLines = 0;
    [viewHL addSubview:_titleL];
    
    self.timeL = [[BaseLabel alloc]initWithFrame:CGRectMake(newCellHeight / 2, _titleL.frame.origin.y + _titleL.frame.size.height , myWidth - newCellHeight, newCellHeight / 100 * 40)];
    _timeL.font = [UIFont fontWithName:@"Helvetica" size:Videofont / 18 * 14];
    _timeL.textAlignment = NSTextAlignmentCenter;
    [viewHL addSubview:_timeL];
    [_timeL release];
    
#warning 战报
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myWidth, newCellHeight)];
    [_headView release];
    _titleLZ = [[BaseLabel alloc] initWithFrame:CGRectMake(newCellHeight / 10, newCellHeight / 5, myWidth - newCellHeight / 100 * 20, newCellHeight / 2)];
    _titleLZ.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont / 18 * 20];
    _titleLZ.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:_titleLZ];
    [_titleLZ release];
    
    self.timeLZ = [[BaseLabel alloc]initWithFrame:CGRectMake(newCellHeight / 10, _titleLZ.frame.origin.y + _titleLZ.frame.size.height + 5, myWidth - newCellHeight / 100 * 20, newCellHeight * 3 / 10)];
    _timeLZ.font = [UIFont fontWithName:@"Helvetica" size:Videofont / 18 * 14];
    _timeLZ.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:_timeLZ];
    [self.timeLZ release];
    
    self.tableVZ = [[BaseTableView alloc]initWithFrame:CGRectMake(myWidth, 0, myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight) style:UITableViewStylePlain];
    _tableVZ.delegate = self;
    _tableVZ.dataSource = self;
    [self.scrollV addSubview:_tableVZ];
    [_tableVZ release];
   _tableVZ.tableHeaderView = self.headView;
    [_tableVZ registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableVZ.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, myWidth, 20 )];
    _webView.scrollView.scrollEnabled = NO;
    
    [_webView release];
    _webView.delegate = self;

#warning 录像
//    VideoIn *videoLu = [[VideoIn alloc] init];
//    VideoIn *videoLu = [self.dic objectForKey:self.videoU.luxiang_url];
    self.tableVR = [[BaseTableView alloc]initWithFrame:CGRectMake(myWidth * 2, 0, myWidth, myHeight - (liuV.frame.origin.y + liuV.frame.size.height) - tabBarheight) style:UITableViewStylePlain];
    _tableVR.rowHeight = newCellHeight;
    _tableVR.delegate = self;
    _tableVR.dataSource = self;
    [self.scrollV addSubview:_tableVR];
    
    [_tableVR registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"VRcell"];
    
    UIView *viewHR = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, newCellHeight)];
    _tableVR.tableHeaderView = viewHR;
    [viewHR release];
    
    
   self.titleR = [[BaseLabel alloc]initWithFrame:CGRectMake(newCellHeight / 100 * 40, newCellHeight / 10, myWidth - newCellHeight / 100 * 80, newCellHeight / 2)];
    _titleR.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont / 18 * 20];
    _titleR.numberOfLines = 0;
    [viewHR addSubview:_titleR];
    
    _timeR = [[BaseLabel alloc]initWithFrame:CGRectMake(newCellHeight / 2, _titleL.frame.origin.y + _titleL.frame.size.height , myWidth - newCellHeight, newCellHeight / 100 * 40)];
    _timeR.font = [UIFont fontWithName:@"Helvetica" size:Videofont / 18 * 14];
    [viewHR addSubview:_timeR];
    [_timeR release];
    

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableVZ == tableView) {
        return 0;
    }
    return newCellHeight;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    _webView.frame = CGRectMake(0,newCellHeight, myWidth, height);
    _tableVZ.tableFooterView = _webView;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollV == scrollView) {
        
    
    NSInteger path = scrollView.contentOffset.x / myWidth;
    if (path != _liuView.defaultIndex - 1) {
        _liuView.defaultIndex = path + 1;
    }
    }
}
- (void)getDateVideoInfo:(VideoInfo *)videoInfo
{
    [[DataBaseHandle shareDataBase] openDB];
    [[DataBaseHandle shareDataBase] createTableVideoName:@"historyVideo"];
    [[DataBaseHandle shareDataBase] insertVideoDataWithName:@"historyVideo" video:videoInfo];
    [[DataBaseHandle shareDataBase] closeDB];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (1 != _infoDic.allKeys.count) {
     VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc]init];
    if (_tableVL == tableView) {

        VideoIn *videoIn = [_dic objectForKey:_videoU.jijin_url];
        videoPlayVC.videoInfo = [videoIn.VideoArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:videoPlayVC animated:YES];
        [self getDateVideoInfo:[videoIn.VideoArr objectAtIndex:indexPath.row]];
    }
    else if (_tableVR == tableView) {
        VideoIn *videoIn = [_dic objectForKey:_videoU.luxiang_url];
        videoPlayVC.videoInfo = [videoIn.VideoArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:videoPlayVC animated:YES];
        [self getDateVideoInfo:[videoIn.VideoArr objectAtIndex:indexPath.row]];
    } else {
        
    }
    
    [videoPlayVC release];
     }
     else {
         NSArray *arr = [[NSArray alloc] init];
         arr = [_infoDic objectForKey:@"V"];
         VideoInfo *videoInfo = [arr objectAtIndex:indexPath.row];
         VideoPlayViewController *videoPlayVC = [[VideoPlayViewController alloc]init];
         videoPlayVC.videoInfo = videoInfo;
         [self.navigationController pushViewController:videoPlayVC animated:YES];
         [self getDateVideoInfo:videoInfo];
         [videoPlayVC release];
 
     }
}
#warning 某一分区下的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (1 != _infoDic.allKeys.count) {
    if (_tableVL == tableView) {
        VideoIn *videoIn = [_dic objectForKey:_videoU.jijin_url];
        return videoIn.VideoArr.count;
    }
    else if (_tableVR == tableView) {
        VideoIn *videoIn = [_dic objectForKey:_videoU.luxiang_url];
        return videoIn.VideoArr.count;
    } else {
        return 1;
    }
    }
    else
    {
    NSArray *arr = [_infoDic objectForKey:@"V"];
    return arr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (1 != _infoDic.allKeys.count) {
    if (_tableVL == tableView) {
    VideoTableViewCell *cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VLcell"];
    VideoIn *videoIn = [_dic objectForKey:_videoU.jijin_url];
    VideoInfo *videoInfo = [videoIn.VideoArr objectAtIndex:indexPath.row];
         [cell.imageV sd_setImageWithURL:[NSURL URLWithString:videoInfo.img] placeholderImage:[UIImage imageNamed:backImage]];
//    cell.label1.attributedText = [BackgrountViewController Html:videoInfo.name];
        cell.label1.text = [BackgrountViewController Html:videoInfo.name].string;
    cell.label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont];
    return cell;
    }  else if (_tableVR == tableView) {
        VideoTableViewCell *cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VRcell"];
        VideoIn *videoIn = [_dic objectForKey:_videoU.luxiang_url];
        VideoInfo *videoInfo = [videoIn.VideoArr objectAtIndex:indexPath.row];
         [cell.imageV sd_setImageWithURL:[NSURL URLWithString:videoInfo.img] placeholderImage:[UIImage imageNamed:backImage]];
//        cell.label1.attributedText = [BackgrountViewController Html:videoInfo.name];
        cell.label1.text = [BackgrountViewController Html:videoInfo.name].string;
        cell.label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont];
        return cell;
    } else {
        UITableViewCell *cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        return cell;
    }
  } else
  {
      VideoTableViewCell *cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
      NSArray *arr = [[NSArray alloc] init];
      arr = [_infoDic objectForKey:@"V"];
      VideoInfo *videoInfo = [arr objectAtIndex:indexPath.row];
       [cell.imageV sd_setImageWithURL:[NSURL URLWithString:videoInfo.img] placeholderImage:[UIImage imageNamed:backImage]];
//      cell.label1.attributedText = [BackgrountViewController Html:videoInfo.name];
      cell.label1.text = [BackgrountViewController Html:videoInfo.name].string;
      cell.label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:Videofont];
      return cell;

  }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getDate
{
  if (1 != _infoDic.allKeys.count) {
         
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970] * 1000;
    long T = time;
    VideoI *videoI = [[VideoI alloc] init];
    videoI = [_infoDic objectForKey:@"U"];
    NSArray *urlArr = [NSArray array];
   
      urlArr = @[videoI.jijin_url, videoI.zhanbao_url, videoI.luxiang_url];
        for (NSString *url in urlArr) {
            AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
            [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
            
            NSString *urlStr = [NSString stringWithFormat:@"http://m.zhibo8.cc/m/android/json%@?aabbccddeeff=%ld", url, T];
            if ([videoI.zhanbao_url isEqualToString:url]) {
                urlStr = [NSString stringWithFormat:@"http://m.zhibo8.cc/news/android/json%@?aabbccddeeff=%ld", url, T];
            }
            [man GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                VideoIn *videoIn = [[VideoIn alloc] init];
                [videoIn setValuesForKeysWithDictionary:responseObject];
                if ([videoI.jijin_url isEqualToString:url] || [videoI.luxiang_url isEqualToString:url]) {
                    for (NSDictionary *dic in videoIn.channel) {
                        VideoInfo *videoInfo = [[VideoInfo alloc] init];
                        [videoInfo setValuesForKeysWithDictionary:dic];
                        [videoIn.VideoArr addObject:videoInfo];
                    }
                }
                
                
                
                [_dic setObject:videoIn forKey:url];
                if ([videoI.jijin_url isEqualToString:url]) {
                    VideoIn *video = [_dic objectForKey:_videoU.jijin_url];
                    _titleL.text = video.title;
                    _timeL.text = video.createtime;
                    [_tableVL reloadData];
                } else if ([videoI.luxiang_url isEqualToString:url]) {
                    VideoIn *video = [_dic objectForKey:_videoU.luxiang_url];
                    _titleR.text = video.title;
                    _timeR.text = video.createtime;
                    [_tableVR reloadData];
                } else if ([videoI.zhanbao_url isEqualToString:url]){
                    VideoIn *video = [_dic objectForKey:_videoU.zhanbao_url];
                    _titleLZ.text = video.title;
                    _timeLZ.text = video.createtime;
                    [_webView loadHTMLString:video.content baseURL:nil];
                    [_tableVZ reloadData];
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
                
            }];
         }
    }
    else {
        if ([@"jijin" isEqualToString:[self.userD objectForKey:@"offset"]]) {
            _titleL.text = self.title;
            _timeL.text = _createtime;
        } else {
            _titleR.text = self.title;
            _timeR.text = _createtime;
        }
    }
    
        
   
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
