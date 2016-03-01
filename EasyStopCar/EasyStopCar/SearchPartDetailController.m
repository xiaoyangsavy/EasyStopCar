//
//  SearchPartDetailController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartDetailController.h"
#import "CommonTools.h"

@interface SearchPartDetailController ()
{
    UITextField *currentTextField;
}

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮
@property(nonatomic,strong)UIScrollView *homeScroll;
@property(nonatomic,strong)UIView *infoView;            //信息视图
@property(nonatomic,strong)UIView *electricityView;     //电价视图
@property(nonatomic,strong)UIView *priceView;           //价格视图
@property(nonatomic,strong) BMKMapView* mapView;                //百度地图
@property(nonatomic,strong) BMKLocationService* locService;     //定位服务


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
@property(nonatomic,strong)UIImageView *submitInfoImageView;
@property(nonatomic,strong)UIButton *submitButtonConcel;
@property(nonatomic,strong)UIButton *submitButtonAffirm;

@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容
@end

@implementation SearchPartDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super addRightTitle:@"预订说明" selector:@selector(showAppointInfo)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    serachTextField.font = [UIFont systemFontOfSize:13];
    serachTextField.delegate = self;
    serachTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索停车场" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]}];
    serachTextField.textColor = [UIColor whiteColor];
    [searchView addSubview:serachTextField];
    
    //定位服务
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;  //设置定位精确度，默认：kCLLocationAccuracyBest
    _locService.distanceFilter = 100.0f; //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    //启动LocationService
    [_locService startUserLocationService];
    
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.submitButoon setTitle:@"我要停车" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];
    
    //页面布局*******************************
    self.homeScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.submitButoon.frame.size.height-64)];
    self.homeScroll.contentSize=CGSizeMake(ScreenWidth, 100+40+40+300);
    self.homeScroll.showsHorizontalScrollIndicator=NO;
    self.homeScroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.homeScroll];

 
    
    self.infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [self.homeScroll addSubview:self.infoView];
    
    CALayer *infoBottomBorder=[[CALayer alloc]init];
    infoBottomBorder.frame=CGRectMake(0, self.infoView.frame.size.height-0.5, self.infoView.frame.size.width, 0.5);
    infoBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.infoView.layer addSublayer:infoBottomBorder];
    
    
    self.electricityView = [[UIView alloc]initWithFrame:CGRectMake(0, self.infoView.frame.origin.y+self.infoView.frame.size.height, ScreenWidth, 40)];
    [self.homeScroll addSubview:self.electricityView];
    
    CALayer *electricityBottomBorder=[[CALayer alloc]init];
    electricityBottomBorder.frame=CGRectMake(0, self.electricityView.frame.size.height-0.5, self.electricityView.frame.size.width, 0.5);
    electricityBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.electricityView.layer addSublayer:electricityBottomBorder];
    
    self.priceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.electricityView.frame.origin.y+self.electricityView.frame.size.height, ScreenWidth, 40)];
    [self.homeScroll addSubview:self.priceView];
    
    CALayer *priceBottomBorder=[[CALayer alloc]init];
    priceBottomBorder.frame=CGRectMake(0, self.priceView.frame.size.height-0.5, self.priceView.frame.size.width, 0.5);
    priceBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.priceView.layer addSublayer:priceBottomBorder];
    
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, self.priceView.frame.origin.y+self.priceView.frame.size.height, ScreenWidth, 300)];
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    [self.homeScroll addSubview:self.mapView];
   
    
    //信息视图
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 15, 75, 75)];
    self.headImageView.layer.cornerRadius = 37.5;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
    [self.infoView addSubview:self.headImageView];
    
    self.positionFlag = [[UIImageView alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width, 20, 11.5, 15)];
    self.positionFlag.image = [UIImage imageNamed:@"ico_home_cell_location"];
    [self.infoView addSubview:self.positionFlag];

    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.positionFlag.frame.origin.x+self.positionFlag.frame.size.width+5, self.positionFlag.frame.origin.y, 150, 15)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = fontColorBlack;
    self.nameLabel.text = @"未知";
    [self.infoView addSubview:self.nameLabel];
    
    
    self.distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-marginSize-80, self.positionFlag.frame.origin.y, 80, 15)];
    self.distanceLabel.font = [UIFont systemFontOfSize:14];
    self.distanceLabel.textColor = fontColorLightgray;
     self.distanceLabel.text = @"未知";
    [self.infoView addSubview:self.distanceLabel];
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height+5, 200, 15)];
    self.infoLabel.font = [UIFont systemFontOfSize:15];
    self.infoLabel.textColor = fontColorGray;
     self.infoLabel.text = @"未知";
    [self.infoView addSubview:self.infoLabel];
    
    self.remainderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.headImageView.frame.origin.y+self.headImageView.frame.size.height-15, 200, 15)];
    self.remainderLabel.font = [UIFont systemFontOfSize:15];
    self.remainderLabel.textColor = fontColorGray;
     self.remainderLabel.text = @"未知";
    [self.infoView addSubview:self.remainderLabel];
    
    
    //电价视图
    
    self.electricityFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, (self.electricityView.frame.size.height-15)/2, 15, 15)];
    self.electricityFlag.image = [UIImage imageNamed:@"ico_home_cell_flag"];
    [self.electricityView addSubview:self.electricityFlag];

    self.electricityPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.electricityFlag.frame.origin.x+self.electricityFlag.frame.size.width+5, 0, 100, self.electricityView.frame.size.height)];
    self.electricityPriceLabel.font = [UIFont systemFontOfSize:14];
    self.electricityPriceLabel.textColor = backageColorGreen;
    self.electricityPriceLabel.text = @"未知";
    [self.electricityView addSubview:self.electricityPriceLabel];
    
    self.electricityInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.electricityPriceLabel.frame.origin.x+self.electricityPriceLabel.frame.size.width, 0, 150, self.electricityView.frame.size.height)];
    self.electricityInfoLabel.font = [UIFont systemFontOfSize:9];
    self.electricityInfoLabel.textColor = fontColorGray;
    self.electricityInfoLabel.text = @"未知";
    [self.electricityView addSubview:self.electricityInfoLabel];
    
    self.electricitySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-60,5,0,0)];
      [self.electricityView addSubview:self.electricitySwitch];
    [self.electricitySwitch setOn:YES animated:YES];
    
    //价格视图
    
    self.priceDayFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, (self.priceView.frame.size.height-15)/2, 15, 15)];
    self.priceDayFlag.image = [UIImage imageNamed:@"ico_search_day"];
    [self.priceView addSubview:self.priceDayFlag];
    
    self.priceDayPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceDayFlag.frame.origin.x+self.priceDayFlag.frame.size.width+5, 0, 80, self.priceView.frame.size.height)];
    self.priceDayPriceLabel.font = [UIFont systemFontOfSize:14];
    self.priceDayPriceLabel.textColor = backageColorRed;
    self.priceDayPriceLabel.text = @"未知";
    [self.priceView addSubview:self.priceDayPriceLabel];
    
    self.priceDayBusinessHoursLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.5-80, 5, 60, self.priceView.frame.size.height-self.priceDayBusinessHoursLabel.frame.origin.y)];
    self.priceDayBusinessHoursLabel.font = [UIFont systemFontOfSize:9];
    self.priceDayBusinessHoursLabel.textColor = fontColorGray;
    self.priceDayBusinessHoursLabel.text = @"未知";
    [self.priceView addSubview:self.priceDayBusinessHoursLabel];
 
    
    self.priceCutLine = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5, 5, 0.5, self.priceView.frame.size.height-10)];
    self.priceCutLine.backgroundColor = lineColorGray;
    [self.priceView addSubview:self.priceCutLine];
    

    self.priceNightFlag = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize+ScreenWidth*0.5, (self.priceView.frame.size.height-15)/2, 15, 15)];
    self.priceNightFlag.image = [UIImage imageNamed:@"ico_search_night"];
    [self.priceView addSubview:self.priceNightFlag];
    
    self.priceNightPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceNightFlag.frame.origin.x+self.priceDayFlag.frame.size.width+5, 0, 80, self.priceView.frame.size.height)];
    self.priceNightPriceLabel.font = [UIFont systemFontOfSize:14];
    self.priceNightPriceLabel.textColor = backageColorBlue;
    self.priceNightPriceLabel.text = @"未知";
    [self.priceView addSubview:self.priceNightPriceLabel];
    
    self.priceNightBusinessHoursLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-80, 5, 60, self.priceView.frame.size.height-self.priceDayBusinessHoursLabel.frame.origin.y)];
    self.priceNightBusinessHoursLabel.font = [UIFont systemFontOfSize:9];
    self.priceNightBusinessHoursLabel.textColor = fontColorGray;
    self.priceNightBusinessHoursLabel.text = @"未知";
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
    
    
    self.submitInfoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2, (self.submitInfoView.frame.size.height-80)/2-10, 80, 80)];
    self.submitInfoImageView.image = [UIImage imageNamed:@"image_order_part_time"];
     [self.submitInfoView addSubview:self.submitInfoImageView];
    
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

}


//预订说明
-(void)showAppointInfo{
    NSLog(@"预订说明");
   
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
        
        UIView *viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewForImage.frame.size.width, viewForImage.frame.size.height)];
        [imageview setImage:[UIImage imageNamed:@"button_map_loacation_default"]];
        [viewForImage addSubview:imageview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewForImage.frame.size.width, viewForImage.frame.size.height)];
        label.text=@"99";
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
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
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
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
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //测试数据：加入地图定位坐标
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.90868;
    coor.longitude = 116.204;
    annotation.coordinate = coor;
    annotation.title = @"西直门";
    //                     annotation.subtitle = locationPoint[@"siteName"];
    
    [self.mapView addAnnotation:annotation];
    
}

 

@end
