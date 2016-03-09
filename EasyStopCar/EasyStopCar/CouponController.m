//
//  CouponController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "CouponController.h"
#import "CouponCell.h"

@interface CouponController ()

@property(nonatomic,strong)UITableView *myTableView;//数据列表

@end

@implementation CouponController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super initNavBarItems:@"我的优惠券"];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = backageColorLightgray;
    [self.view addSubview:self.myTableView];
    
}


//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"仅限北京停车场使用" forKey:@"name"];
    [myDictionary setValue:@"2016-04-28——2016-05-01" forKey:@"userTime"];
    [myDictionary setValue:@"满50使用" forKey:@"condition"];
    [myDictionary setValue:@"20" forKey:@"money"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"仅限北京停车场使用" forKey:@"name"];
    [myDictionary setValue:@"2016-04-28——2016-05-01" forKey:@"userTime"];
    [myDictionary setValue:@"满50使用" forKey:@"condition"];
    [myDictionary setValue:@"20" forKey:@"money"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"仅限北京停车场使用" forKey:@"name"];
    [myDictionary setValue:@"2016-04-28——2016-05-01" forKey:@"userTime"];
    [myDictionary setValue:@"满50使用" forKey:@"condition"];
    [myDictionary setValue:@"20" forKey:@"money"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 120+10.0;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"CouponCell";
    
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[CouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //    cell.delegate = self;
    [cell setCellInfo:self.myArray[indexPath.row]];
    
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
