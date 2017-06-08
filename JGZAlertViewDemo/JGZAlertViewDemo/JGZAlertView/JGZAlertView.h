//
//  JGZAlertView.h
//  JGZAlertViewDemo
//
//  Created by 江贵铸 on 2017/6/8.
//  Copyright © 2017年 江贵铸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGZAlertView : UIView

@property (nonatomic, copy) NSString *AlertTitle;
@property (nonatomic, copy) NSString *AlertMessage;
+(instancetype)AlertViewWithTitle:(NSString *)Title Message:(NSString *)message;
-(void)AddAction:(UIButton *)Button;
-(void)show;
@end
