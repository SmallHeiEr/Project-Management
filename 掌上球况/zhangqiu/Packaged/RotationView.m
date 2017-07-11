#//
//  RotationView.m
//  zhangqiu
//
//  Created by dllo on 16/3/22.
//  Copyright © 2016年 dllo. All rights reserved.
//
#define myWidth ([UIScreen mainScreen].bounds.size.width)
#import "RotationView.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@interface RotationView ()<UIScrollViewDelegate>


@property (nonatomic, retain)UIScrollView *scrollV;
@property (nonatomic, retain)UIPageControl *pageC;
@property (nonatomic, retain)NSTimer *timer;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, retain)UIImageView *imageV;
@end
@implementation RotationView
- (void)dealloc
{
    Block_copy(_goodBlock);
    [_rotationArr release];
    [_rotationCV release];
    [_pageC release];
    [_timer release];
    [_imageV release];
    [_scrollV release];
    [super dealloc];
}


- (void)createSubviews
{
    
    self.scrollV = [[UIScrollView alloc]initWithFrame:self.frame];
//    self.imageV = [[UIImageView alloc]initWithFrame:self.frame];
//    [self addSubview:self.imageV];
//    [self.imageV release];
    _scrollV.pagingEnabled = YES;
    _scrollV.contentOffset = CGPointMake(myWidth, 0);
    _scrollV.contentSize = CGSizeMake(myWidth * (_rotationArr.count + 2), self.frame.size.height);
    [self addSubview:_scrollV];
    [_scrollV release];
   _scrollV.delegate = self;
    for (NSInteger i = 0; i < _rotationArr.count + 2; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(myWidth * i, 0, myWidth, self.frame.size.height)];
        [_scrollV addSubview:imageV];
        [imageV release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(myWidth * i + 5, self.frame.size.height / 10 * 8, myWidth / 4 * 3 - 10, self.frame.size.height / 10 * 2)];
        label.textColor = [UIColor whiteColor];
        [_scrollV addSubview:label];
        [label release];
        
        
        
        News *new = [[News alloc]init];
        
        if (0 == i) {
            new = [_rotationArr objectAtIndex:_rotationArr.count - 1];
        } else if (_rotationArr.count + 1 == i) {
            new = [_rotationArr objectAtIndex:0];
        }
        else {
            new = [_rotationArr objectAtIndex:i - 1];
        }
        label.text = new.title;
//        轮播图图片
        [imageV sd_setImageWithURL:[NSURL URLWithString:new.imgsrc] placeholderImage:[UIImage imageNamed:backImage]];
        
//        NSString *str = [NSString stringWithFormat:@"image%ld.jpg", i];
      
       
    }
    
    //页面标签pageC
    self.pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(myWidth / 4 * 3, self.frame.origin.y + self.frame.size.height / 10 * 8, myWidth / 4, self.frame.size.height / 10 * 2)];
    _pageC.numberOfPages = self.rotationArr.count;
    [_pageC addTarget:self action:@selector(pageCAction) forControlEvents:UIControlEventValueChanged];
      //    未选中颜色
    _pageC.pageIndicatorTintColor = [UIColor colorWithWhite:0.900 alpha:1.000];
      //    当前选中颜色
    _pageC.currentPageIndicatorTintColor = [UIColor redColor];
     [self addSubview:self.pageC];
    [_pageC release];
    _pageIndex = 1;
//时间停止
    if (_timer == nil) {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(getChange) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//单击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
    [_scrollV addGestureRecognizer:tapGesture];
}
//单击手势
- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
//    block传值
//    self.goodBlock(_pageIndex - 1);
    
    
//    NSLog(@"点击了第%ld个",(long)_pageIndex);
    News *news = [_rotationArr objectAtIndex:_pageIndex - 1];

   //    体育轮播图详情
    if (3 == _rotationArr.count) {
        SportInfoViewController *lunIVC = [[SportInfoViewController alloc]init];
        
        lunIVC.news = news;
//        NSLog(@"%@", lunIVC.news.url);
        [[self viewController].navigationController pushViewController:lunIVC animated:YES];        //        [sportIVC.tableView reloadData];
        [lunIVC release];
//        足球轮播图详情
    } else if ([@"zuqiu" isEqualToString:news.type]){
        FootInfoViewController *footIVC = [[FootInfoViewController alloc] init];
        footIVC.news = news;
        [[self viewController].navigationController pushViewController:footIVC animated:YES];
        [footIVC release];
//         NBA轮播图详情
    } else {
        NBAInfoViewController *NBAIVC = [[NBAInfoViewController alloc] init];
        NBAIVC.news = news;
         [[self viewController].navigationController pushViewController:NBAIVC animated:YES];
        [NBAIVC release];

    }
    
    

}

- (void)getChange
{
    CGPoint newOffset = CGPointMake(_scrollV.contentOffset.x + myWidth, 0);
    [_scrollV setContentOffset:newOffset animated:YES];
    
    
}

- (void)pageCAction
{
    [_scrollV setContentOffset:CGPointMake(myWidth * _pageC.currentPage + 1, 0) animated:YES];
    
}
//不管是自动循环还是用户拖动，都会来到这个方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
//    NSLog(@"next，当前页:%lu",(unsigned long)self.pageC.currentPage);
    if (scrollView == _scrollV) {
        NSInteger Page =  scrollView.contentOffset.x / myWidth;
        if (0 == Page) {
            Page = _rotationArr.count - 1;
            scrollView.contentOffset = CGPointMake(myWidth * _rotationArr.count - 1, 0);

        } else if (_rotationArr.count + 1 == Page) {
            Page = 1;
            scrollView.contentOffset = CGPointMake(myWidth * 1, 0);
//            NSLog(@"next，当前页:%lu",(unsigned long)self.pageC.currentPage);
        }
        if (Page != _pageIndex) {
            
            _pageC.currentPage = Page - 1;
            _pageIndex = Page;
        }
    }
}
#pragma mark -
#pragma mark - UIScrollViewDelegate
//用户拖动scrollView的时候会调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
//    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    if (_timer == nil) {
     _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(getChange) userInfo:nil repeats:YES];
    }
//    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:4.0]];
}
//  在view中获取controller的方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
     
@end
