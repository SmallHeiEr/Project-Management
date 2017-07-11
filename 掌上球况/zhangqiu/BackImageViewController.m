//
//  BackImageViewController.m
//  zhangqiu
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "BackImageViewController.h"

@interface BackImageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain)UICollectionView *collectionV;
@end

@implementation BackImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"背景图片";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)]autorelease];
    
    
    UICollectionViewFlowLayout *flowl = [[[UICollectionViewFlowLayout alloc]init]autorelease];
    
    
    //    最小行间距  //垂直于滚动方向的叫做行
    flowl.minimumLineSpacing = sWidth * 100;
    //    最小列间距
    flowl.minimumInteritemSpacing = sWidth * 20;
    //    单元大小
    flowl.itemSize = CGSizeMake(sWidth * 150, sWidth * 240);

    //    与屏幕四边的距离
    flowl.sectionInset = UIEdgeInsetsMake(sWidth * 100, sWidth * 20, sWidth * 50, sWidth * 20);
    //    滚动方向
    flowl.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.collectionV = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowl];
    
    self.collectionV.backgroundColor = [UIColor clearColor];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self.view addSubview:self.collectionV];
    [self.collectionV release];
    
    //    注册cell（重用）
    [self.collectionV registerClass:[BackImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    if (0 == indexPath.item) {
        
        [userD setObject:@"black" forKey:@"BackImage"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"black" object:nil];
    } else if (1 == indexPath.item) {
        [userD setObject:@"normal" forKey:@"BackImage"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"normal" object:nil];
    }

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BackImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor yellowColor];
    if (0 == indexPath.item) {
        cell.imageV.image = [UIImage imageNamed:@"BlackBackImage.jpg"];
        cell.label.text = @"黑色复古花纹";
    } else if (1 == indexPath.item) {
        cell.imageV.image = [UIImage imageNamed:@"WhiteBackImage.jpg"];
        cell.label.text = @"白色复古花纹";
    }
    
    return cell;
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
