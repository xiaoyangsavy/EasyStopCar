//
//  SearchPartMapController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartMapController.h"
#import "CommonTools.h"
#import "SearchAppointController.h"
#import "OrderDetailController.h"

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface SearchPartMapController ()
{
    UITextField *currentTextField;
}
@property(nonatomic,strong) BMKMapView* mapView;                //百度地图
@property(nonatomic,strong) BMKLocationService* locService;     //定位服务
@property(nonatomic,strong) BMKRouteSearch* routesearch;       //路线搜索

@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容

//预约条件视图
@property(nonatomic,strong)UIView *appointConditionView;
@property(nonatomic,strong)UILabel *appointLocationLabel;//预约地点
@property(nonatomic,strong)UIImageView *appointElectricityFlag;//预约有电标识
@property(nonatomic,strong)UILabel *appointDataLabel;//预约时间
@property(nonatomic,strong)UIButton *appointEditButton;//预约修改按钮




@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮
@property(nonatomic,strong)UIView *infoBackageView;
@property(nonatomic,strong)UIView *infoView;            //信息视图
@property(nonatomic,strong)UIView *electricityView;     //电价视图
@property(nonatomic,strong)UIView *priceView;           //价格视图



@property(nonatomic,strong)UIImageView *headImageView;  //头像
@property(nonatomic,strong)UIImageView *positionFlag;  //地址标记
@property(nonatomic,strong)UILabel *nameLabel;          //名称
@property(nonatomic,strong)UILabel *distanceLabel;      //距离
@property(nonatomic,strong)UILabel *infoLabel;          //说明
@property(nonatomic,strong)UILabel *remainderLabel;     //剩余车位

@property(nonatomic,strong)UIImageView *electricityFlag;//电标识
@property(nonatomic,strong)UILabel *electricityPriceLabel;//价格
@property(nonatomic,strong)UILabel *electricityInfoLabel;//提示说明
@property(nonatomic,strong)UISwitch *electricitySwitch;//开关

@property(nonatomic,strong)UIImageView *priceDayFlag;//白天标识
@property(nonatomic,strong)UILabel *priceDayPriceLabel;//价格
@property(nonatomic,strong)UILabel *priceDayBusinessHoursLabel;//营业时间
@property(nonatomic,strong)UIView *priceCutLine;//分割线
@property(nonatomic,strong)UIImageView *priceNightFlag;//晚上标识
@property(nonatomic,strong)UILabel *priceNightPriceLabel;//价格
@property(nonatomic,strong)UILabel *priceNightBusinessHoursLabel;//营业时间

//弹出框
@property(nonatomic,strong)UIView *submitAlertView;
@property(nonatomic,strong)UIView *submitInfoView;
@property(nonatomic,strong)UIView *submitButtonView;
@property(nonatomic,strong)UILabel *submitInfoTitle;
@property(nonatomic,strong)UILabel *submitInfoContent;

@property(nonatomic,strong)UIButton *submitButtonConcel;
@property(nonatomic,strong)UIButton *submitButtonAffirm;

@property(nonatomic,strong)UIView *submitInfoContentView;
@property(nonatomic,strong)UIImageView *submitInfoImageView;
@property(nonatomic,strong)UIView *submitInfoContentAppointView;
@property(nonatomic,strong)UILabel *submitInfoContentAppointDateLabel;
@property(nonatomic,strong)UILabel *submitInfoContentAppointTimeLabel;

@property (nonatomic, assign) CLLocationCoordinate2D userLocationCoordinate2D;
@property (nonatomic, assign) BOOL isFirest;

@end

@implementation SearchPartMapController

- (void)viewDidLoad {
    [super viewDidLoad];
   
 
     [super addRightButton:@"button_map_refresh" lightedImage:@"button_map_refresh" selector:@selector(refreshMap)];
    
    
    //搜索框
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [self.navigationItem setTitleView:searchView];
    
    //    UIImageView *serachBackageView = [[UIImageView alloc]initWithFrame:CGRectMake(-20, searchView.frame.size.height-15, searchView.frame.size.width+40, 5)];
    //    serachBackageView.image = [UIImage imageNamed:@"hh_backage_serach"];
    //    serachBackageView.contentMode = UIViewContentModeScaleAspectFit;
    //    [searchView addSubview:serachBackageView];
    
    UIImageView *serachIcoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 40)];
    serachIcoView.image = [UIImage imageNamed:@"ico_navigation_search"];
    serachIcoView.contentMode = UIViewContentModeScaleAspectFit;
    [searchView addSubview:serachIcoView];
    
    UITextField *serachTextField = [[UITextField alloc]initWithFrame:CGRectMake(serachIcoView.frame.origin.x+serachIcoView.frame.size.width+2, 0, searchView.frame.size.width-10, 40)];
    //    [serachTextField setPlaceholder:@"请搜索商品"];
    serachTextField.font = [UIFont systemFontOfSize:14];
    serachTextField.textColor = [UIColor whiteColor];
    serachTextField.delegate = self;
    serachTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索停车场" attributes:@{
                                                                                                             NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8],
                                                                                                             NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    serachTextField.textColor = [UIColor whiteColor];
    [searchView addSubview:serachTextField];
    
    //定位服务
     _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;  //设置定位精确度，默认：kCLLocationAccuracyBest
    _locService.distanceFilter = 100.0f; //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    //启动LocationService
    [_locService startUserLocationService];
    //搜索服务
    self.routesearch = [[BMKRouteSearch alloc]init];
    //百度地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
//    _mapView.zoomLevel = 14;
     [self.view addSubview:_mapView];

   
    
    //路线弹出视图------------------------------------------------------------------------
    //点击地图大头针后弹出
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.submitButoon setTitle:@"我要停车" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitButoon.hidden = YES;
    [self.view addSubview:self.submitButoon];
    
    
    self.infoBackageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100+40+40)];
    self.infoBackageView.backgroundColor = [UIColor whiteColor];
    self.infoBackageView.hidden = YES;
    [self.view addSubview:self.infoBackageView];
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [self.infoBackageView addSubview:self.infoView];
    
    CALayer *infoBottomBorder=[[CALayer alloc]init];
    infoBottomBorder.frame=CGRectMake(0, self.infoView.frame.size.height-0.5, self.infoView.frame.size.width, 0.5);
    infoBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.infoView.layer addSublayer:infoBottomBorder];
    
    
    self.electricityView = [[UIView alloc]initWithFrame:CGRectMake(0, self.infoView.frame.origin.y+self.infoView.frame.size.height, ScreenWidth, 40)];
    [self.infoBackageView addSubview:self.electricityView];
    
    CALayer *electricityBottomBorder=[[CALayer alloc]init];
    electricityBottomBorder.frame=CGRectMake(0, self.electricityView.frame.size.height-0.5, self.electricityView.frame.size.width, 0.5);
    electricityBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.electricityView.layer addSublayer:electricityBottomBorder];
    
    self.priceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.electricityView.frame.origin.y+self.electricityView.frame.size.height, ScreenWidth, 40)];
    [self.infoBackageView addSubview:self.priceView];
    
    CALayer *priceBottomBorder=[[CALayer alloc]init];
    priceBottomBorder.frame=CGRectMake(0, self.priceView.frame.size.height-0.5, self.priceView.frame.size.width, 0.5);
    priceBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.priceView.layer addSublayer:priceBottomBorder];
    
    
    
    
    
    //信息视图
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 13, 75, 75)];
    self.headImageView.layer.cornerRadius = 37.5;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
    [self.infoView addSubview:self.headImageView];
    
    self.positionFlag = [[UIImageView alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width+10, 20, 11.5, 15)];
    self.positionFlag.image = [UIImage imageNamed:@"ico_home_cell_location"];
    [self.infoView addSubview:self.positionFlag];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.positionFlag.frame.origin.x+self.positionFlag.frame.size.width+5, self.positionFlag.frame.origin.y, 150, 15)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = fontColorBlack;
    self.nameLabel.text = @"未知";
    [self.infoView addSubview:self.nameLabel];
    
    
    self.distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-marginSize-70, self.positionFlag.frame.origin.y, 70, 15)];
    self.distanceLabel.font = [UIFont systemFontOfSize:14];
    self.distanceLabel.textColor = fontColorLightgray;
    self.distanceLabel.text = @"0km";
    self.distanceLabel.textAlignment = NSTextAlignmentRight;
    [self.infoView addSubview:self.distanceLabel];
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height+5, 200, 15)];
    self.infoLabel.font = [UIFont systemFontOfSize:12];
    self.infoLabel.textColor = fontColorLightgray;
    self.infoLabel.text = @"停车0次，部分车位限小型车";
    [self.infoView addSubview:self.infoLabel];
    
    self.remainderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.headImageView.frame.origin.y+self.headImageView.frame.size.height-20, 200, 15)];
    self.remainderLabel.font = [UIFont systemFontOfSize:14];
    self.remainderLabel.textColor = fontColorGray;
    self.remainderLabel.text = @"0个空闲车位";
    [self.infoView addSubview:self.remainderLabel];
    
    
    //电价视图
    self.electricityFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, (self.electricityView.frame.size.height-15)/2, 15, 15)];
    self.electricityFlag.image = [UIImage imageNamed:@"ico_home_cell_flag"];
    [self.electricityView addSubview:self.electricityFlag];
    
    self.electricityPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.electricityFlag.frame.origin.x+self.electricityFlag.frame.size.width+5, 0, 65, self.electricityView.frame.size.height)];
    self.electricityPriceLabel.font = [UIFont systemFontOfSize:14];
    self.electricityPriceLabel.textColor = backageColorGreen;
    self.electricityPriceLabel.text = @"￥0/小时";
    [self.electricityView addSubview:self.electricityPriceLabel];
    
    self.electricityInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.electricityPriceLabel.frame.origin.x+self.electricityPriceLabel.frame.size.width-5, 1, 150, self.electricityView.frame.size.height)];
    self.electricityInfoLabel.font = [UIFont systemFontOfSize:9];
    self.electricityInfoLabel.textColor = fontColorGray;
    self.electricityInfoLabel.text = @"（电费￥0/度+服务费￥0/度）";
    [self.electricityView addSubview:self.electricityInfoLabel];
    
    self.electricitySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-60,4,0,0)];
    [self.electricityView addSubview:self.electricitySwitch];
    [self.electricitySwitch setOn:YES animated:YES];
    
    //价格视图
    
    self.priceDayFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, (self.priceView.frame.size.height-15)/2, 15, 15)];
    self.priceDayFlag.image = [UIImage imageNamed:@"ico_search_day"];
    [self.priceView addSubview:self.priceDayFlag];
    
    self.priceDayPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceDayFlag.frame.origin.x+self.priceDayFlag.frame.size.width+3, 0, 65, self.priceView.frame.size.height)];
    self.priceDayPriceLabel.font = [UIFont systemFontOfSize:14];
    self.priceDayPriceLabel.textColor = backageColorRed;
    self.priceDayPriceLabel.text = @"￥0/小时";
    [self.priceView addSubview:self.priceDayPriceLabel];
    
    self.priceDayBusinessHoursLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceDayPriceLabel.frame.origin.x+self.priceDayPriceLabel.frame.size.width, 4, 70, self.priceView.frame.size.height-self.priceDayBusinessHoursLabel.frame.origin.y)];
    self.priceDayBusinessHoursLabel.font = [UIFont systemFontOfSize:9];
    self.priceDayBusinessHoursLabel.textColor = fontColorGray;
    self.priceDayBusinessHoursLabel.text = @"0:00-24:00";
//    self.priceDayBusinessHoursLabel.textAlignment = NSTextAlignmentRight;
    [self.priceView addSubview:self.priceDayBusinessHoursLabel];
    
    
    self.priceCutLine = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, 5, 0.5, self.priceView.frame.size.height-10)];
    self.priceCutLine.backgroundColor = lineColorLightgray;
    [self.priceView addSubview:self.priceCutLine];
    
    
    self.priceNightFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize+ScreenWidth*0.5, (self.priceView.frame.size.height-15)/2, 15, 15)];
    self.priceNightFlag.image = [UIImage imageNamed:@"ico_search_night"];
    [self.priceView addSubview:self.priceNightFlag];
    
    self.priceNightPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceNightFlag.frame.origin.x+self.priceDayFlag.frame.size.width+3, 0, 65, self.priceView.frame.size.height)];
    self.priceNightPriceLabel.font = [UIFont systemFontOfSize:14];
    self.priceNightPriceLabel.textColor = backageColorBlue;
    self.priceNightPriceLabel.text = @"￥0/小时";
    [self.priceView addSubview:self.priceNightPriceLabel];
    
    self.priceNightBusinessHoursLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceNightPriceLabel.frame.origin.x+self.priceNightPriceLabel.frame.size.width, 4, 70, self.priceView.frame.size.height-self.priceDayBusinessHoursLabel.frame.origin.y)];
    self.priceNightBusinessHoursLabel.font = [UIFont systemFontOfSize:9];
    self.priceNightBusinessHoursLabel.textColor = fontColorGray;
    self.priceNightBusinessHoursLabel.text = @"0:00-24:00";
//    self.priceNightBusinessHoursLabel.textAlignment = NSTextAlignmentRight;
    [self.priceView addSubview:self.priceNightBusinessHoursLabel];
    
    
    //弹出框***********************************************************************
    self.submitAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-206-50, ScreenWidth, 206+50)];
    self.submitAlertView.hidden = YES;
    [self.view addSubview:self.submitAlertView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.submitAlertView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.submitAlertView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.submitAlertView.layer.mask = maskLayer;
    
    
    self.submitInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 206)];
    self.submitInfoView.backgroundColor = [UIColor whiteColor];
    [self.submitAlertView addSubview:self.submitInfoView];
    
    self.submitButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 206, ScreenWidth, 50)];
    self.submitButtonView.backgroundColor = backageColorRed;
    [self.submitAlertView addSubview:self.submitButtonView];
    
    //提交信息显示
    self.submitInfoTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 15)];
    self.submitInfoTitle.text = @"确认停车？";
    [self.submitInfoTitle setTextColor:fontColorBlack];
    self.submitInfoTitle.textAlignment = NSTextAlignmentCenter;
    self.submitInfoTitle.font = [UIFont systemFontOfSize:18];
    [self.submitInfoView addSubview:self.submitInfoTitle];
    
    self.submitInfoContentView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.submitInfoView.frame.size.height-80)/2-10, ScreenWidth, 80)];
    [self.submitAlertView addSubview:self.submitInfoContentView];
    
    //提交信息内容显示
    self.submitInfoContent = [[UILabel alloc] initWithFrame:CGRectMake(0, self.submitInfoView.frame.size.height-40-20, ScreenWidth, 40)];
    self.submitInfoContent.text = @"下单后会为您冻结车位30分钟\n请尽快到达";
    [self.submitInfoContent setTextColor:backageColorBlue];
    self.submitInfoContent.lineBreakMode = NSLineBreakByWordWrapping;
    self.submitInfoContent.numberOfLines = 0;//上面两行设置多行显示
    self.submitInfoContent.font = [UIFont systemFontOfSize:15];
    self.submitInfoContent.textAlignment = NSTextAlignmentCenter;
    [self.submitInfoView addSubview:self.submitInfoContent];
    
    
    
    //提交按钮区域
    self.submitButtonConcel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButtonConcel.frame = CGRectMake(0, 0, ScreenWidth*0.5, self.submitButtonView.frame.size.height);
    self.submitButtonConcel.tag = 198851;
    [self.submitButtonConcel setTitle:@"取消" forState:UIControlStateNormal];
    self.submitButtonConcel.backgroundColor = [UIColor blackColor];
    self.submitButtonConcel.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.submitButtonConcel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButtonConcel addTarget:self action:@selector(submitAlert:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButtonView addSubview:self.submitButtonConcel];
    
    self.submitButtonAffirm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButtonAffirm.frame = CGRectMake(ScreenWidth*0.5, 0, ScreenWidth*0.5, self.submitButtonView.frame.size.height);
    self.submitButtonAffirm.tag = 198852;
    self.submitButtonAffirm.backgroundColor = backageColorRed;
    [self.submitButtonAffirm setTitle:@"确认" forState:UIControlStateNormal];
    self.submitButtonConcel.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.submitButtonConcel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButtonAffirm addTarget:self action:@selector(submitAlert:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButtonView addSubview:self.submitButtonAffirm];
    
 

    //停车时间
    self.submitInfoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2, 0, 80, 80)];
    self.submitInfoImageView.image = [UIImage imageNamed:@"image_order_part_time"];
    [self.submitInfoContentView addSubview:self.submitInfoImageView];
    
    
    //预约时间
    self.submitInfoContentAppointView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2, 0, 80, 80)];
    self.submitInfoContentAppointView.hidden = YES;
    //设置圆角边框
    self.submitInfoContentAppointView.layer.cornerRadius = 8;
    self.submitInfoContentAppointView.layer.masksToBounds = YES;
    //设置边框及边框颜色
    self.submitInfoContentAppointView.layer.borderWidth = 1.0;
    self.submitInfoContentAppointView.layer.borderColor =[ backageColorBlue CGColor];
    [self.submitInfoContentView addSubview:self.submitInfoContentAppointView];
    
    self.submitInfoContentAppointDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.submitInfoContentAppointView.frame.size.width, 30)];
//    self.submitInfoContentAppointDateLabel.font = [UIFont systemFontOfSize:18];
    self.submitInfoContentAppointDateLabel.backgroundColor = backageColorBlue;
    self.submitInfoContentAppointDateLabel.textColor = [UIColor whiteColor];
    self.submitInfoContentAppointDateLabel.text = @"0月0日";
    self.submitInfoContentAppointDateLabel.textAlignment = NSTextAlignmentCenter;
    self.submitInfoContentAppointDateLabel.font = [UIFont fontWithName:@"MyriadSetPro-Thin" size:18];
    [self.submitInfoContentAppointView addSubview:self.submitInfoContentAppointDateLabel];
    
    
    self.submitInfoContentAppointTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.submitInfoContentAppointDateLabel.frame.size.height, self.submitInfoContentAppointView.frame.size.width, self.submitInfoContentAppointView.frame.size.height-self.submitInfoContentAppointDateLabel.frame.size.height)];
//    self.submitInfoContentAppointTimeLabel.font = [UIFont systemFontOfSize:22];
    self.submitInfoContentAppointTimeLabel.textColor = backageColorBlue;
    self.submitInfoContentAppointTimeLabel.text = @"0:00";
    self.submitInfoContentAppointTimeLabel.textAlignment = NSTextAlignmentCenter;
     self.submitInfoContentAppointTimeLabel .font = [UIFont fontWithName:@"MyriadSetPro-Thin" size:22];
    [self.submitInfoContentAppointView addSubview:self.submitInfoContentAppointTimeLabel];
    
    
    
    
    
    
    
    if (self.styleType == 1) {
        [self initAppointStyle];
    }
   
}

//初始化预约样式
-(void)initAppointStyle{
    self.submitInfoImageView.hidden = YES;
     self.submitInfoContentAppointView.hidden = NO;
  self.submitInfoContent.text = @"下单后车位会为您保留\n请尽快到达";
    
    _mapView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40);
    
    
    //列表区域
    self.appointConditionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    self.appointConditionView.backgroundColor = backageColorLightgray;
    [self.view addSubview:self.appointConditionView];
    
    CALayer *bottomBorder=[[CALayer alloc]init];
    bottomBorder.frame=CGRectMake(0, self.appointConditionView.frame.size.height-0.5, self.appointConditionView.frame.size.width, 0.5);
    bottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.appointConditionView.layer addSublayer:bottomBorder ];
    
    
    self.appointLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, 0, 100, self.appointConditionView.frame.size.height)];
    self.appointLocationLabel.text = self.searchedLocation;
    self.appointLocationLabel.font = [UIFont systemFontOfSize:14];
    self.appointLocationLabel.textColor = fontColorGray;
    [self.appointConditionView addSubview:self.appointLocationLabel];
    
    self.appointElectricityFlag = [[UIImageView alloc]initWithFrame:CGRectMake(self.appointLocationLabel.frame.origin.x+self.appointLocationLabel.frame.size.width, 0, 20, self.appointConditionView.frame.size.height)];
    self.appointElectricityFlag.image = [UIImage imageNamed:@"ico_home_cell_flag"];self.appointElectricityFlag.contentMode = UIViewContentModeScaleAspectFit;
    [self.appointConditionView addSubview:self.appointElectricityFlag];
    
    self.appointDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.appointElectricityFlag.frame.origin.x+self.appointElectricityFlag.frame.size.width+5, 0, 100, self.appointConditionView.frame.size.height)];
    self.appointDataLabel.text = self.searchedData;
    self.appointDataLabel.font = [UIFont systemFontOfSize:14];
    self.appointDataLabel.textColor = fontColorGray;
    [self.appointConditionView addSubview:self.appointDataLabel];
    
    self.appointEditButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-30, 0, 30, self.appointConditionView.frame.size.height)];
    [self.appointEditButton setImage:[UIImage imageNamed:@"ico_park_edit"] forState:UIControlStateNormal];
    [self.appointEditButton addTarget:self action:@selector(toEditPage) forControlEvents:UIControlEventTouchUpInside];
    [self.appointConditionView addSubview:self.appointEditButton];
    
     self.appointElectricityFlag.hidden = !self.isElectricity;//有电符号是否显示
    
    
     [super initNavBarItems:@"停车场"];
    
    
 
}


//跳转到编辑页面
-(void)toEditPage{
    [super toReturn:2];
    SearchAppointController  *myViewController = [[SearchAppointController alloc]init];
    [self.navigationController pushViewController:myViewController animated:YES];
}


//初始化预约样式
-(void)hideRouteStyle:(BOOL)flag{
    self.submitButoon.hidden = flag;
    self.infoBackageView.hidden = flag;
    if (!flag) {//显示弹出框
    self.mapView.frame = CGRectMake(0, self.infoBackageView.frame.origin.y+self.infoBackageView.frame.size.height, ScreenWidth, ScreenHeight-self.infoBackageView.frame.origin.y-self.infoBackageView.frame.size.height-self.submitButoon.frame.size.height);
    }else{//隐藏弹出框
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
         _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
        //    _mapView.zoomLevel = 14;
        [self.view addSubview:_mapView];
        [self initTestData];
    }
}



//初始化测试数据
-(void)initTestData{

    //测试数据：加入地图定位坐标
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.90868;
    coor.longitude = 116.204;
    annotation.coordinate = coor;
    annotation.title = @"西直门";
    annotation.subtitle = @"99";
    [self.mapView addAnnotation:annotation];
    
    annotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 39.9660160357;
    coor.longitude = 116.2890118361;
    annotation.coordinate = coor;
    annotation.title = @"火器营";
    annotation.subtitle = @"1";
    [self.mapView addAnnotation:annotation];


}


//刷新页面
-(void)refreshMap{
    NSLog(@"刷新页面");
    
    [self hideRouteStyle:YES];

}

//提交按钮点击事件
-(void)submitClick{
    [super showAlertBackage:self.submitAlertView];
}



/**
 *  弹出框提交事件
 *
 *  @param myButton 确认和取消按钮
 */
- (void)submitAlert:(UIButton *)myButton{
    if (myButton.tag ==198851 ) {//取消
        [super hideAlertBackage];
    }else  if (myButton.tag ==198852 ){//确认
        [super hideAlertBackage];
        OrderDetailController *myController = [[OrderDetailController alloc]init];
         if (self.styleType == 1) {
              myController.orderType = 3;//预约订单
         }else{
        myController.orderType = 1;//预约订单
         }
        [self.navigationController pushViewController:myController animated:YES];
    }
    
}


//检索行车路线
-(void)onClickDriveSearch
{
    BMKPlanNode *startNode = [[BMKPlanNode alloc]init];
    //    startNode.name = @"龙泽";
    //    startNode.cityName = @"北京市";
//    CLLocationCoordinate2D startCoordinate;
//    startCoordinate.latitude = self.userLocationCoordinate2D.latitude;
//    startCoordinate.longitude = self.userLocationCoordinate2D.longitude;
    startNode.pt = _locService.userLocation.location.coordinate;
    BMKPlanNode *endNode = [[BMKPlanNode alloc]init];
    //    endNode.name = @"西单";
    //    endNode.cityName = @"北京市";
    CLLocationCoordinate2D endCoordnate;
    endCoordnate.latitude =39.90868;
    endCoordnate.longitude =116.204;
    endNode.pt = endCoordnate;
    BMKDrivingRoutePlanOption * drivingRoutePlanOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRoutePlanOption.from = startNode;
    drivingRoutePlanOption.to = endNode;
    if ([self.routesearch drivingSearch:drivingRoutePlanOption]) {
        NSLog(@"路线查找成功");
    }else{
        NSLog(@"路线查找失败");
    }
}



#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [currentTextField resignFirstResponder];
    NSString *searchText = textField.text;
    NSLog(@"搜索框输入的内容为%@！！！！！！！",searchText);
    self.searchedContent = nil;         //开始输入后，清楚之前确认的内容
    self.searchedContent = searchText; //正在输入的内容
    return YES;
}

#pragma mark 百度地图delegate

//重写大头针样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    //     NSLog(@"捕获地图动画");
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSLog(@"重写大头针样式");
        
        UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50*1.2, 100*1.2)];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewForImage.frame.size.width, viewForImage.frame.size.height)];
        [imageview setImage:[UIImage imageNamed:@"button_map_loacation_default"]];
        [viewForImage addSubview:imageview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewForImage.frame.size.width, viewForImage.frame.size.height)];
        label.text=annotation.subtitle;
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:30];
        label.textColor = fontColorBlack;
        [viewForImage addSubview:label];

        
        
        
        CommonTools *commonTools = [[CommonTools alloc]init];//工具类
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        newAnnotationView.annotation=annotation;
        
        newAnnotationView.image=[commonTools getImageFromView:viewForImage];   //把大头针换成别的图片
        
        return newAnnotationView;
        
    }
    return nil;
    
}

//点击大头针监听
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
//    SearchPartDetailController *searchPartDetailController = [[SearchPartDetailController alloc]init];
//    searchPartDetailController.styleType = self.styleType;
//    searchPartDetailController.searchedLocation = self.searchedLocation;
//    searchPartDetailController.searchedData = self.searchedData;
//    [self.navigationController pushViewController:searchPartDetailController animated:YES];
    NSLog(@"点击大头针");
    view.paopaoView.hidden = YES;//隐藏弹出泡泡
    
    [self hideRouteStyle:NO];
     [self onClickDriveSearch];//检索路线

}



//点击泡泡监听
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
//    NSLog(@"点击弹出泡泡");
// 
//}

#pragma mark 路线搜索delegate
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点  （途径节点）
//            RouteAnnotation* item = [[RouteAnnotation alloc]init];
//            item.coordinate = transitStep.entrace.location;
//            item.title = transitStep.entraceInstruction;
//            item.degree = transitStep.direction * 30;
//            item.type = 4;
//            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}


//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark 定位服务delegate
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//     self.userLocationCoordinate2D = userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _routesearch.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
     _locService.delegate = nil;
     _routesearch.delegate = nil;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
     [self initTestData];//初始化测试数据
    
    if (self.isDetail) {
        [self hideRouteStyle:NO];
        [self onClickDriveSearch];//开启路线规划
    }
    
}

@end
