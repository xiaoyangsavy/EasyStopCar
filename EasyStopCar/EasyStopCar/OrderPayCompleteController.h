//
//  OrderPayCompleteController.h
//  EasyStopCar
//  订单支付成功
//  Created by savvy on 16/3/2.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"
#import "WXApiManager.h"

@interface OrderPayCompleteController : UITempletViewController<WXApiManagerDelegate>

@property(nonatomic,strong)NSString *payWay;//支付方式

@end
