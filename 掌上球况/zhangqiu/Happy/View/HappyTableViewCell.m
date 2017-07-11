//
//  HappyTableViewCell.m
//  zhangqiu
//
//  Created by dllo on 16/3/30.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "HappyTableViewCell.h"




@implementation HappyTableViewCell
- (void)dealloc
{

    [_label release];
    [_imageV release];
    [_buttonL release];
    [_buttonR release];
    [_playView release];
    [_imageT release];
    [_happy release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
    }
    return self;
}
- (void)createSubViews
{
    self.label = [[BaseLabel alloc] init];
    [self.contentView addSubview:_label];
   
    _label.font = [UIFont systemFontOfSize:Videofont];
    _label.numberOfLines = 0;
    [_label release];
    
    self.imageV = [[UIImageView alloc]init];
    _imageV.layer.masksToBounds = YES;
    _imageV.layer.cornerRadius = cornerR;
    [self.contentView addSubview:_imageV];
    [_imageV release];
    
    self.imageT = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_imageT];
    _imageT.image = [UIImage imageNamed:@"iconfont-iconkaishi (1).png"];
    [_imageT release];
    
    
    self.buttonL = [BaseButton buttonWithType:UIButtonTypeSystem];
    [_buttonL setTitle:@"分享" forState:UIControlStateNormal];

    [_buttonL addTarget:self action:@selector(buttonLAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_buttonL];

    self.buttonR = [BaseButton buttonWithType:UIButtonTypeSystem];
    [_buttonR setTitle:@"收藏" forState:UIControlStateNormal];
    [_buttonR addTarget:self action:@selector(buttonRAction) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:_buttonR];
}

- (void)layoutSubviews
{
    [super layoutSubviews];


}
- (void)getImageHappy:(Happy *)happy
{
//    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:Videofont]);
    NSNumber *height = [happy.image objectForKey:@"height"];
    NSNumber *width = [happy.image objectForKey:@"width"];
   _imageV.frame =CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2 + _label.frame.size.height + newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue]);
    
     _buttonL.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
     _buttonR.frame = CGRectMake(myWidth / 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
//    赋值
   _label.text = happy.text;
    NSMutableArray *arr = [NSMutableArray array];
    arr =[happy.image objectForKey:@"big"];
    [_imageV sd_setImageWithURL:arr.firstObject placeholderImage:[UIImage imageNamed:backImage]];
}
- (void)getVideoHappy:(Happy *)happy
{
    //    坐标
  _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:Videofont]);
    NSNumber *height = [happy.video objectForKey:@"height"];
    NSNumber *width = [happy.video objectForKey:@"width"];
    _imageV.frame =CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2 + _label.frame.size.height + newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue]);
    _imageT.frame = CGRectMake(myWidth / 2 - sideCellHeight / 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height / 2 - sideCellHeight / 2, sideCellHeight, sideCellHeight);
    
    _buttonL.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
    _buttonR.frame = CGRectMake(myWidth / 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
    //    赋值
    _label.text = happy.text;
    NSMutableArray *arr = [NSMutableArray array];
    arr =[happy.video objectForKey:@"thumbnail"];
    [_imageV sd_setImageWithURL:arr.firstObject placeholderImage:[UIImage imageNamed:backImage]];
}
- (void)getGifHappy:(Happy *)happy
{
    //    坐标
    _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:Videofont]);
    NSNumber *height = [happy.gif objectForKey:@"height"];
    NSNumber *width = [happy.gif objectForKey:@"width"];
    _imageV.frame =CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2 + _label.frame.size.height + newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [height doubleValue] * (myWidth - newsCellImageLeft * 4) / [width doubleValue]);
    
    _buttonL.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
    _buttonR.frame = CGRectMake(myWidth / 2, newsCellImageLeft * 4 + _label.frame.size.height + _imageV.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);

    //    赋值
    _label.text = happy.text;
    NSMutableArray *arr = [NSMutableArray array];
    arr =[happy.gif objectForKey:@"images"];
    [_imageV sd_setImageWithURL:arr.firstObject placeholderImage:[UIImage imageNamed:backImage]];
}
- (void)getTextHappy:(Happy *)happy
{
//    坐标
   _label.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2, myWidth - newsCellImageLeft * 4, [BackgrountViewController getHeightWithStr:happy.text width:(myWidth - newsCellImageLeft * 4) fontSize:Videofont]);
    _buttonL.frame = CGRectMake(newsCellImageLeft * 2, newsCellImageLeft * 2 + _label.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
    _buttonR.frame = CGRectMake(myWidth / 2, newsCellImageLeft * 2 + _label.frame.size.height + newsCellImageLeft * 2, (myWidth - newsCellImageLeft * 4) / 2, liuHeight);
    //    赋值
    _label.text = happy.text;

}
//
- (void)buttonLAction
{
    NSString *str = [NSString stringWithFormat:@"%@    %@", _happy.text, _happy.share_url];
    NSArray* imageArray = [NSArray array];
    if (_happy.video != nil) {
        NSMutableArray *arr = [NSMutableArray array];
        arr =[_happy.video objectForKey:@"thumbnail"];
        str = [NSString stringWithFormat:@"%@    %@", _happy.text, [[_happy.video objectForKey:@"video"] firstObject]];
        imageArray = @[arr.firstObject];
    } else if (_happy.image != nil) {
        
        NSMutableArray *arr = [NSMutableArray array];
        arr =[_happy.video objectForKey:@"big"];
        str = [NSString stringWithFormat:@"%@", _happy.text];
        imageArray = @[arr.firstObject];
    } else if (_happy.gif != nil) {
        NSMutableArray *arr = [NSMutableArray array];
        arr =[_happy.video objectForKey:@"images"];
        str = [NSString stringWithFormat:@"%@", _happy.text];
        imageArray = @[arr.firstObject];
    } else {
        str = [NSString stringWithFormat:@"%@", _happy.text];
    }
   
    
//        NSArray* imageArray = @[[UIImage imageNamed:@"head1.png"]];
        //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
   
//        NSString *str = [[self.i description] substringToIndex:3];
//        NSArray* imageArray = @[[NSString stringWithFormat: @"http://pimg.damai.cn/perform/project/%@/%@_n.jpg", str, self.i]];
        //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
        if (str.length != 0) {
            
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:str
                                             images:imageArray
                                                url:[NSURL URLWithString:@"http://mob.com"]
                                              title:@"精彩不容错过"
                                               type:SSDKContentTypeAuto];
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               default:
                                   break;
                           }
                       }
             ];}
    
}

- (void)buttonRAction
{
    [[DataBaseHandle shareDataBase] openDB];
    
    NSMutableArray *arr = [NSMutableArray array];
    arr = [[DataBaseHandle shareDataBase] selectHappyName:@"favoriteHappy" Text: _happy.text];
    if (0 == arr.count) {
        [[DataBaseHandle shareDataBase] createTableHappyName:@"favoriteHappy"];
        [[DataBaseHandle shareDataBase] insertDataWithName:@"favoriteHappy" Happy:_happy];
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"请到我的收藏查看" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:alert2];
        [[self viewController] presentViewController:alert1 animated:YES completion:nil];
    } else {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"已收藏" message:@"请不要重复收藏" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:alert2];
        [[self viewController] presentViewController:alert1 animated:YES completion:nil];
    }
    [[DataBaseHandle shareDataBase] closeDB];
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
