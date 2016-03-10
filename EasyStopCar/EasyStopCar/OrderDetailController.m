//
//  OrderDetailController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "OrderDetailController.h"

#import "MRProgress.h"
#import "MRCircularProgressView.h"
#import "OrderPayDetailController.h"

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapNaviKit/MAMapKit.h>


@interface OrderDetailController ()

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮

@property(nonatomic,strong)UIView *infoView;            //信息视图
@property(nonatomic,strong)UIButton *priceView;           //价格视图
@property(nonatomic,strong)UIImageView *twoDimensionalImageView;  //二维码视图
@property(nonatomic,strong)UILabel *twoDimensionalLabel;


@property(nonatomic,strong)UIView *infoDetailView;      //信息详细视图
@property(nonatomic,strong)UIView *infoTimeView;      //信息时间视图
@property(nonatomic,strong)UIView *infoLine;            //分割线

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
@property(nonatomic,strong)MRCircularProgressView *circularProgressView;
@property(nonatomic,strong)UILabel *infoTimeRemain;

@property(nonatomic,strong)UIView *appointTimeView;//预约时间视图
@property(nonatomic,strong)UILabel *appointDateLabel;
@property(nonatomic,strong)UILabel *appointTimeLabel;



//价格视图
@property(nonatomic,strong)UILabel *priceSumLabel;
@property(nonatomic,strong)UILabel *priceDetailLabel;
@property(nonatomic,strong)UIImageView *priceFlag;





//选择付款方式
@property(nonatomic,strong)UIView *payWayView;
@property(nonatomic,strong)UIView *payWayTitleView;
@property(nonatomic,strong)UIView *payWayContentView;

@property(nonatomic,strong)UILabel *payWayTitleLabel;
@property(nonatomic,strong)UIButton *payWayCancelButton;

@property(nonatomic,strong)UILabel *payWayMoneyLabel;
@property(nonatomic,strong)UIButton *payWayAlipayButton;
@property(nonatomic,strong)UIButton *payWayWechatButton;


@property(nonatomic,strong)NSTimer *myTimer;


@property(nonatomic,assign)int availableTimeValue;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"停车订单详情"];
    
    
    self.availableTimeValue = 30*60;//1800
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    self.submitButoon.tag = 198801;
    [self.submitButoon setTitle:@"导航" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorBlue;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];
    
    
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    self.infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infoView];
    
    CALayer *infoBottomBorder=[[CALayer alloc]init];
    infoBottomBorder.frame=CGRectMake(0, self.infoView.frame.size.height-0.5, self.infoView.frame.size.width, 0.5);
    infoBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.infoView.layer addSublayer:infoBottomBorder ];
    
    self.priceView = [[UIButton alloc]initWithFrame:CGRectMake(0, self.infoView.frame.origin.y+self.infoView.frame.size.height, ScreenWidth, 44)];
    self.priceView.backgroundColor = [UIColor whiteColor];
    [self.priceView addTarget:self action:@selector(payDetailClick) forControlEvents:UIControlEventTouchUpInside];
    self.priceView.hidden = YES;
    [self.view addSubview:self.priceView];
    
    CALayer *priceBottomBorder=[[CALayer alloc]init];
    priceBottomBorder.frame=CGRectMake(0, self.priceView.frame.size.height-0.5, self.priceView.frame.size.width, 0.5);
    priceBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.priceView.layer addSublayer:priceBottomBorder ];
    
    self.twoDimensionalImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, self.infoView.frame.origin.y+self.infoView.frame.size.height+15, 200, 200)];
    self.twoDimensionalImageView.image = [UIImage imageNamed:@"ico_order_two"];
    self.twoDimensionalImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.twoDimensionalImageView];
    
   
    
    
    self.twoDimensionalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.twoDimensionalImageView.frame.origin.y+self.twoDimensionalImageView.frame.size.height+15, ScreenWidth, 15)];
     self.twoDimensionalLabel.text = @"扫码取车";
    self.twoDimensionalLabel.textAlignment = NSTextAlignmentCenter;
    self.twoDimensionalLabel.font = [UIFont boldSystemFontOfSize:18];
    self.twoDimensionalLabel.textColor = fontColorBlack;
    [self.view addSubview:self.twoDimensionalLabel];
    
    
    //信息详细视图
    self.infoDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.5, self.infoView.frame.size.height)];
    [self.infoView addSubview:self.infoDetailView];
    
    self.infoLocationFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 20, 11, 15)];
    self.infoLocationFlag.image = [UIImage imageNamed:@"ico_home_cell_location"];
    self.infoLocationFlag.contentMode = UIViewContentModeScaleAspectFit;
    [self.infoView addSubview:self.infoLocationFlag];
    
    self.infoName = [[UILabel alloc]initWithFrame:CGRectMake(self.infoLocationFlag.frame.origin.x+self.infoLocationFlag.frame.size.width+5, 20, 100, 15)];
    self.infoName.text = @"您的车位";
    self.infoName.textColor = fontColorBlack;
    self.infoName.font = [UIFont systemFontOfSize:15];
    [self.infoView addSubview:self.infoName];
    
    self.infoAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.infoName.frame.origin.x, self.infoName.frame.origin.y+self.infoName.frame.size.height, 100, 30)];
    self.infoAddress.text = @"未知";
    self.infoAddress.textColor = fontColorGray;
    self.infoAddress.font = [UIFont systemFontOfSize:12];
    [self.infoView addSubview:self.infoAddress];
    
    self.infoAddressDetail = [[UILabel alloc]initWithFrame:CGRectMake(self.infoName.frame.origin.x, self.infoAddress.frame.origin.y+self.infoAddress.frame.size.height+5, 100, 30)];
    self.infoAddressDetail.text = @"未知";
    self.infoAddressDetail.textColor = fontColorBlack;
    self.infoAddressDetail.font = [UIFont boldSystemFontOfSize:15];
    [self.infoView addSubview:self.infoAddressDetail];
    
    
    self.infoDayFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, self.infoAddressDetail.frame.origin.y+self.infoAddressDetail.frame.size.height+10, 15, 15)];
    self.infoDayFlag.image = [UIImage imageNamed:@"ico_search_day"];
    [self.infoView addSubview:self.infoDayFlag];
    
    self.infoDayPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoDayFlag.frame.origin.x+self.infoDayFlag.frame.size.width+5, self.infoDayFlag.frame.origin.y, 100, 15)];
    self.infoDayPrice.text = @"￥0/小时";
    self.infoDayPrice.textColor = backageColorRed;
    self.infoDayPrice.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoDayPrice];
    
    
    self.infoNightFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, self.infoDayFlag.frame.origin.y+self.infoDayFlag.frame.size.height+10, 15, 15)];
    self.infoNightFlag.image = [UIImage imageNamed:@"ico_search_night"];
    [self.infoView addSubview:self.infoNightFlag];
    
    self.infoNightPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.infoNightFlag.frame.origin.x+self.infoNightFlag.frame.size.width+5, self.infoNightFlag.frame.origin.y, 100, 15)];
    self.infoNightPrice.text = @"￥0/小时";
    self.infoNightPrice.textColor = backageColorBlue;
    self.infoNightPrice.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.infoNightPrice];
    
    
    
    //信息时间视图
    self.infoTimeView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, 0, ScreenWidth*0.5, self.infoView.frame.size.height)];
    [self.infoView addSubview:self.infoTimeView];
    
    
    
    
    self.infoTimeName = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.infoTimeView.frame.size.width, 15)];
    self.infoTimeName.font = [UIFont systemFontOfSize:14];
    self.infoTimeName.textColor = backageColorBlue;
    self.infoTimeName.text = @"车位待停中";
    self.infoTimeName.textAlignment = NSTextAlignmentCenter;
    [self.infoTimeView addSubview:self.infoTimeName];
    
    
    //倒计时
    self.circularProgressView = [[MRCircularProgressView alloc]initWithFrame:CGRectMake((self.infoTimeView.frame.size.width-80)/2, self.infoTimeName.frame.origin.y+self.infoTimeName.frame.size.height+10, 80, 80)];
    self.circularProgressView.borderWidth = 3;
     self.circularProgressView.lineWidth = 3;
    self.circularProgressView.progress = 0;
    self.circularProgressView.myColor = backageColorBlue;
    self.circularProgressView.valueLabel.text = @"30:00";
    [self.infoTimeView addSubview:self.circularProgressView];
    
 
    
    //预约时间
    self.appointTimeView = [[UIView alloc]initWithFrame:CGRectMake((self.infoTimeView.frame.size.width-80)/2, self.infoTimeName.frame.origin.y+self.infoTimeName.frame.size.height+10, 80, 80)];
    self.appointTimeView.hidden = YES;
    //设置圆角边框
    self.appointTimeView.layer.cornerRadius = 8;
    self.appointTimeView.layer.masksToBounds = YES;
    //设置边框及边框颜色
    self.appointTimeView.layer.borderWidth = 1.0;
    self.appointTimeView.layer.borderColor =[ backageColorBlue CGColor];
    [self.infoTimeView addSubview:self.appointTimeView];
    
    self.appointDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.appointTimeView.frame.size.width, 30)];
//    self.appointDateLabel.font = [UIFont systemFontOfSize:18];
     self.appointDateLabel.font = [UIFont fontWithName:@"MyriadSetPro-Thin" size:18];
    self.appointDateLabel.backgroundColor = backageColorBlue;
    self.appointDateLabel.textColor = [UIColor whiteColor];
    self.appointDateLabel.text = @"0月0日";
    self.appointDateLabel.textAlignment = NSTextAlignmentCenter;
    [self.appointTimeView addSubview:self.appointDateLabel];
    
    
    self.appointTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.appointDateLabel.frame.size.height, self.appointTimeView.frame.size.width, self.appointTimeView.frame.size.height-self.appointDateLabel.frame.size.height)];
//    self.appointTimeLabel.font = [UIFont systemFontOfSize:22];
     self.appointTimeLabel.font = [UIFont fontWithName:@"MyriadSetPro-Thin" size:22];
    self.appointTimeLabel.textColor = backageColorBlue;
    self.appointTimeLabel.text = @"0:00";
    self.appointTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.appointTimeView addSubview:self.appointTimeLabel];
    
    
    
    
    self.infoTimeRemain = [[UILabel alloc]initWithFrame:CGRectMake(0, self.infoTimeView.frame.size.height-15-20, self.infoTimeView.frame.size.width, 15)];
    self.infoTimeRemain.font = [UIFont systemFontOfSize:12];
    self.infoTimeRemain.textColor = backageColorBlue;
    self.infoTimeRemain.text = @"请在时间内到达";
    self.infoTimeRemain.textAlignment = NSTextAlignmentCenter;
    [self.infoTimeView addSubview:self.infoTimeRemain];
    
     self.infoLine = [[UIView alloc]initWithFrame:CGRectMake(self.infoView.frame.size.width*0.5, marginSize, 0.5, self.infoTimeView.frame.size.height-marginSize*2)];
    self.infoLine.backgroundColor = lineColorLightgray;
    [self.infoView addSubview:self.infoLine];
    
    
    //费用视图布局
    self.priceSumLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.infoName.frame.origin.x, 0, 200, self.priceView.frame.size.height)];
    self.priceSumLabel.font = [UIFont systemFontOfSize:14];
    self.priceSumLabel.textColor = fontColorGray;
    self.priceSumLabel.text = @"费用共计：￥0元";
    [self.priceView addSubview:self.priceSumLabel];
    
    self.priceFlag = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-marginSize-10, 0, 7, self.priceView.frame.size.height)];
    self.priceFlag.image = [UIImage imageNamed:@"ico_home_select_arrow"];
    self.priceFlag.contentMode = UIViewContentModeScaleAspectFit;
    [self.priceView addSubview:self.self.priceFlag];
    
    self.priceDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceFlag.frame.origin.x-80, 0, 70, self.priceView.frame.size.height)];
    self.priceDetailLabel.font = [UIFont systemFontOfSize:14];
    self.priceDetailLabel.textColor = fontColorGray;
    self.priceDetailLabel.text = @"费用明细";
    self.priceDetailLabel.textAlignment = NSTextAlignmentRight;
    [self.priceView addSubview:self.priceDetailLabel];
    
    
    
    
    //弹出框----------------------------------------------------------
    
    //支付视图
    self.payWayView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-180-64, ScreenWidth, 180)];
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
    self.payWayTitleLabel.text = @"请选择导航方式";
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
    self.payWayContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 130)];
    self.payWayContentView.backgroundColor = [UIColor whiteColor];
    [self.payWayView addSubview:self.payWayContentView];
    
   
    
    self.payWayAlipayButton = [[UIButton alloc]initWithFrame:CGRectMake(marginSize, 20, ScreenWidth-marginSize*2, 40)];
    self.payWayAlipayButton.backgroundColor = backageColorBlue;
    [self.payWayAlipayButton setTitle:@"百度地图" forState:UIControlStateNormal];
    self.payWayAlipayButton.layer.cornerRadius = 5;
    self.payWayAlipayButton.layer.masksToBounds = YES;
    self.payWayAlipayButton.tag = 198851;
    self.payWayAlipayButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payWayAlipayButton addTarget:self action:@selector(submitAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.payWayContentView addSubview:self.payWayAlipayButton];
    
    
    self.payWayWechatButton = [[UIButton alloc]initWithFrame:CGRectMake(marginSize, self.payWayAlipayButton.frame.origin.y+self.payWayAlipayButton.frame.size.height+15, ScreenWidth-marginSize*2, 40)];
    self.payWayWechatButton.backgroundColor = backageColorGreen;
    [self.payWayWechatButton setTitle:@"高德地图" forState:UIControlStateNormal];
    self.payWayWechatButton.layer.cornerRadius = 5;
    self.payWayWechatButton.layer.masksToBounds = YES;
    self.payWayWechatButton.tag = 198852;
    self.payWayWechatButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payWayWechatButton addTarget:self action:@selector(submitAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.payWayContentView addSubview:self.payWayWechatButton];
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    
    [self initControllerByType];
}


//根据类型，初始化控制器
-(void)initControllerByType{
    
    if(self.orderType == 1){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoDimensionalClick:)];
        [self.twoDimensionalImageView addGestureRecognizer:tapGesture];
    
    }else  if(self.orderType == 2){//已停
    
        self.infoTimeName.text = @"车位使用中";
        self.infoTimeName.textColor = backageColorGreen;
        self.infoTimeRemain.text = @"已停时间";
        self.infoTimeRemain.textColor = backageColorGreen;
        self.priceView.hidden = NO;
        self.submitButoon.hidden = YES;
        self.circularProgressView.myColor = backageColorGreen;

        self.twoDimensionalImageView.frame = CGRectMake((ScreenWidth-200)/2, self.infoView.frame.origin.y+self.infoView.frame.size.height+65, 200, 200);
        
        self.twoDimensionalLabel.frame = CGRectMake(0, self.twoDimensionalImageView.frame.origin.y+self.twoDimensionalImageView.frame.size.height+10, ScreenWidth, 15);
        
    }else if(self.orderType == 3){//预约
         [self.myTimer invalidate];
        self.circularProgressView.hidden = YES;
         self.appointTimeView.hidden = NO;
         self.infoTimeName.text = @"已预约";
        self.infoTimeRemain.text = @"请在此时间内到达";
    [self.submitButoon setTitle:@"取消预约" forState:UIControlStateNormal];
        self.submitButoon.backgroundColor = backageColorRed;
        self.submitButoon.tag = 198802;
    }
    

}



//二维码点击事件
-(void)twoDimensionalClick: (UITapGestureRecognizer*)recognizer{
    //获取所点击视图recognizer.view
  
    self.orderType = 2;
    [self initControllerByType];
    
}




//支付详细点击时间
-(void)payDetailClick{
    OrderPayDetailController *myController = [[OrderPayDetailController alloc]init];
    [self.navigationController pushViewController:myController animated:YES];
    
}

//计时器调用方法
- (void)timerAdvanced:(NSTimer *)timer//这个函数将会执行一个循环的逻辑
{
    if (self.orderType == 1) {//待停
 
    float progress = (1 - self.availableTimeValue/1800.0);
    NSLog(@"开始倒计时%f",progress);
    self.circularProgressView.progress = progress;
    
    self.circularProgressView.valueLabel.text = [NSString stringWithFormat:@"%d:%02d",self.availableTimeValue/60,self.availableTimeValue%60];
    
    if (self.availableTimeValue == 0) {
        [self.myTimer invalidate];
    }else{
        self.availableTimeValue--;
    }
        
    }else{//已停
        self.availableTimeValue++;
        self.circularProgressView.valueLabel.text = [NSString stringWithFormat:@"%d:%02d",self.availableTimeValue/3600,self.availableTimeValue%3600/60];
        
    }
}



/**
 *  弹出框提交事件
 *
 *  @param myButton 确认和取消按钮
 */
- (void)submitAlert:(UIButton *)myButton{
    [super hideAlertBackage];
    
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = 39.90868;
    coor2.longitude = 116.3956;
    
    if (myButton.tag == 198851) {//百度地图
        
            //初始化调启导航时的参数管理类
            BMKNaviPara* para = [[BMKNaviPara alloc]init];
            //初始化起点节点
            BMKPlanNode* start = [[BMKPlanNode alloc]init];
            //指定起点经纬度
            CLLocationCoordinate2D coor1;
            coor1.latitude = 39.90868;
            coor1.longitude = 116.204;
            start.pt = coor1;
            //指定起点名称
            start.name = @"我的位置";
            //指定起点
            para.startPoint = start;
        
            //初始化终点节点
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
        
            end.pt = coor2;
            //指定终点名称
            end.name = @"天安门";
            //指定终点
            para.endPoint = end;
        
            //指定返回自定义scheme
            para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
        
            //调启百度地图客户端导航
            [BMKNavigation openBaiduMapNavigation:para];
    }else if(myButton.tag == 198852){//高德地图
        //配置导航参数
        MANaviConfig * config = [[MANaviConfig alloc] init];
        config.destination = coor2;//终点坐标，Annotation的坐标
        config.appScheme = [self getApplicationScheme];//返回的Scheme，需手动设置
        config.appName = [self getApplicationName];//应用名称，需手动设置
        config.strategy = MADrivingStrategyShortest;
        //若未调起高德地图App,引导用户获取最新版本的
        if(![MAMapURLSearch openAMapNavigation:config])
        {
            [MAMapURLSearch getLatestAMapApp];
        }
        
        
    }else{
//        [self toReturn];
        
    }

}




//调转到百度地图客户端导航
- (void)submitInfo:(UIButton *)myButton {
    
  [super showAlertBackage:self.payWayView];
}



- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图即将消失
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"消失！！！！！");
    [self.myTimer invalidate];
}

@end
