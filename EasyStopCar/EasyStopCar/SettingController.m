//
//  SettingController.m
//  EasyStopCar
//  系统设置
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SettingController.h"
#import "LoginController.h"

@interface SettingController ()

@property(nonatomic,strong)UITableView *myTableView;//数据列表
@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super initNavBarItems:@"设置"];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.backgroundColor = backageColorLightgray;
     [ self.myTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.myTableView];
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    self.submitButoon.tag = 198801;
    [self.submitButoon setTitle:@"退出" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];

}


//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
   NSString *title = nil;
    
  title = @"清除缓存";
    [self.myArray addObject:title];
    
    title = @"关于我们";
    [self.myArray addObject:title];
    
    
}

//提交按钮
- (void)submitInfo:(UIButton *)myButton {
    LoginController *myController = [[LoginController alloc]init];
    [self.navigationController pushViewController:myController animated:YES];
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 40.0;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=self.myArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = fontColorBlack;
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了一个cell");
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
