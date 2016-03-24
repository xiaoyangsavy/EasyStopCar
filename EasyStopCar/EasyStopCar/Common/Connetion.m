//
//  Connetion.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/5.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "Connetion.h"



@implementation Connetion

static Connetion* connetion;

+ (Connetion *)shared {
    if (!connetion) {
        connetion = [[Connetion alloc] init];
        
    }
    connetion.noLog = NO;
    connetion.isShowHUD = NO;
    return connetion;
}




#pragma mark - 用户相关的相关网络API

- (NSString*)dictToString:(NSDictionary*)dict {
    NSMutableString* postString = [NSMutableString string];
    
    int i = 0;
    for (NSString* key in dict) {
        [postString appendString:key];
        [postString appendString:@"="];
        [postString appendString:[dict objectForKey:key]];
        
        if (i != dict.count - 1) {
            [postString appendString:@"&"];
        }
        i++;
    }
    return [NSString stringWithString:postString];
}

- (void)GET:(NSString*)URLString finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    if ( ! self.noLog) {
        NSLog(@"%@", URLString);
    }
    
    
    
    connetion.isShowHUD = NO;
    
    if (self.isShowHUD) {
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    }
    
    
    [manager GET:URLString parameters:nil
         success:^(AFHTTPRequestOperation* operation, id responseObject) {
             [SVProgressHUD dismiss];
             finishBlock(responseObject, nil);
             
             ;}
         failure:^(AFHTTPRequestOperation* operation, NSError* error) {
             if (self.isShowHUD) {
                 [SVProgressHUD  showErrorWithStatus:@"发生错误" ];
             }
             
             finishBlock(nil, error);
         }];
}

- (void)POST:(NSString*)URLString parameters:(id)parameters finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    
    if ( ! self.noLog) {
        NSLog(@"%@", URLString);
    }
    if (self.isShowHUD) {
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    }
    
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation* operation, id responseObject) {
        [SVProgressHUD dismiss];
        finishBlock(responseObject, nil);
    }
          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
              
              if (self.isShowHUD) {
                  [SVProgressHUD  showErrorWithStatus:@"发生错误" ];
              }
              
              finishBlock(nil, error);
          }];
}


//提交订单
- (void)submitNewOrder:(NSString *)userName phone:(NSString *)phone payWay:(NSString *)payWay finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/mobile/order_new/user_member_pay?real_name=%@&rephone=%@&payment_cod=%@", prefix_url,userName,phone,payWay];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
    
}


//获取微信支付预处理文件
- (void)getOrderPreWithWeChat:(NSMutableDictionary *)dict  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/weixinsdk/getparid.php", prefix_url];
    
    [self POST:urlString parameters:dict finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//发送验证码
- (void)sendCode:(NSString *)phone  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/user/checkphone&phone=%@", prefix_url,phone];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//登陆并注册
- (void)loginAndRegister:(NSString *)phone code:(NSString *)code finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/user/login&telephone=%@&vecode=%@", prefix_url,phone,code];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//获取用户详细信息
- (void)getUserDetailInfo:(NSString *)myString  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/user/userinfo", prefix_url];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//首页订单
- (void)getOrderListWithMain:(NSString *)myString  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/order/orderforindex", prefix_url];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//订单详情
- (void)getOrderDetailByOrderID:(NSString *)orderID  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/order/getorderinfo&id=%@", prefix_url,orderID];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}


//车厂列表
- (void)getParkList:(float)longitude latitude:(float)latitude electricity:(NSString *)electricity distance:(NSString *)distance finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/bays/getbaysbyxl&xl=%f&yl=%f&type=%@&dpk=%@", prefix_url,latitude,latitude,electricity,distance];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

//车厂详情
- (void)getParkList:(NSString *)parkID  finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock{
    
    NSString* urlString  = [NSString stringWithFormat:@"%@/index.php?route=mobile/bays/getcarmainfo&id=%@", prefix_url,parkID];
    
    NSLog(@"调用网络%@!!!!!",urlString);
    
    [self GET:urlString finish:^(NSDictionary *resultData, NSError *error) {
        
        finishBlock(resultData,error);
    }];
}

@end
