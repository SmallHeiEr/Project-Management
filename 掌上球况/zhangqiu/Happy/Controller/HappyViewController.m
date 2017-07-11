//
//  HappyViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//


@interface HappyViewController ()
@property (nonatomic, retain) NSUserDefaults *userD;
@end

@implementation HappyViewController
- (void)dealloc
{
    [_userD release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"请选场!";
    self.userD = [NSUserDefaults standardUserDefaults];
    
    
    UIButton *football = [UIButton buttonWithType:UIButtonTypeSystem];
    football.frame = CGRectMake(0, 0, myWidth, (myHeight - tabBarheight - navigationAppHeight) / 2);
    [football setBackgroundImage:[UIImage imageNamed:@"footballimage1.jpg"] forState:UIControlStateNormal];
    [football addTarget:self action:@selector(footballAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:football];
    
    UIButton *NBA = [UIButton buttonWithType:UIButtonTypeSystem];
    NBA.frame = CGRectMake(0, football.frame.origin.y + football.frame.size.height, myWidth, (myHeight - navigationAppHeight - tabBarheight) / 2);
    [NBA setBackgroundImage:[UIImage imageNamed:@"NBAimage2.jpg"] forState:UIControlStateNormal];
    [NBA addTarget:self action:@selector(NBAAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:NBA];
    
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"体育" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)]autorelease];
    
   
    
   
    
}

- (void)rightAction
{
    SportViewController *sport = [[SportViewController alloc] init];
//    sport.number = @"0";
    [_userD setObject:@"0" forKey:@"index"];
    [self.navigationController pushViewController:sport animated:YES];
    
    [sport.maincollectionV reloadData];
    [sport release];
}
- (void)footballAction
{
    SportViewController *sport = [[SportViewController alloc] init];
//    sport.number = @"1";
    [_userD setObject:@"1" forKey:@"index"];
    [self.navigationController pushViewController:sport animated:YES];
    
    [sport.maincollectionV reloadData];

    [sport release];
}
- (void)NBAAction
{
    SportViewController *sport = [[SportViewController alloc] init];
//    sport.number = @"2";
    [_userD setObject:@"2" forKey:@"index"];
    [self.navigationController pushViewController:sport animated:YES];
    
    [sport.maincollectionV reloadData];

    [sport release];
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
