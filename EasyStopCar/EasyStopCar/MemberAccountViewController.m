//
//  MemberAccountViewController.m
//  EasyStopCar
//  会员卡账户页面
//  Created by savvy on 16/3/8.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "MemberAccountViewController.h"
#import "MemberAccountCell.h"

@interface MemberAccountViewController ()

@property(nonatomic, strong) UILabel *memberTitleLabel;//标题
@property(nonatomic, strong) UILabel *memberPriceLabel;//余额
@property(nonatomic, strong) UIButton *payButton;//充值
@property(nonatomic, strong) UITableView *financeTableView;//收支列表
//@property (nonatomic, assign) int page;//列表当前页数





@end

@implementation MemberAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"会员卡"];
  
    self.view.backgroundColor = backageColorRed;
  
    
    self.memberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, ScreenWidth, 15)];
    self.memberTitleLabel.text = @"会员卡余额";
    self.memberTitleLabel.textColor = [UIColor whiteColor];
    self.memberTitleLabel.font = [UIFont systemFontOfSize:12];
    self.memberTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.memberTitleLabel];
    
    self.memberPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.memberTitleLabel.frame.origin.y+self.memberTitleLabel.frame.size.height+10, ScreenWidth, 30)];
    self.memberPriceLabel.text = @"￥0";
    self.memberPriceLabel.textColor = [UIColor whiteColor];
    self.memberPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.memberPriceLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:self.memberPriceLabel];
    
    self.financeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, ScreenHeight-190)];
    self.financeTableView.delegate = self;
    self.financeTableView.dataSource = self;
    self.financeTableView.allowsMultipleSelectionDuringEditing = YES;
    self.financeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.financeTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.financeTableView];
    
    float payButtonSize = 70.0;
    self.payButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-payButtonSize)/2,  self.financeTableView.frame.origin.y-payButtonSize/2, payButtonSize, payButtonSize)];
    self.memberPriceLabel.text = @"￥0";
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payButton setTitle:@"充值" forState:UIControlStateNormal];
    self.payButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.payButton.layer.cornerRadius = payButtonSize/2;
    self.payButton.layer.masksToBounds = YES;
    self.payButton.backgroundColor = backageColorYellow;
    [self.payButton addTarget:self action:@selector(rechargeMember) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
    
    
    
}

//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"世纪金源购物中心" forKey:@"name"];
    [myDictionary setValue:@"2016-4-28 18:25" forKey:@"addtime"];
    [myDictionary setValue:@"-" forKey:@"type"];
    [myDictionary setValue:@"18.5" forKey:@"sums"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"世纪金源购物中心" forKey:@"name"];
    [myDictionary setValue:@"2016-4-28 18:25" forKey:@"addtime"];
    [myDictionary setValue:@"+" forKey:@"type"];
    [myDictionary setValue:@"18.5" forKey:@"sums"];
    [self.myArray addObject:myDictionary];

    
    
}


//开通会员
-(void)rechargeMember{
    NSLog(@"充值会员！！！！");
   
}

 

//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"MemberAccountCell";
    
    MemberAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[MemberAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
