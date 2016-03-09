//
//  OrderListController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "OrderListController.h"
#import "HomeCell.h"
#import "OrderDetailController.h"
#import "OrderPayController.h"


@interface OrderListController ()

@property(nonatomic,strong)UITableView *myTableView;//数据列表

@end

@implementation OrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super initNavBarItems:@"我的订单"];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 108.5+10.0;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"HomeCell";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    cell.delegate = self;
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了一个cell");
    
    
    NSDictionary *myDictionary =  self.myArray[indexPath.row];
    NSString *flag = myDictionary[@"testFlag"];
    if ([flag isEqualToString:@"0"]) {
        OrderDetailController *orderDetailController = [[OrderDetailController alloc]init];
        orderDetailController.orderType = 1;//预约订单
        [self.navigationController pushViewController:orderDetailController animated:YES];
    }else{
        OrderPayController *myController = [[OrderPayController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
