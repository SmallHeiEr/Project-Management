//
//  RootViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RootViewController.h"
//4个VC
#import "NewViewController.h"
#import "VideoViewController.h"
#import "PhotoViewController.h"
#import "NearViewController.h"
//侧边栏VC
#import "SideViewController.h"

@interface RootViewController ()
@property (nonatomic, retain)UITabBarController *rootTBC;
@property (nonatomic, retain)SideViewController *sideVC;
@end

@implementation RootViewController
- (void)dealloc
{
    [_rootTBC release];
    [_sideVC release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rootTBC = [[UITabBarController alloc]init];
    
//    self.rootTBC.tabBar.backgroundColor = [UIColor colorWithRed:0.532 green:1.000 blue:0.895 alpha:1.000];
//    _rootTBC.tabBar.barTintColor =[UIColor colorWithRed:0.759 green:0.752 blue:0.832 alpha:1.000];

    
//    新闻
    NewViewController *newVC = [[NewViewController alloc] init];
    UINavigationController *newNC = [[UINavigationController alloc] initWithRootViewController:newVC];
//    newNC.navigationBar.translucent = NO;
//imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];付个图片并保持原有颜色
    newNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[[UIImage imageNamed:@"new.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"newdianji.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [newNC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
   
   
    
//    视频
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    UINavigationController *videoNC = [[UINavigationController alloc] initWithRootViewController:videoVC];
    videoNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[[UIImage imageNamed:@"shipin.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shipindianji.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [videoNC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
   
//    笑点
    HappyViewController *happyVC = [[HappyViewController alloc] init];
    UINavigationController *happyNC = [[UINavigationController alloc] initWithRootViewController:happyVC];
    happyNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"娱乐" image:[[UIImage imageNamed:@"happy.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"happydianji.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [happyNC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
////    附近
//    NearViewController *nearVC = [[NearViewController alloc] init];
//    UINavigationController *nearNC = [[UINavigationController alloc] initWithRootViewController:nearVC];
//    nearVC.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"附近" image:[UIImage imageNamed:@"near.png"] tag:10004]autorelease];
//    数据
    ReportViewController *reportVC = [[ReportViewController alloc] init];
    UINavigationController *reportNC = [[UINavigationController alloc] initWithRootViewController:reportVC];
    reportNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"数据" image:[[UIImage imageNamed:@"shuju.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"shujudianji.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [reportNC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
     NSArray *rootArr = [[NSArray alloc]initWithObjects:newNC, videoNC, happyNC, reportNC, nil];
    _rootTBC.viewControllers = rootArr;
    [self.view addSubview:_rootTBC.view];
    [_rootTBC release];
//    侧边栏
    self.sideVC = [SideViewController alloc];
    _sideVC.view.frame = CGRectMake(- myWidth, 0, myWidth, myHeight);
    [self addChildViewController:_sideVC];
    [_sideVC.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_sideVC.view];
    [_sideVC release];
//    边缘手势
    UIScreenEdgePanGestureRecognizer *screenGR = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenAction:)];
    screenGR.edges = UIRectEdgeLeft;
    [_rootTBC.view addGestureRecognizer:screenGR];
    [screenGR release];
//    设置轻拍手势
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    
//    [self.sideVC.view addGestureRecognizer:tapGR];
//    [tapGR release];
    
    
    
    
    
    
}
- (void)buttonAction
{
    [UIView animateWithDuration:1.0 animations:^{
        _rootTBC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _sideVC.view.frame = CGRectMake(- myWidth, 0, myWidth, myHeight);
        _rootTBC.view.userInteractionEnabled = YES;

    }];
}


- (void)screenAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (UIGestureRecognizerStateEnded == sender.state) {
        NSLog(@"边缘手势");
        [UIView animateWithDuration:1.0 animations:^{
            
            _sideVC.view.frame = CGRectMake(- myWidth + sideSideWidth, 0, myWidth, myHeight);
            _rootTBC.view.frame = CGRectMake(sideSideWidth, 0, myWidth, myHeight);
            _rootTBC.view.userInteractionEnabled = NO;
        }];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
