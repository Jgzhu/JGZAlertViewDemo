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
    JGZAlertAction *btn1 = [JGZAlertAction ActionWithTitle:@"取消" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn2 = [JGZAlertAction ActionWithTitle:@"确定" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn3 = [JGZAlertAction ActionWithTitle:@"更新" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn4 = [JGZAlertAction ActionWithTitle:@"更新1" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn5 = [JGZAlertAction ActionWithTitle:@"更新2" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn6 = [JGZAlertAction ActionWithTitle:@"更新3" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
    JGZAlertAction *btn7 = [JGZAlertAction ActionWithTitle:@"更新4" ClickBlock:^(JGZAlertAction *Action) {
        
    }];
   
    [AlertView AddAction:btn1];
    [AlertView AddAction:btn2];
    [AlertView AddAction:btn3];
    [AlertView AddAction:btn4];
    [AlertView AddAction:btn5];
    [AlertView AddAction:btn6];
    [AlertView AddAction:btn7];
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
