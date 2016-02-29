//
//  SearchPartMapController.h
//  EasyStopCar
//  搜索停车位，百度地图
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件


#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

@interface SearchPartMapController : UITempletViewController<BMKMapViewDelegate>

@end
