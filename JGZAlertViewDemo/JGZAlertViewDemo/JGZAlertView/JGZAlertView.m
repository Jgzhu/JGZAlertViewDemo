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
@interface JGZAlertView ()
@property (nonatomic,strong) UIView *AlertContentView;
@property (nonatomic,strong) NSMutableArray *ActionsArray;
@end
@implementation JGZAlertView

-(NSMutableArray *)ActionsArray{
    if (_ActionsArray) {
        _ActionsArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _ActionsArray;
}
-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

+(instancetype)AlertViewWithTitle:(NSString *)Title Message:(NSString *)message{
    JGZAlertView *AlertView = [[JGZAlertView alloc] init];
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
    CGFloat TitleLabelY = 30;
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
}
-(void)AddAction:(UIButton *)Button{
    [self.ActionsArray addObject:Button];
    [self.AlertContentView addSubview:Button];
}
-(void)show{
    [self UpdateAllButtonFrame];
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
//更新  明天从这里开始
-(void)UpdateAllButtonFrame{

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
@end
