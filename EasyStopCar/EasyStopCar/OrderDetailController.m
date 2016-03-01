//
//  OrderDetailController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "OrderDetailController.h"

@interface OrderDetailController ()

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮

@property(nonatomic,strong)UIView *infoView;            //信息视图
@property(nonatomic,strong)UIView *priceView;           //价格视图
@property(nonatomic,strong)UIImageView *twoDimensionalImageView;  //二维码视图

@property(nonatomic,strong)UIView *infoDetailView;      //信息详细视图
@property(nonatomic,strong)UIView *infoTimeView;      //信息时间视图

//信息详细视图
@property(nonatomic,strong)UIImageView *infoLocationFlag;
@property(nonatomic,strong)UILabel *infoName;
@property(nonatomic,strong)UILabel *infoAddress;
@property(nonatomic,strong)UILabel *infoAddressDetail;
@property(nonatomic,strong)UIImageView *infoDayFlag;
@property(nonatomic,strong)UILabel *infoDayPrice;
@property(nonatomic,strong)UIImageView *infoNightFlag;
@property(nonatomic,strong)UILabel *infoNightPrice;

//信息时间视图
@property(nonatomic,strong)UILabel *infoTimeName;
@property(nonatomic,strong)UILabel *infoTimeRemain;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super initNavBarItems:@"停车订单详情"];
    
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.submitButoon setTitle:@"导航" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];
    
    
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    self.infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infoView];
    
    CALayer *infoBottomBorder=[[CALayer alloc]init];
    infoBottomBorder.frame=CGRectMake(0, self.infoView.frame.size.height-0.5, self.infoView.frame.size.width, 0.5);
    infoBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.infoView.layer addSublayer:infoBottomBorder ];
    
    self.priceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.infoView.frame.origin.y+self.infoView.frame.size.height, ScreenWidth, 40)];
    self.priceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.priceView];
    
    CALayer *priceBottomBorder=[[CALayer alloc]init];
    priceBottomBorder.frame=CGRectMake(0, self.priceView.frame.size.height-0.5, self.priceView.frame.size.width, 0.5);
    priceBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.priceView.layer addSublayer:priceBottomBorder ];
    
    self.twoDimensionalImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, self.infoView.frame.origin.y+self.infoView.frame.size.height+20, 200, 200)];
    self.twoDimensionalImageView.frame = CGRectMake((ScreenWidth-200)/2, self.priceView.frame.origin.y+self.priceView.frame.size.height+15, 200, 200);
    self.twoDimensionalImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
    [self.view addSubview:self.twoDimensionalImageView];
    
    
 //信息详细视图
    self.infoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.5, self.infoView.frame.size.height)];
    [self.infoView addSubview:self.infoDetailView];
    
    self.infoLocationFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 15, 15, 15)];
    self.infoLocationFlag.image = [UIImage imageNamed:@"ico_home_cell_location"];
    [self.infoView addSubview:self.infoLocationFlag];
    
    self.infoName = [[UILabel alloc]initWithFrame:CGRectMake(self.infoLocationFlag.frame.origin.x+self.infoLocationFlag.frame.size.width+5, 15, 100, 15)];
    self.infoName.text = @"您的车位";
     self.infoName.textColor = fontColorGray;
    self.infoName.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoName];
    
    self.infoAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.infoName.frame.origin.x, self.infoName.frame.origin.y+self.infoName.frame.size.height+5, 100, 30)];
    self.infoAddress.text = @"未知";
    self.infoAddress.textColor = fontColorGray;
    self.infoAddress.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoAddress];
    
    self.infoAddressDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.infoName.frame.origin.x, self.infoAddress.frame.origin.y+self.infoAddress.frame.size.height+5, 100, 30)];
    self.infoAddressDetail.text = @"未知";
    self.infoAddressDetail.textColor = fontColorGray;
    self.infoAddressDetail.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoAddressDetail];
    
    
    self.infoDayFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, self.infoAddressDetail.frame.origin.y+self.infoAddressDetail.frame.size.height+15, 15, 15)];
    self.infoDayFlag.image = [UIImage imageNamed:@"ico_search_day"];
    [self.infoView addSubview:self.infoDayFlag];
    
    self.infoDayPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDayFlag.frame.origin.x+self.infoDayFlag.frame.size.width+5, self.infoDayFlag.frame.origin.y, 100, 15)];
    self.infoDayPrice.text = @"￥0/小时";
    self.infoDayPrice.textColor = fontColorGray;
    self.infoDayPrice.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoDayPrice];
    
    
    self.infoNightFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, self.infoDayFlag.frame.origin.y+self.infoDayFlag.frame.size.height+15, 15, 15)];
    self.infoNightFlag.image = [UIImage imageNamed:@"ico_search_night"];
    [self.infoView addSubview:self.infoNightFlag];
    
    self.infoNightPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoNightFlag.frame.origin.x+self.infoNightFlag.frame.size.width+5, self.infoNightFlag.frame.origin.y, 100, 15)];
    self.infoNightPrice.text = @"￥0/小时";
    self.infoNightPrice.textColor = fontColorGray;
    self.infoNightPrice.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoNightPrice];
    
    
    
 //信息时间视图
    self.infoTimeView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, 0, ScreenWidth*0.5, self.infoView.frame.size.height)];
    [self.infoView addSubview:self.infoTimeView];
    
    
 
    
    self.infoTimeName = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth*0.5, 15)];
    self.infoTimeName.font = [UIFont systemFontOfSize:14];
    self.infoTimeName.textColor = backageColorGreen;
    self.infoTimeName.text = @"车位使用中";
    [self.infoTimeView addSubview:self.infoTimeName];
    
    self.infoTimeRemain = [[UILabel alloc]initWithFrame:CGRectMake(0, self.infoTimeView.frame.size.height-15-15, ScreenWidth*0.5, 15)];
    self.infoTimeRemain.font = [UIFont systemFontOfSize:14];
    self.infoTimeRemain.textColor = backageColorGreen;
    self.infoTimeRemain.text = @"已停0小时0分";
    [self.infoTimeView addSubview:self.infoTimeRemain];
    
}


//提交按钮点击事件
-(void)submitClick{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
