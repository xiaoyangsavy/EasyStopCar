//
//  OrderDetailController.h
//  EasyStopCar
//  订单详情
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入工具类

@interface OrderDetailController : UITempletViewController

@property(nonatomic,assign)int orderType;//0:待停车；1：已停车；3：预约

@end
