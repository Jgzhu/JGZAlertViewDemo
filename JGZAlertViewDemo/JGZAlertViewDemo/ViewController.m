//
//  ViewController.m
//  JGZAlertViewDemo
//
//  Created by 江贵铸 on 2017/6/8.
//  Copyright © 2017年 江贵铸. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import "JGZAlertView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"样式";
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell" forIndexPath:indexPath];
    [cell.ButtonStyle setTitle:[NSString stringWithFormat:@"样式%ld",indexPath.section+1] forState:UIControlStateNormal];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc] init];
    headview.backgroundColor = [UIColor whiteColor];
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JGZAlertView *AlertView = [JGZAlertView AlertViewWithTitle:@"这是标题埃及双方尽快核实到使肌肤及时发放" Message:@"1. 日夜赶工,修复了一堆bug.\n2. 跟着产品经理改来改去,增加了很多功能.\n3. 貌似性能提升了那么一点点.\n4. 日夜赶工,修复了一堆bug.\n5. 跟着产品经理改来改去,增加了很多功能.\n6. 貌似性能提升了那么一点点."];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
     [btn1 setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
     [btn1 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"更新" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"更新1" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"更新2" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn5 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn6 setTitle:@"更新3" forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor colorWithRed:94/255.0 green:96/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [btn6 setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.97 alpha:1]] forState:UIControlStateHighlighted];
    [AlertView AddAction:btn1];
    [AlertView AddAction:btn2];
//    [AlertView AddAction:btn3];
//    [AlertView AddAction:btn4];
//    [AlertView AddAction:btn5];
//    [AlertView AddAction:btn6];
    [AlertView show];
 
}
#pragma mark-根据颜色生成图片
/**根据颜色生成图片*/
-(UIImage *)imageWithColor:(UIColor *)color {
     CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
     UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
     CGContextFillRect(context, rect);//用这个颜色填充这个上下文
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
     UIGraphicsEndImageContext();
     return image;
     }
@end
