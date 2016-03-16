//
//  UserCenterController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UserCenterController.h"
#import "ProfileCell.h"
#import "UserInfoController.h"
#import "MemberAccountViewController.h"
#import "OrderListController.h"
#import "CouponController.h"
#import "SettingController.h"

@interface UserCenterController ()

 @property(nonatomic, strong)UITableView *userTableView;//设置数据列表

@property(nonatomic, strong) UIImageView *headImageView;//头像
@property(nonatomic, strong) UILabel *nameLabel;//姓名
@property(nonatomic, strong) UILabel *phoneLabel;//手机号
@property(nonatomic, strong) UIImageView *headFlag;//标记

@property(nonatomic, strong) NSMutableArray *userDataArray;//列表数据
@property(nonatomic, strong) NSString *memberRemainder;//会员余额

@property(nonatomic, strong) UIImageView *backageBottom;//底部背景
@property(nonatomic, strong) UILabel *serviceLabel;//客服电话
@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [super initNavBarItems:@"个人中心"];
    
    
    
    self.backageBottom = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-50)/2, ScreenHeight-64-78-52, 50, 52)];
    self.backageBottom.image = [UIImage imageNamed:@"image_user_bottom"];
    self.backageBottom.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backageBottom];
    
    self.serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-25-15, ScreenWidth, 15)];
    self.serviceLabel.text = @"客服电话：暂无";
    self.serviceLabel.textAlignment = NSTextAlignmentCenter;
    self.serviceLabel.font = [UIFont systemFontOfSize:14];
    self.serviceLabel.textColor = fontColorGray;
    [self.view addSubview:self.serviceLabel];
    
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x, 0, kScreenBounds.size.width, 45*4+113) style:UITableViewStylePlain];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.userTableView.backgroundColor = [UIColor whiteColor];
    [self.userTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.userTableView];
    
   
 
    
    
    //设置表头部个人信息
    self.userTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 113.0f)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)];
        tapGesture.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tapGesture];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, view.frame.size.height-0.5, view.frame.size.width, 0.5);
        bottomBorder.backgroundColor=lineColorGray.CGColor;
        [view.layer addSublayer:bottomBorder ];
  
        // 头像
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, 19.0f, 74.0f, 74.0f)];
        self.headImageView.backgroundColor = [UIColor clearColor];
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.height / 2.0;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.userInteractionEnabled = YES;
        self.headImageView.image = [UIImage imageNamed:@"image_user_head"];
        [view addSubview:self.headImageView];
        
 
        
        //昵称
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width+20, self.headImageView.frame.origin.y+10, 170.0f, 22.0f)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        [self.nameLabel setText:@"未知"];
        [self.nameLabel adjustsFontSizeToFitWidth];
        self.nameLabel.textColor = fontColorBlack;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.nameLabel];
 
        
        self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, 56, 170.0f, 15.0f)];
        self.phoneLabel.backgroundColor = [UIColor clearColor];
        self.phoneLabel.font = [UIFont systemFontOfSize:14];
        [self.phoneLabel setText:@"暂无"];
        [self.phoneLabel adjustsFontSizeToFitWidth];
        self.phoneLabel.textColor = fontColorGray;
        self.phoneLabel.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.phoneLabel];
    
 
        self.headFlag = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-marginSize-7, 0, 7, view.frame.size.height)];
        self.headFlag.backgroundColor = [UIColor clearColor];
        self.headFlag.image = [UIImage imageNamed:@"ico_home_select_arrow"];
        self.headFlag.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:self.headFlag];
        
        view;
    });

    
    
    [self initTableViewData];//设置列表数据
    
}

//初始化列表数据
-(void)initTableViewData{
    self.userDataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的钱包";
    NSString *memberRemainderTitle =  [NSString stringWithFormat:@"￥%@元",self.memberRemainder];
    userDictionary[@"content"] = memberRemainderTitle ;
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_wallet"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的订单";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_order"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"我的优惠劵";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_coupon"];
    [self.userDataArray addObject:userDictionary];
    userDictionary = [[NSMutableDictionary alloc]init];
    userDictionary[@"name"] = @"设置";
    userDictionary[@"content"] = @"";
    userDictionary[@"image"] = [UIImage imageNamed:@"ico_user_setting"];
    [self.userDataArray addObject:userDictionary];
    
    [self.userTableView reloadData];
}

- (void)headClick:(UITapGestureRecognizer *)gesture
{
    UserInfoController *myController = [[UserInfoController alloc]init];
    [self.navigationController pushViewController:myController animated:YES];
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return self.userDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.row == 0) {
             cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.backgroundColor = COLOR(255, 255, 255);
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setCellInfo:self.userDataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"点击了一个cell");
    
    if (indexPath.row == 0) {
        MemberAccountViewController *myController =  [[MemberAccountViewController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else if (indexPath.row == 1) {
        OrderListController *myController =  [[OrderListController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else if (indexPath.row == 2) {
        CouponController *myController =  [[CouponController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else if (indexPath.row == 3) {
        SettingController *myController =  [[SettingController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }
    
 
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
