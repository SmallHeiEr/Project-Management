//
//  playViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "playViewController.h"

@interface playViewController ()
@property (nonatomic, retain)MPMoviePlayerViewController *playerVC;
@property (nonatomic, retain) MPMoviePlayerController *player;

@end

@implementation playViewController
- (void)dealloc
{

    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.playUrl]];
    [self.player play];
    
    CGFloat Hei = [_height doubleValue] * (myWidth - newsCellImageLeft * 4) / [_width doubleValue];
    self.player.view.frame= CGRectMake(newsCellImageLeft * 2, (myHeight - Hei) / 2, myWidth - newsCellImageLeft * 4, Hei);
    
    [self.view addSubview:self.player.view];
   self.player.controlStyle = MPMovieControlStyleFullscreen;
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    
    
    UIButton *ret = [UIButton buttonWithType:UIButtonTypeSystem];
    ret.frame = CGRectMake(0, 20, 40, 40);
    [ret setBackgroundImage:[UIImage imageNamed:@"fanhui (3).png"] forState:UIControlStateNormal];
    
    [ret addTarget:self action:@selector(retAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ret];
    
    
}
- (void)retAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    [self.player pause];
}
//- (void)movieFinishedCallback:(NSNotification *)notify
//{
//    MPMoviePlayerController *player = [notify object];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
//    [player stop];
//    [player.view removeFromSuperview];
//    [player autorelease];
//    
//}

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
