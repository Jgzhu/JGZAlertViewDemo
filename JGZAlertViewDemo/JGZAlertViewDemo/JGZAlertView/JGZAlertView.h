//
//  JGZAlertView.h
//  JGZAlertViewDemo
//
//  Created by 江贵铸 on 2017/6/8.
//  Copyright © 2017年 江贵铸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGZAlertAction:UIButton

+(instancetype)ActionWithTitle:(NSString *)title ClickBlock:(void(^)(JGZAlertAction *Action))block;
+(UIImage *)imageWithColor:(UIColor *)color;
@end

@interface JGZAlertView : UIView
@property (nonatomic, copy) NSString *AlertTitle;
@property (nonatomic, copy) NSString *AlertMessage;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initPrivate;
+(instancetype)AlertViewWithTitle:(NSString *)Title Message:(NSString *)message;
-(void)AddAction:(JGZAlertAction *)Action;
-(void)show;
@end
