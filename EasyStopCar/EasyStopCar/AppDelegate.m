//
//  AppDelegate.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApiManager.h"
#import "ViewController.h"
#import "LoginController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderUnit.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapNaviKit/MAMapKit.h>

@interface AppDelegate ()

@end

BMKMapManager* _mapManager;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"VZZMIeQV14kl4BXQPNZAbQOk" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    //注册微信
    //向微信注册
    [WXApi registerApp:@"wx4eef83935fefb026" withDescription:@"demo 2.0"];
    
    [MAMapServices sharedServices].apiKey = @"3f9ef377038d3a99796f02aa58371350";//高德地图
    
    UIViewController *myViewController = nil;
    UINavigationController *myNavigationController =nil;

//    myViewController = [[ViewController alloc] init];
    myViewController = [[LoginController alloc] init];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    self.window.rootViewController = myNavigationController;
    [self.window makeKeyAndVisible];

    
    return YES;
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             int rStauts = [resultDic[@"resultStatus"] intValue];
             NSString *s = resultDic[@"memo"];
             switch (rStauts) {
                 case 9000: {
                     s = @"支付成功";
                     
                     [OrderUnit depositPaySucessCallBack:resultDic];
//                     [[NSNotificationCenter defaultCenter]
//                      postNotificationName:@"payAlipaySuccessBack"
//                      object:nil];
                     
                     break;
                 }
                 case 8000: {
                     break;
                 }
                 case 4000: {
                     break;
                 }
                 case 6001: {
                     NSLog(@"取消支付！！！！！！");
                     [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"resultByAlipay"
                      object:nil];
                     break;
                 }
                 case 6002: {
                     break;
                 }
                 default:
                     break;
             }
         }];
        return YES;
    }
    else
   
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     printf("按理说是触发home按下\n");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     printf("按理说是重新进来后响应\n");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
