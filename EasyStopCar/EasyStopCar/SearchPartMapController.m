//
//  SearchPartMapController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartMapController.h"
#import "CommonTools.h"
#import "SearchPartDetailController.h"

@interface SearchPartMapController ()
{
    UITextField *currentTextField;
}
@property(nonatomic,strong) BMKMapView* mapView;                //百度地图
@property(nonatomic,strong) BMKLocationService* locService;     //定位服务

@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容

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
    
    //百度地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
//    _mapView.zoomLevel = 14;
     self.view = _mapView;

   
    
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
        label.text=annotation.subtitle;
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

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    SearchPartDetailController *searchPartDetailController = [[SearchPartDetailController alloc]init];
    [self.navigationController pushViewController:searchPartDetailController animated:YES];

}
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
//    NSLog(@"siteName:%@", view.annotation.title );
//
//    
//    SearchPartDetailController *searchPartDetailController = [[SearchPartDetailController alloc]init];
//    [self.navigationController pushViewController:searchPartDetailController animated:YES];
//    
//}



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
    
     [self initTestData];//初始化测试数据
}

@end
