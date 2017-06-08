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
    JGZAlertView *AlertView = [JGZAlertView AlertViewWithTitle:@"这是标题" Message:@"1. 日夜赶工,修复了一堆bug.\n2. 跟着产品经理改来改去,增加了很多功能.\n3. 貌似性能提升了那么一点点."];
    
    [AlertView show];
 
}

@end
