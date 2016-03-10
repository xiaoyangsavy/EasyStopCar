//
//  OrderPayController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/2.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "OrderPayController.h"
#import "OrderPayCompleteController.h"


@interface OrderPayController ()

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮
@property(nonatomic,strong)UIView *titleView;      //标题视图
@property(nonatomic,strong)UIView *infoView;      //信息视图
@property(nonatomic,strong)UIImageView *lineImageView;//分割线

 //标题视图
@property(nonatomic,strong)UIImageView *titleImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *orderNumberLabel;

//信息视图
@property(nonatomic,strong)UIView *infoDetailView;//信息详细视图
@property(nonatomic,strong)UIView *infoCouponView;//优惠券视图

//信息详细视图
@property(nonatomic,strong)UILabel *inTimeTitle;
@property(nonatomic,strong)UILabel *inTimeLabel;
@property(nonatomic,strong)UILabel *outTimeTitle;
@property(nonatomic,strong)UILabel *outTimeLabel;
@property(nonatomic,strong)UILabel *useTimeTitle;
@property(nonatomic,strong)UILabel *useTimeLabel;
@property(nonatomic,strong)UIImageView *useTimeImageView;

@property(nonatomic,strong)UIView *infoLine;//分割线

@property(nonatomic,strong)UILabel *parkTitle;
@property(nonatomic,strong)UILabel *parkName;
@property(nonatomic,strong)UIImageView *parkImage;

@property(nonatomic,strong)UILabel *dayParkTitle;
@property(nonatomic,strong)UILabel *dayParkDetail;
@property(nonatomic,strong)UILabel *dayParkPrice;

@property(nonatomic,strong)UILabel *nightParkTitle;
@property(nonatomic,strong)UILabel *nightParkDetail;
@property(nonatomic,strong)UILabel *nightParkPrice;

@property(nonatomic,strong)UILabel *electricityParkTitle;
@property(nonatomic,strong)UILabel *electricityParkDetail;
@property(nonatomic,strong)UILabel *electricityParkPrice;

@property(nonatomic,strong)UILabel *chargeParkTitle;
@property(nonatomic,strong)UILabel *chargeParkDetail;
@property(nonatomic,strong)UILabel *chargeParkPrice;

@property(nonatomic,strong)UILabel *couponParkTitle;
@property(nonatomic,strong)UILabel *couponParkDetail;
@property(nonatomic,strong)UILabel *couponParkPrice;

@property(nonatomic,strong)UILabel *sumPriceTitle;
@property(nonatomic,strong)UILabel *sumPrice;


//优惠券
@property(nonatomic,strong)UIImageView *couponIco;
@property(nonatomic,strong)UILabel *couponName;
@property(nonatomic,strong)UILabel *couponCount;
@property(nonatomic,strong)UIImageView *couponFlag;


//选择付款方式
@property(nonatomic,strong)UIView *payWayView;
@property(nonatomic,strong)UIView *payWayTitleView;
@property(nonatomic,strong)UIView *payWayContentView;

@property(nonatomic,strong)UILabel *payWayTitleLabel;
@property(nonatomic,strong)UIButton *payWayCancelButton;

@property(nonatomic,strong)UILabel *payWayMoneyLabel;
@property(nonatomic,strong)UIButton *payWayAlipayButton;
@property(nonatomic,strong)UIButton *payWayWechatButton;

@end

@implementation OrderPayController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
     [super initNavBarItems:@"停车订单详情"];
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.submitButoon setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];
    
 
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 111)];
    [self.view addSubview:self.titleView];
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(marginSize, self.titleView.frame.origin.y+self.titleView.frame.size.height, ScreenWidth-marginSize*2, 325)];
    self.infoView.backgroundColor = [UIColor whiteColor];
    self.infoView.layer.cornerRadius = 10;
    self.infoView.layer.masksToBounds = YES;
    //设置边框及边框颜色
    self.infoView.layer.borderWidth = 0.5;
    self.infoView.layer.borderColor =[ lineColorGray CGColor];
    [self.view addSubview:self.infoView];
    
    //分割线
    self.lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, self.infoView.frame.origin.y+275, self.infoView.frame.size.width, 10)];
    self.lineImageView.image = [UIImage imageNamed:@"image_order_line"];
        self.lineImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.lineImageView];
 
    
    //标题视图
    self.titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-55)/2, 15, 55, 50)];
    self.titleImageView.image = [UIImage imageNamed:@"image_order_smile"];
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.titleView addSubview:self.titleImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.titleImageView.frame.origin.y+self.titleImageView.frame.size.height+5, ScreenWidth, 15)];
     self.titleLabel.text = @"感谢您使用易用车，请您支付停车费";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = fontColorBlack;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.titleLabel];
    
    self.orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+5, ScreenWidth, 15)];
    self.orderNumberLabel.text = @"订单韩  0000000000000000";
    self.orderNumberLabel.font = [UIFont systemFontOfSize:9];
    self.orderNumberLabel.textColor = fontColorLightgray;
     self.orderNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleView addSubview:self.orderNumberLabel];
    
    
  //信息视图
    self.infoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.infoView.frame.size.width, 275)];
    self.infoDetailView.backgroundColor = [UIColor whiteColor];
    [self.infoView addSubview:self.infoDetailView];
    
    self.inTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, 20, 100, 15)];
    self.inTimeTitle.text = @"停车入库时间";
    self.inTimeTitle.font = [UIFont systemFontOfSize:12];
    self.inTimeTitle.textColor = backageColorBlue;
    self.inTimeTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.inTimeTitle];
    
    self.inTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.inTimeTitle.frame.origin.y+self.inTimeTitle.frame.size.height, 100, 15)];
    self.inTimeLabel.text = @"0000-00-00 00:00";
    self.inTimeLabel.font = [UIFont systemFontOfSize:9];
    self.inTimeLabel.textColor = backageColorBlue;
    self.inTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.inTimeLabel];

    self.outTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-100, 20, 100, 15)];
    self.outTimeTitle.text = @"取车出库时间";
    self.outTimeTitle.font = [UIFont systemFontOfSize:12];
    self.outTimeTitle.textColor = backageColorBlue;
    self.outTimeTitle.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.outTimeTitle];
    
    self.outTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake( self.outTimeTitle.frame.origin.x, self.outTimeTitle.frame.origin.y+self.outTimeTitle.frame.size.height, 100, 15)];
    self.outTimeLabel.text = @"0000-00-00 00:00";
    self.outTimeLabel.font = [UIFont systemFontOfSize:9];
    self.outTimeLabel.textColor = backageColorBlue;
    self.outTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.outTimeLabel];
 

    self.useTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.infoDetailView.frame.size.width-70)/2, 25, 70, 5)];
    self.useTimeImageView.image = [UIImage  imageNamed:@"image_order_time_flag"];
    self.useTimeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoDetailView addSubview:self.useTimeImageView];
    
    self.useTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.useTimeImageView.frame.origin.x, self.useTimeImageView.frame.origin.y-15, 70, 15)];
    self.useTimeTitle.text = @"使用时间";
    self.useTimeTitle.font = [UIFont systemFontOfSize:10];
    self.useTimeTitle.textColor = fontColorGray;
    self.useTimeTitle.textAlignment = NSTextAlignmentCenter;
    [self.infoDetailView addSubview:self.useTimeTitle];
    
    self.useTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.useTimeImageView.frame.origin.x, self.useTimeImageView.frame.origin.y+self.useTimeImageView.frame.size.height, 70, 15)];
    self.useTimeLabel.text = @"00:00";
    self.useTimeLabel.font = [UIFont systemFontOfSize:18];
    self.useTimeLabel.textColor = fontColorGray;
    self.useTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.infoDetailView addSubview:self.useTimeLabel];
    
    
   
    
    //分割线
 
    
    self.infoLine = [[UIView alloc]initWithFrame:CGRectMake(marginSize, 52, self.infoView.frame.size.width-marginSize*2, 0.5)];
    self.infoLine.backgroundColor = lineColorGray;
    [self.infoDetailView addSubview:self.infoLine];
    
    
    //信息详情视图布局
    self.parkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.infoLine.frame.origin.y+self.infoLine.frame.size.height+20, 100, 15)];
    self.parkTitle.text = @"停车场";
    self.parkTitle.font = [UIFont systemFontOfSize:14];
    self.parkTitle.textColor = fontColorBlack;
    self.parkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.parkTitle];
    
    self.parkImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-10, self.parkTitle.frame.origin.y, 10, 15)];
    self.parkImage.image = [UIImage imageNamed:@"ico_home_select_arrow"];
    self.parkImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoDetailView addSubview:self.parkImage];
    
    self.parkName = [[UILabel alloc]initWithFrame:CGRectMake(self.parkImage.frame.origin.x-150, self.parkTitle.frame.origin.y, 140, 15)];
    self.parkName.text = @"未知";
    self.parkName.font = [UIFont systemFontOfSize:12];
    self.parkName.textColor = fontColorLightgray;
    self.parkName.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.parkName];
    
    
    //白天费用
    self.dayParkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.parkTitle.frame.origin.y+self.parkTitle.frame.size.height+20, 100, 15)];
    self.dayParkTitle.text = @"日间停车费";
    self.dayParkTitle.font = [UIFont systemFontOfSize:14];
    self.dayParkTitle.textColor = fontColorBlack;
    self.dayParkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.dayParkTitle];
    
    
   self.dayParkPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.dayParkTitle.frame.origin.y, 50, 15)];
    self.dayParkPrice.text = @"0元";
    self.dayParkPrice.font = [UIFont systemFontOfSize:14];
    self.dayParkPrice.textColor = backageColorRed;
    self.dayParkPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.dayParkPrice];
    
    
    self.dayParkDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.dayParkPrice.frame.origin.x-150, self.dayParkTitle.frame.origin.y, 150, 15)];
    self.dayParkDetail.text = @"0元/时*0时";
    self.dayParkDetail.font = [UIFont systemFontOfSize:12];
    self.dayParkDetail.textColor = fontColorLightgray;
    self.dayParkDetail.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.dayParkDetail];
    
    
    //晚上费用
    self.nightParkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.dayParkTitle.frame.origin.y+self.dayParkTitle.frame.size.height+5, 100, 15)];
    self.nightParkTitle.text = @"夜间停车费";
    self.nightParkTitle.font = [UIFont systemFontOfSize:14];
    self.nightParkTitle.textColor = fontColorBlack;
    self.nightParkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.nightParkTitle];
    
    
    self.nightParkPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.nightParkTitle.frame.origin.y, 50, 15)];
    self.nightParkPrice.text = @"0元";
    self.nightParkPrice.font = [UIFont systemFontOfSize:14];
    self.nightParkPrice.textColor = backageColorRed;
    self.nightParkPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.nightParkPrice];
    
    
    self.nightParkDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.dayParkPrice.frame.origin.x-150, self.nightParkTitle.frame.origin.y, 150, 15)];
    self.nightParkDetail.text = @"0元/时*0时";
    self.nightParkDetail.font = [UIFont systemFontOfSize:12];
    self.nightParkDetail.textColor = fontColorLightgray;
    self.nightParkDetail.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.nightParkDetail];
    
    //电费
    self.electricityParkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.nightParkTitle.frame.origin.y+self.nightParkTitle.frame.size.height+5, 100, 15)];
    self.electricityParkTitle.text = @"电费";
    self.electricityParkTitle.font = [UIFont systemFontOfSize:14];
    self.electricityParkTitle.textColor = fontColorBlack;
    self.electricityParkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.electricityParkTitle];
    
    
    self.electricityParkPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.electricityParkTitle.frame.origin.y, 50, 15)];
    self.electricityParkPrice.text = @"0元";
    self.electricityParkPrice.font = [UIFont systemFontOfSize:14];
    self.electricityParkPrice.textColor = backageColorRed;
    self.electricityParkPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.electricityParkPrice];
    
    
    self.electricityParkDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.electricityParkPrice.frame.origin.x-150, self.electricityParkTitle.frame.origin.y, 150, 15)];
    self.electricityParkDetail.text = @"0元/时*0时";
    self.electricityParkDetail.font = [UIFont systemFontOfSize:12];
    self.electricityParkDetail.textColor = fontColorLightgray;
    self.electricityParkDetail.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.electricityParkDetail];
    
  

    //充电服务费
    self.chargeParkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.electricityParkTitle.frame.origin.y+self.electricityParkTitle.frame.size.height+5, 100, 15)];
    self.chargeParkTitle.text = @"充电服务费";
    self.chargeParkTitle.font = [UIFont systemFontOfSize:14];
    self.chargeParkTitle.textColor = fontColorBlack;
    self.chargeParkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.chargeParkTitle];
    
    
    self.chargeParkPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.chargeParkTitle.frame.origin.y, 50, 15)];
    self.chargeParkPrice.text = @"0元";
    self.chargeParkPrice.font = [UIFont systemFontOfSize:14];
    self.chargeParkPrice.textColor = backageColorRed;
    self.chargeParkPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.chargeParkPrice];
    
    
    self.chargeParkDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.chargeParkPrice.frame.origin.x-150, self.chargeParkTitle.frame.origin.y, 150, 15)];
    self.chargeParkDetail.text = @"0元/时*0时";
    self.chargeParkDetail.font = [UIFont systemFontOfSize:12];
    self.chargeParkDetail.textColor = fontColorLightgray;
    self.chargeParkDetail.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.chargeParkDetail];

    
    //优惠券
    self.couponParkTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.chargeParkTitle.frame.origin.y+self.chargeParkTitle.frame.size.height+5, 100, 15)];
    self.couponParkTitle.text = @"优惠券";
    self.couponParkTitle.font = [UIFont systemFontOfSize:14];
    self.couponParkTitle.textColor = fontColorBlack;
    self.couponParkTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.couponParkTitle];
    
    
    self.couponParkPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.couponParkTitle.frame.origin.y, 50, 15)];
    self.couponParkPrice.text = @"0元";
    self.couponParkPrice.font = [UIFont systemFontOfSize:14];
    self.couponParkPrice.textColor = backageColorRed;
    self.couponParkPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.couponParkPrice];
    
 
    //总计
    self.sumPriceTitle = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, self.couponParkTitle.frame.origin.y+self.couponParkTitle.frame.size.height+25, 100, 15)];
    self.sumPriceTitle.text = @"需支付总额";
    self.sumPriceTitle.font = [UIFont boldSystemFontOfSize:17];
    self.sumPriceTitle.textColor = fontColorBlack;
    self.sumPriceTitle.textAlignment = NSTextAlignmentLeft;
    [self.infoDetailView addSubview:self.sumPriceTitle];
    
    
    self.sumPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDetailView.frame.size.width-marginSize-60, self.sumPriceTitle.frame.origin.y, 50, 15)];
    self.sumPrice.text = @"￥0元";
    self.sumPrice.font = [UIFont boldSystemFontOfSize:18];
    self.sumPrice.textColor = backageColorRed;
    self.sumPrice.textAlignment = NSTextAlignmentRight;
    [self.infoDetailView addSubview:self.sumPrice];
    
    
    
 
    //优惠券视图布局
    
    self.infoCouponView = [[UIView alloc]initWithFrame:CGRectMake(0, 275, self.infoView.frame.size.width, 50)];
    self.infoCouponView.backgroundColor = backageColorYellow;
    [self.infoView addSubview:self.infoCouponView];
 
    self.couponIco = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 0, 38, self.infoCouponView.frame.size.height)];
    self.couponIco.image = [UIImage imageNamed:@"ico_order_coupon"];
    self.couponIco.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoCouponView addSubview:self.couponIco];
    
    self.couponName = [[UILabel alloc]initWithFrame:CGRectMake(self.couponIco.frame.origin.x+self.couponIco.frame.size.width+10, 0, 100, self.infoCouponView.frame.size.height)];
    self.couponName.text = @"停车场";
    self.couponName.font = [UIFont systemFontOfSize:14];
    self.couponName.textColor = [UIColor whiteColor];
    self.couponName.textAlignment = NSTextAlignmentLeft;
    [self.infoCouponView addSubview:self.couponName];
    
    self.couponFlag = [[UIImageView alloc]initWithFrame:CGRectMake(self.infoCouponView.frame.size.width-marginSize-10, 0, 10, self.infoCouponView.frame.size.height)];
    self.couponFlag.image = [UIImage imageNamed:@"ico_arrow_white"];
    self.couponFlag.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoCouponView addSubview:self.couponFlag];
    
    self.couponCount = [[UILabel alloc]initWithFrame:CGRectMake(self.couponFlag.frame.origin.x-150, 0, 140, self.infoCouponView.frame.size.height)];
    self.couponCount.text = @"0张可用";
    self.couponCount.font = [UIFont systemFontOfSize:12];
    self.couponCount.textColor = [UIColor whiteColor];
    self.couponCount.textAlignment = NSTextAlignmentRight;
    [self.infoCouponView addSubview:self.couponCount];

    
    
    //支付弹出框
 
    //支付视图
    self.payWayView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-212-64, ScreenWidth, 212)];
    self.payWayView.backgroundColor = [UIColor whiteColor];
    self.payWayView.hidden = YES;
    [self.view addSubview:self.payWayView];
    
    //支付视图标题
    self.payWayTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    self.payWayTitleView.backgroundColor = backageColorLightgray;
    [self.payWayView addSubview:self.payWayTitleView];
    
    CALayer *bottomBorder=[[CALayer alloc]init];
    bottomBorder.frame=CGRectMake(0, self.payWayTitleView.frame.size.height-0.5, self.payWayTitleView.frame.size.width, 0.5);
    bottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.payWayTitleView.layer addSublayer:bottomBorder];
    
    
    self.payWayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.payWayTitleView.frame.size.height)];
    self.payWayTitleLabel.text = @"请选择付款方式";
    self.payWayTitleLabel.font = [UIFont systemFontOfSize:18];
    self.payWayTitleLabel.textColor = fontColorBlack;
    self.payWayTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.payWayTitleView addSubview:self.payWayTitleLabel];
    
    self.payWayCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-23-marginSize*2, 0, 23+marginSize*2, self.payWayTitleView.frame.size.height)];
//    self.payWayCancelButton.backgroundColor = TEST_COLOR;
    [self.payWayCancelButton setImage:[UIImage imageNamed:@"ico_common_delete"] forState:UIControlStateNormal];
      self.payWayCancelButton.imageEdgeInsets = UIEdgeInsetsMake((50-23)/2, marginSize,(50-23)/2, marginSize);
    self.payWayCancelButton.tag = 198850;
    [self.payWayCancelButton addTarget:self action:@selector(submitAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.payWayView addSubview:self.payWayCancelButton];
    
    
    //支付视图方式选择
    self.payWayContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 162)];
    self.payWayContentView.backgroundColor = [UIColor whiteColor];
    [self.payWayView addSubview:self.payWayContentView];
    
 
    
    self.payWayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 53)];
    self.payWayTitleLabel.text = @"支付总额 ￥0元";
    self.payWayTitleLabel.font = [UIFont systemFontOfSize:14];
    self.payWayTitleLabel.textColor = backageColorRed;
    self.payWayTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.payWayContentView addSubview:self.payWayTitleLabel];
    
    self.payWayAlipayButton = [[UIButton alloc]initWithFrame:CGRectMake(marginSize, self.payWayTitleLabel.frame.origin.y+self.payWayTitleLabel.frame.size.height, ScreenWidth-marginSize*2, 40)];
    self.payWayAlipayButton.backgroundColor = backageColorBlue;
    [self.payWayAlipayButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    self.payWayAlipayButton.layer.cornerRadius = 5;
    self.payWayAlipayButton.layer.masksToBounds = YES;
    self.payWayAlipayButton.tag = 198851;
    self.payWayAlipayButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payWayAlipayButton addTarget:self action:@selector(submitAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.payWayContentView addSubview:self.payWayAlipayButton];
    
    
    self.payWayWechatButton = [[UIButton alloc]initWithFrame:CGRectMake(marginSize, self.payWayAlipayButton.frame.origin.y+self.payWayAlipayButton.frame.size.height+15, ScreenWidth-marginSize*2, 40)];
    self.payWayWechatButton.backgroundColor = backageColorGreen;
    [self.payWayWechatButton setTitle:@"微信支付" forState:UIControlStateNormal];
    self.payWayWechatButton.layer.cornerRadius = 5;
    self.payWayWechatButton.layer.masksToBounds = YES;
    self.payWayWechatButton.tag = 198852;
     self.payWayWechatButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payWayWechatButton addTarget:self action:@selector(submitAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.payWayContentView addSubview:self.payWayWechatButton];
    
}


//提交按钮点击事件
-(void)payOrder{
    [super showAlertBackage:self.payWayView];
}



/**
 *  弹出框提交事件
 *
 *  @param myButton 确认和取消按钮
 */
- (void)submitAlert:(UIButton *)myButton{
     [super hideAlertBackage];
    if (myButton.tag ==198850 ) {//取消
        
    }else if (myButton.tag ==198851 ) {//支付宝
        OrderPayCompleteController *myController = [[OrderPayCompleteController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];

    }else  if (myButton.tag ==198852 ){//微信
       
        OrderPayCompleteController *myController = [[OrderPayCompleteController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];

    }
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
