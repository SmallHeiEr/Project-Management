//
//  NearViewController.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "NearViewController.h"
@interface NearViewController ()
@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    DropDown1 *dd1 = [[DropDown1 alloc] initWithFrame:CGRectMake(10, 10, 140, 100)];
//    dd1.backgroundColor = [UIColor cyanColor];
//    [dd1.textField setTitle:@"全城" forState:UIControlStateNormal];
//    NSArray* arr=[[NSArray alloc]initWithObjects:@"电话",@"email",@"手机",@"aaa",@"bbb",@"ccc",nil];
//    dd1.tableArray = arr;
//    [arr release];
//    [self.view addSubview:dd1];
//    [dd1 release];
    
    NSString *urlFootH = @"http://restapi.amap.com/v3/place/around?key=b9f3c70d61440fa97fae4730e09b13fa&location=121.551019,38.889601&keywords=足球场&types=080105&offset=20&page=1&extensions=all";
    //当网址有未名字符（中文），需要转码
    NSString *urlEncode = [urlFootH stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil]];
    
    [man GET:urlEncode parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
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
