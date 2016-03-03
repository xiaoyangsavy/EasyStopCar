//
//  UserInfoController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UserInfoController.h"
#import "UserInfoCell.h"
#import "EditTextController.h"
#import "EditSeleceController.h"

@interface UserInfoController ()

@property(nonatomic,strong) UITableView *userInfoTableView;//列表

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"我的资料"];
    
    
    
    
    
    self.userInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.userInfoTableView.delegate = self;
    self.userInfoTableView.dataSource = self;
    self.userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.userInfoTableView.backgroundColor = [UIColor whiteColor];
    [self.userInfoTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.userInfoTableView];
    
}


//测试数据
-(void) initTestArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"头像" forKey:@"title"];
    [myDictionary setValue:nil forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"姓名" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"车牌号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"手机号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"性别" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"邮箱" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"职业" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"身份证号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 50;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"UserInfoCell";
    
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"点击了一个cell");
    
    if (indexPath.row == 4) {
        EditSeleceController  *myController = [[EditSeleceController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else{
    EditTextController *myController = [[EditTextController alloc]init];
    myController.editString = self.myArray[indexPath.row][@"content"];
    [self.navigationController pushViewController:myController animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
