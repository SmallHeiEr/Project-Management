//
//  AppDelegate.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//


#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()
@property (nonatomic, retain) UIScrollView *scrollV;
@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [_window release];
    RootViewController *rootVC = [RootViewController alloc];
    _window.rootViewController = rootVC;
    [rootVC release];
  
    
    [ShareSDK registerApp:@"75587fd0177b4c9270723f7b7517a665"
     
     
     
     
     //     @(SSDKPlatformTypeRenren)
     //     @(SSDKPlatformTypeGooglePlus)
     //     @(SSDKPlatformTypeSMS)
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 //             case SSDKPlatformTypeRenren:
                 //                 [ShareSDKConnector connectRenren:[RennClient class]];
                 //                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
                
             default:
                 break;
         }
     }];
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    if (nil == [userD objectForKey:@"isFirst"]) {
        
   
//    static BOOL isFirst = YES;
    
    
    self.scrollV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollV.pagingEnabled = YES;
    _scrollV.bounces = NO;

   
    //    self.scrollV.backgroundColor = [UIColor greenColor];
    self.scrollV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth * i, 0, myWidth, myHeight)];
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%ld.jpg", i]];
        [self.scrollV addSubview:imageV];
        [imageV release];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"> > > > > >" forState:UIControlStateNormal];
        button.frame = CGRectMake((myWidth - sWidth * 200) / 2 + myWidth * i, myHeight - sHeight * 150, sWidth * 200, sHeight * 50);
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIButton *tiaoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [tiaoButton setTitle:@"跳过" forState:UIControlStateNormal];
        tiaoButton.frame = CGRectMake((myWidth - sWidth * 100) + myWidth * i, sHeight * 50, sWidth * 60, sHeight * 30);
        tiaoButton.layer.masksToBounds = YES;
        tiaoButton.layer.cornerRadius = tiaoButton.frame.size.height / 2;
        [tiaoButton addTarget:self action:@selector(tiaoButton) forControlEvents:UIControlEventTouchUpInside];
        tiaoButton.backgroundColor = [UIColor colorWithRed:0.204 green:0.186 blue:0.287 alpha:1.000];
        [tiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.scrollV addSubview:tiaoButton];
        [self.scrollV addSubview:button];
    }
    [self.window addSubview:self.scrollV];
  
    [userD setObject:@"ss" forKey:@"isFirst"];
    
     }
    
    
    
    
    
    
    
    
    
    return YES;
    
    
    
    //找Window
//    UIWindow *wi = [UIApplication sharedApplication].keyWindow;

    
    
    
    
}
- (void)tiaoButton
{
    [self.scrollV removeFromSuperview];
}
- (void)buttonAction
{
    static NSInteger index = 1;
    if (index == 3) {
        
        [self.scrollV removeFromSuperview];
        NSLog(@"wwwwww");
    }
    self.scrollV.contentOffset = CGPointMake(myWidth * index, 0);
    index++;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DataBaseHandle shareDataBase] closeDB];
}

@end
