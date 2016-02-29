//
//  SearchPartMapController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartMapController.h"

@interface SearchPartMapController ()

@property(nonatomic,strong) BMKMapView* mapView;

@property(nonatomic,strong) BMKLocationService* locService;

@end

@implementation SearchPartMapController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
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


#pragma mark 百度地图delegate

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view; {
    NSLog(@"%@", view.annotation.title );
//    NSLog(@"%@", @"siteName");
    
    
//    NSDictionary *currentPoint;
//    NSString *title = view.annotation.title;
//    for (NSDictionary *dict in points) {
//        
//        if ([dict[@"siteName"] isEqualToString:title]) {
//            
//            currentPoint = dict;
//        }
//    }
//    
//    if (  currentPoint ) {
//        SiteDetailViewController *mySite=[[SiteDetailViewController alloc] init];
//        mySite.siteId = [NSString stringWithFormat:@"%d",  [currentPoint[@"siteId"] intValue]];
//        [self.navigationController pushViewController:mySite animated:YES];
//    }
    
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

@end
