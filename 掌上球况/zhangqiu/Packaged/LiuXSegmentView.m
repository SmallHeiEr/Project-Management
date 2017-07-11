

#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

#import "LiuXSegmentView.h"

@interface LiuXSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,assign) CGFloat btn_w;

@end

@implementation LiuXSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"normal" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"black" object:nil];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        
    self.backgroundColor = [UIColor clearColor];
    self.line.backgroundColor = [UIColor clearColor];
    self.bgScrollView.backgroundColor = [UIColor clearColor];
    self.titleBtn.backgroundColor = [UIColor clearColor];
    self.selectLine.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *back = [userD objectForKey:@"BackImage"];
    
    if (back.length == 0) {
        _titleNomalColor=[UIColor whiteColor];
        _titleSelectColor=SFQRedColor;
    }
    
    if ([@"black" isEqualToString:back]) {
        _titleNomalColor=[UIColor whiteColor];
        _titleSelectColor=SFQRedColor;
    }
    else {
        _titleNomalColor=[UIColor blackColor];
        _titleSelectColor=SFQRedColor;
    }
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];

    
    
    
    
        
        _btn_w = 0.0;
        if (titleArray.count<MAX_TitleNumInWindow+1) {
            _btn_w = windowContentWidth/titleArray.count;
        }else{
            _btn_w = windowContentWidth/MAX_TitleNumInWindow;
            
        }
        _titles=titleArray;
        _defaultIndex = 1;
        _titleFont=[UIFont systemFontOfSize:Videofont / 18 * 15];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
//        _titleNomalColor=[UIColor blackColor];
//        _titleSelectColor=SFQRedColor;
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
//        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator= NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
        [self addSubview:_bgScrollView];
        
        
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonTag:) name:@"我是button" object:nil];
        
        /////
       self.line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - sWidth, _btn_w*titleArray.count , sWidth)];
        
//        self.line.backgroundColor=[UIColor lightGrayColor];
        
        [_bgScrollView addSubview:_line];
        
        //线
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(sWidth * 10 , self.frame.size.height - sWidth * 8, _btn_w - sWidth * 22, sWidth * 2)];
        _selectLine.backgroundColor=_titleSelectColor;
        [_bgScrollView addSubview:_selectLine];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            //字框
            
            btn.frame=CGRectMake(_btn_w * i + sWidth * 10, sWidth * 5, _btn_w - sWidth * 22, self.frame.size.height - sWidth * 13);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            //背景框颜色
            [btn setBackgroundColor:[UIColor clearColor]];
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
            }
            self.block=block;
            
        }

    }
    
    return self;
}
- (void)getDateArr:(NSArray *)titleArray clickBlick:(btnClickBlock)block
{
    self.backgroundColor = [UIColor clearColor];
    self.line.backgroundColor = [UIColor clearColor];
    self.bgScrollView.backgroundColor = [UIColor clearColor];
    self.titleBtn.backgroundColor = [UIColor clearColor];
    self.selectLine.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *back = [userD objectForKey:@"BackImage"];
    
    if (back.length == 0) {
        _titleNomalColor=[UIColor whiteColor];
        _titleSelectColor=SFQRedColor;
    }
    
    if ([@"black" isEqualToString:back]) {
        _titleNomalColor=[UIColor whiteColor];
        _titleSelectColor=SFQRedColor;
    }
    else {
        _titleNomalColor=[UIColor blackColor];
        _titleSelectColor=SFQRedColor;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackAction) name:@"black" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(normalAction) name:@"normal" object:nil];
    
    
    
    
    
    
    _btn_w = 0.0;
    if (titleArray.count<MAX_TitleNumInWindow+1) {
        _btn_w = windowContentWidth/titleArray.count;
    }else{
        _btn_w = windowContentWidth/MAX_TitleNumInWindow;
        
    }
    _titles=titleArray;
    _defaultIndex = 1;
    _titleFont=[UIFont systemFontOfSize:Videofont / 18 * 15];
    _btns=[[NSMutableArray alloc] initWithCapacity:0];
    //        _titleNomalColor=[UIColor blackColor];
    //        _titleSelectColor=SFQRedColor;
    _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
    //        _bgScrollView.backgroundColor = [UIColor whiteColor];
    _bgScrollView.showsHorizontalScrollIndicator= NO;
    _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
    [self addSubview:_bgScrollView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonTag:) name:@"我是button" object:nil];
    
    /////
    self.line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - sWidth, _btn_w*titleArray.count , sWidth)];
    
    //        self.line.backgroundColor=[UIColor lightGrayColor];
    
    [_bgScrollView addSubview:_line];
    
    //线
    _selectLine=[[UIView alloc] initWithFrame:CGRectMake(sWidth * 10 , self.frame.size.height - sWidth * 8, _btn_w - sWidth * 22, sWidth * 2)];
    _selectLine.backgroundColor=_titleSelectColor;
    [_bgScrollView addSubview:_selectLine];
    
    for (int i=0; i<titleArray.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        //字框
        
        btn.frame=CGRectMake(_btn_w * i + sWidth * 10, sWidth * 5, _btn_w - sWidth * 22, self.frame.size.height - sWidth * 13);
        btn.tag=i+1;
        btn.titleLabel.font = [UIFont systemFontOfSize:Videofont / 18 * 14];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        //背景框颜色
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.titleLabel.font=_titleFont;
        [_bgScrollView addSubview:btn];
        [_btns addObject:btn];
        if (i==0) {
            _titleBtn=btn;
            btn.selected=YES;
        }
        self.block=block;
        
    }

}
- (void)blackAction
{
    self.titleNomalColor=[UIColor whiteColor];
    self.titleSelectColor=SFQRedColor;
}
- (void)normalAction
{
    self.titleNomalColor=[UIColor blackColor];
   self.titleSelectColor=SFQRedColor;
}



//button处理方法
-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
        NSLog(@"$$$$$$$%ld", _defaultIndex);
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height - sWidth * 8, btn.frame.size.width , sWidth * 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}


//改变最低层线的颜色
- (void)setBottomSidelineColor:(UIColor *)color
{
    self.line.backgroundColor = color;

}

-(void)updateView{
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        btn.backgroundColor = [UIColor clearColor];
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            
            
            //线随btn动
            //计算偏移量
            CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
            if (offsetX<0) {
                offsetX=0;
            }
            CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
            if (offsetX>maxOffsetX) {
                offsetX=maxOffsetX;
            }
            
            [UIView animateWithDuration:.2 animations:^{
                
                [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
                _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height - sWidth * 8, btn.frame.size.width , sWidth * 2);
                
            } completion:^(BOOL finished) {
                
            }];
            
            
            
        }else{
            btn.selected=NO;
        }
    }
}

@end
