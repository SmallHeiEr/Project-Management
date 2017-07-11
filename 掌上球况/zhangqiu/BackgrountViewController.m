//
//  BackgrountViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BackgrountViewController.h"

@interface BackgrountViewController ()

@property (nonatomic, retain)UIImageView *backImageV;
@end

@implementation BackgrountViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"normal" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"black" object:nil];
    [_backImageV release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.backImageV = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.backImageV];

    
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *back = [userD objectForKey:@"BackImage"];
    if (back.length == 0) {
         self.backImageV.image = [UIImage imageNamed:@"BlackBackImage.jpg"];
//        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3674655820958112895.jpg"] forBarMetrics:UIBarMetricsDefault];

        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
    }
    
    
    if ([@"black" isEqualToString:back]) {
       self.backImageV.image = [UIImage imageNamed:@"BlackBackImage.jpg"];
//        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3674655820958112895.jpg"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }  else {
        self.backImageV.image = [UIImage imageNamed:@"WhiteBackImage.jpg"];
//        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"WhiteBackImage.jpg"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]}];
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];
    
    
   
    
    
   
}
- (void)blackAction
{
   self.backImageV.image = [UIImage imageNamed:@"BlackBackImage.jpg"];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3674655820958112895.jpg"] forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]}];
}
- (void)normalAction
{

    self.backImageV.image = [UIImage imageNamed:@"WhiteBackImage.jpg"];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"WhiteBackImage.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]}];
}
+ (CGFloat)getHeightWithStr:(NSString *)str width:(CGFloat)width fontSize:(CGFloat)size
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName] context:nil];
    return rect.size.height;
}

//HTML数据转为NSAttributedString
+ (NSAttributedString *)Html:(NSString *)string
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attributedString;
    
}
//一个时间距现在的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else {
        timeString = @"60分钟前";
    }
    [date release];
    return timeString;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}
+ (void)getAlertWithTitle:(NSString *)title message:(NSString *)massage buttonLeft:(NSString *)buttonL leftBlock:(void(^)(UIAlertAction * _Nonnull action))actL buttonRight:(NSString *)buttonR leftBlock:(void(^)(UIAlertAction * _Nonnull action))actR vc:(UIViewController *)vc time:(NSTimeInterval)time
{
    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    if (0 != buttonL.length) {
     UIAlertAction *alert2 = [UIAlertAction actionWithTitle:buttonL style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         if (nil != actL) {
             actL(action);
             
         }
    }];
        [alert1 addAction:alert2];
    }
    if (0 != buttonR.length) {
    UIAlertAction *alert3 = [UIAlertAction actionWithTitle:buttonR style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (nil != actR) {
            actR(action);

        }
    }];
    [alert1 addAction:alert3];
    }
        [vc presentViewController:alert1 animated:YES completion:^{
            if (MAXFLOAT != time) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alert1 dismissViewControllerAnimated:YES completion:nil];
               });
            }
        }];
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
