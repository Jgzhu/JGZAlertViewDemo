//
//  JGZAlertView.m
//  JGZAlertViewDemo
//
//  Created by 江贵铸 on 2017/6/8.
//  Copyright © 2017年 江贵铸. All rights reserved.
//
/*//////////////////本次完成//////////////////////////////////////
 *界面基本完成
 *//////////////////////////////////////////////////////////////

/*//////////////////下次开始//////////////////////////////////////
 *适配屏幕选装：把title和message控件设为全局控件，在layoutSubviews里面计算大小
 *自定义按钮控件，写个继承UIButton的子类，工厂方法快速创建
 *//////////////////////////////////////////////////////////////
#import "JGZAlertView.h"
#define JGZ_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define JGZ_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define JGZ_ThemeColor [UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1]

@interface JGZAlertView ()
@property (nonatomic,strong) UIView *AlertContentView;
@property (nonatomic,strong) NSMutableArray *ActionsArray;
@property (nonatomic,assign) CGFloat MaxHeight;
@property (nonatomic,strong) NSMutableArray *SeparatorLineArray;
@end
@implementation JGZAlertView

-(NSMutableArray *)SeparatorLineArray{
    if (!_SeparatorLineArray) {
        _SeparatorLineArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _SeparatorLineArray;
}
-(NSMutableArray *)ActionsArray{
    if (!_ActionsArray) {
        _ActionsArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _ActionsArray;
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
         self.MaxHeight=100.0;
        //[self noti];
    }
    return self;
}

+(instancetype)AlertViewWithTitle:(NSString *)Title Message:(NSString *)message{
    
    JGZAlertView *AlertView = [[JGZAlertView alloc] initPrivate];
    AlertView.frame = [[UIScreen mainScreen] bounds];
    AlertView.backgroundColor = [UIColor clearColor];
    AlertView.AlertTitle = Title;
    AlertView.AlertMessage = message;
    
    UIView *AlertContentView = [UIView new];
    AlertView.AlertContentView =AlertContentView;
    AlertContentView.backgroundColor = [UIColor whiteColor];
    AlertContentView.bounds = CGRectMake(0, 0, JGZ_SCREEN_WIDTH*0.75, 250);
    AlertContentView.center =AlertView.center;
    AlertContentView.layer.cornerRadius = 10.0;
    AlertContentView.layer.masksToBounds = YES;
    AlertContentView.clipsToBounds=NO;
    AlertContentView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35].CGColor;
    AlertContentView.layer.shadowOpacity = 1.0;
    AlertContentView.layer.shadowOffset = CGSizeMake(0, 0);
    AlertContentView.layer.shadowRadius = 10.0;
    [AlertView addSubview:AlertContentView];
    
    [AlertView CreatSubViews];
    return AlertView;
}
-(void)CreatSubViews{
    UILabel *TitleLabel = [UILabel new];
    TitleLabel.text = self.AlertTitle;
    TitleLabel.textColor =JGZ_ThemeColor;
    TitleLabel.numberOfLines=0;
    TitleLabel.font = [UIFont systemFontOfSize:20];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat TitleLabelX = 20;
    CGFloat TitleLabelY = 20;
    CGFloat TitleLabelW =self.AlertContentView.frame.size.width-TitleLabelX*2;
    CGSize TitleLabelSize = [TitleLabel sizeThatFits:CGSizeMake(TitleLabelW, CGFLOAT_MAX)];
    TitleLabel.frame =CGRectMake(TitleLabelX, TitleLabelY, TitleLabelW, TitleLabelSize.height);
    [self.AlertContentView addSubview:TitleLabel];
    
    UILabel *MessageLabel = [UILabel new];
    MessageLabel.text = self.AlertMessage;
    MessageLabel.textColor =JGZ_ThemeColor;
    MessageLabel.numberOfLines=0;
    MessageLabel.font = [UIFont systemFontOfSize:15];
    MessageLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat MessageLabelX = 20;
    CGFloat MessageLabelY = CGRectGetMaxY(TitleLabel.frame)+10;
    CGFloat MessageLabelW =self.AlertContentView.frame.size.width-MessageLabelX*2;
    CGSize MessageLabelSize = [MessageLabel sizeThatFits:CGSizeMake(MessageLabelW, CGFLOAT_MAX)];
    MessageLabel.frame =CGRectMake(MessageLabelX, MessageLabelY, MessageLabelW, MessageLabelSize.height);
    [self.AlertContentView addSubview:MessageLabel];
    
    self.MaxHeight = CGRectGetMaxY(MessageLabel.frame);
}

-(UIView *)CreatSeparatorLine{
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor=[UIColor colorWithWhite:0.94 alpha:1];
    return lineview;
}
-(void)AddAction:(UIButton *)Button{
    [self.ActionsArray addObject:Button];
    [self.AlertContentView addSubview:Button];
    
    UIView *lineview = [self CreatSeparatorLine];
    [self.AlertContentView addSubview:lineview];
    [self.SeparatorLineArray addObject:lineview];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self UpdateAllButtonFrame];
}

-(void)show{
    [self showAnimation];
}
-(void)showAnimation{
    self.AlertContentView.alpha=0.0;
    self.AlertContentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.AlertContentView.transform = CGAffineTransformIdentity;
        self.AlertContentView.alpha = 1;
    } completion:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)dismissAnimation{
    [UIView animateWithDuration:0.35 animations:^{
       self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.AlertContentView.alpha = 0;
    } completion:^(BOOL finished) {
      [self removeFromSuperview];
    }];
}

-(void)UpdateAllButtonFrame{
    if (self.ActionsArray.count==2) {
        [self UpdateTwoButtonFrame];
    }else{
        [self UpdateOneOrMoreButtonFrame];
    }
    UIButton *LastBtn = [self.ActionsArray lastObject];
    self.MaxHeight=CGRectGetMaxY(LastBtn.frame)==0?self.MaxHeight+10:CGRectGetMaxY(LastBtn.frame);
    CGRect frame=self.AlertContentView.frame;
    frame.size.height=self.MaxHeight;
    self.AlertContentView.frame=frame;
    self.AlertContentView.center = self.center;
}
#pragma mark😂有两个Action按钮时😂
-(void)UpdateTwoButtonFrame{
    for (NSInteger i=0; i<self.ActionsArray.count; i++) {
        UIButton *btn =self.ActionsArray[i];
        btn.userInteractionEnabled=YES;
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame=CGRectMake(self.AlertContentView.bounds.size.width*0.5*i, self.MaxHeight+10, self.AlertContentView.bounds.size.width*0.5, 40);
        if (i==0) {
            [self ClipViewToBouns:btn Corner:UIRectCornerBottomLeft];
        }else if(i==1){
            [self ClipViewToBouns:btn Corner:UIRectCornerBottomRight];
        }
        UIView *lineview = self.SeparatorLineArray[i];
        lineview.frame = CGRectMake(20, self.MaxHeight+10, (self.AlertContentView.frame.size.width-20*2)*i, 0.5);
    }
}
#pragma mark😂有1个或者多于两个Action按钮时😂
-(void)UpdateOneOrMoreButtonFrame{
    self.MaxHeight= self.MaxHeight+10;
    for (NSInteger i=0; i<self.ActionsArray.count; i++) {
        UIButton *btn =self.ActionsArray[i];
        btn.userInteractionEnabled=YES;
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame=CGRectMake(0, self.MaxHeight+40*i, self.AlertContentView.bounds.size.width, 40);
        if (i==self.ActionsArray.count-1) {
            [self ClipViewToBouns:btn Corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
        }
        UIView *lineview = self.SeparatorLineArray[i];
        lineview.frame = CGRectMake(0, self.MaxHeight+40*i, self.AlertContentView.frame.size.width, 0.5);
    }
}
-(void)ClipViewToBouns:(UIView *)view Corner:(UIRectCorner)Corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:Corner cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
-(void)btnclick:(UIButton *)sender{
    NSLog(@"------------");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissAnimation];
}


//-(void)noti{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//}
//
//- (void)statusBarOrientationChange:(NSNotification *)notification{
//    
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
//    if (orientation ==UIInterfaceOrientationLandscapeRight)// home键靠右
//    {
//        //
//    }
//    if (orientation ==UIInterfaceOrientationLandscapeLeft)// home键靠左
//    {
//        
//    }
//    if (orientation ==UIInterfaceOrientationPortrait){
//        
//    }
//    if (orientation ==UIInterfaceOrientationPortraitUpsideDown){
//        
//    }
//    self.MaxHeight=100.0;
//    [self UpdateAllButtonFrame];
//}
//
////注意这种方式监听的是StatusBar也就是状态栏的方向，所以这个是跟你的布局有关的，你的布局转了，才会接到这个通知，而不是设备旋转的通知。当我们关注的东西和布局相关而不是纯粹设备旋转，我们使用上面的代码作为实现方案比较适合。
//
////2.注册UIDeviceOrientationDidChangeNotification通知
//-(void)monitorDevice{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
//}
//- (void)orientChange:(NSNotification *)noti
//{
//    
//    NSDictionary* ntfDict = [noti userInfo];
//    
//    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
//    /*
//     UIDeviceOrientationUnknown,
//     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
//     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
//     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
//     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
//     UIDeviceOrientationFaceUp,              // Device oriented flat, face up
//     UIDeviceOrientationFaceDown             // Device oriented flat, face down   */
//    
//    switch (orient)
//    {
//        caseUIDeviceOrientationPortrait:
//            
//            break;
//        caseUIDeviceOrientationLandscapeLeft:
//            
//            
//            break;
//        caseUIDeviceOrientationPortraitUpsideDown:
//            
//            
//            break;
//        caseUIDeviceOrientationLandscapeRight:
//            
//            
//            break;
//            
//        default:
//            break;
//    }
//}
@end
