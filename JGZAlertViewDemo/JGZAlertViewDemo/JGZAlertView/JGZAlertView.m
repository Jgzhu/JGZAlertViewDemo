//
//  JGZAlertView.m
//  JGZAlertViewDemo
//
//  Created by 江贵铸 on 2017/6/8.
//  Copyright © 2017年 江贵铸. All rights reserved.
//

#import "JGZAlertView.h"
#define JGZ_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define JGZ_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define JGZ_ThemeColor [UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1]

#pragma mark==😂UIButton的子类😂==

@interface JGZAlertAction()
@property (nonatomic,copy) void(^ActionBlock)(JGZAlertAction *Action);
@end
@implementation JGZAlertAction

+(instancetype)ActionWithTitle:(NSString *)title ClickBlock:(void (^)(JGZAlertAction *))block{
    JGZAlertAction *AlertAction=[JGZAlertAction buttonWithType:UIButtonTypeCustom];
    AlertAction.title = title;
    AlertAction.ActionBlock = block;
    
    [AlertAction setTitle:title forState:UIControlStateNormal];
    [AlertAction setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [AlertAction setBackgroundImage:[JGZAlertAction imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    return AlertAction;
}
#pragma mark-根据颜色生成图片
/**根据颜色生成图片*/
+(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end



@interface JGZAlertView ()
@property (nonatomic,strong) UIView *AlertContentView;
@property (nonatomic,strong) NSMutableArray<JGZAlertAction *> *ActionsArray;
@property (nonatomic,assign) CGFloat MaxHeight;
@property (nonatomic,strong) NSMutableArray *SeparatorLineArray;
@property (nonatomic,strong) UILabel *TitleLabel;
@property (nonatomic,strong) UILabel *MessageLabel;
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
        [self RegisterRotateNotification];
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
    if (self.AlertTitle.length>0) {
        UILabel *TitleLabel = [UILabel new];
        self.TitleLabel = TitleLabel;
        TitleLabel.text = self.AlertTitle;
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.textColor =JGZ_ThemeColor;
        TitleLabel.numberOfLines=0;
        TitleLabel.font = [UIFont systemFontOfSize:20];
        [self.AlertContentView addSubview:TitleLabel];
    }
    
    if (self.AlertMessage.length>0) {
        UILabel *MessageLabel = [UILabel new];
        self.MessageLabel = MessageLabel;
        MessageLabel.text = self.AlertMessage;
        MessageLabel.textAlignment = NSTextAlignmentLeft;
        MessageLabel.textColor =JGZ_ThemeColor;
        MessageLabel.numberOfLines=0;
        MessageLabel.font = [UIFont systemFontOfSize:15];
        [self.AlertContentView addSubview:MessageLabel];
    }
}

-(UIView *)CreatSeparatorLine{
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor=[UIColor colorWithWhite:0.94 alpha:1];
    return lineview;
}
-(void)AddAction:(JGZAlertAction *)Action{
    [self.ActionsArray addObject:Action];
    [self.AlertContentView addSubview:Action];
    
    UIView *lineview = [self CreatSeparatorLine];
    [self.AlertContentView addSubview:lineview];
    [self.SeparatorLineArray addObject:lineview];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self UpdateAllSubviewsFrame];
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
    [self RemoveRotateNotification];
    [UIView animateWithDuration:0.35 animations:^{
       self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.AlertContentView.alpha = 0;
    } completion:^(BOOL finished) {
      [self removeFromSuperview];
    }];
}
-(void)UpdateAllSubviewsFrame{
    [self UpdateAllLabelFrame];
    [self UpdateAllButtonFrame];
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
-(void)UpdateAllLabelFrame{
    CGFloat TopMargin = self.TitleLabel?20:10;
    if (self.TitleLabel) {
        
        CGFloat TitleLabelX = 20;
        CGFloat TitleLabelY = 0+TopMargin;
        CGFloat TitleLabelW =self.AlertContentView.frame.size.width-TitleLabelX*2;
        CGSize TitleLabelSize = [self.TitleLabel sizeThatFits:CGSizeMake(TitleLabelW, CGFLOAT_MAX)];
        self.TitleLabel.frame =CGRectMake(TitleLabelX, TitleLabelY, TitleLabelW, TitleLabelSize.height);
    }
   
    if (self.MessageLabel) {
        
        CGFloat MessageLabelX = 20;
        CGFloat MessageLabelY = TopMargin+CGRectGetHeight(self.TitleLabel.frame)+10;
        CGFloat MessageLabelW =self.AlertContentView.frame.size.width-MessageLabelX*2;
        CGSize MessageLabelSize = [self.MessageLabel sizeThatFits:CGSizeMake(MessageLabelW, CGFLOAT_MAX)];
        self.MessageLabel.frame =CGRectMake(MessageLabelX, MessageLabelY, MessageLabelW, MessageLabelSize.height);
    }
    self.MaxHeight = TopMargin+CGRectGetHeight(self.TitleLabel.frame)+10+CGRectGetHeight(self.MessageLabel.frame);

}
#pragma mark😂有两个Action按钮时😂
-(void)UpdateTwoButtonFrame{
    for (NSInteger i=0; i<self.ActionsArray.count; i++) {
        JGZAlertAction *Action =self.ActionsArray[i];
        Action.userInteractionEnabled=YES;
        Action.tag = 10+i;
        [Action addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        Action.frame=CGRectMake(self.AlertContentView.bounds.size.width*0.5*i, self.MaxHeight+10, self.AlertContentView.bounds.size.width*0.5, 40);
        if (i==0) {
            [self ClipViewToBouns:Action Corner:UIRectCornerBottomLeft];
        }else if(i==1){
            [self ClipViewToBouns:Action Corner:UIRectCornerBottomRight];
        }
        UIView *lineview = self.SeparatorLineArray[i];
        lineview.frame = CGRectMake(20, self.MaxHeight+10, (self.AlertContentView.frame.size.width-20*2)*i, 0.5);
    }
}
#pragma mark😂有1个或者多于两个Action按钮时😂
-(void)UpdateOneOrMoreButtonFrame{
    self.MaxHeight= self.MaxHeight+10;
    for (NSInteger i=0; i<self.ActionsArray.count; i++) {
        JGZAlertAction *Action =self.ActionsArray[i];
        Action.userInteractionEnabled=YES;
        Action.tag=10+i;
        [Action addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        Action.frame=CGRectMake(0, self.MaxHeight+40*i, self.AlertContentView.bounds.size.width, 40);
        if (i==self.ActionsArray.count-1) {
            [self ClipViewToBouns:Action Corner:UIRectCornerBottomLeft|UIRectCornerBottomRight];
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
-(void)btnclick:(JGZAlertAction *)sender{
    //NSLog(@"%@",sender.title);
    if (sender.ActionBlock) {
        sender.ActionBlock(sender);
    }
    [self dismissAnimation];
}

-(void)setMessageAlignment:(NSTextAlignment)MessageAlignment{
    _MessageAlignment = MessageAlignment;
    self.MessageLabel.textAlignment = MessageAlignment;
}
#pragma mark😂注册屏幕旋转通知😂
-(void)RegisterRotateNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification{
    self.bounds =[UIScreen mainScreen].bounds;
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.AlertContentView.bounds = CGRectMake(0, 0, JGZ_SCREEN_WIDTH*0.75, 250);
    self.AlertContentView.center =self.center;
    [self UpdateAllSubviewsFrame];
}
#pragma mark😂移除屏幕旋转通知😂
-(void)RemoveRotateNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
@end
