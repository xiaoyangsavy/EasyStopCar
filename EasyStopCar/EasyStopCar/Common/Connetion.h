//
//  Connetion.h
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/5.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface Connetion : NSObject

//  DEBUG 模式
/// 是否显示url 日志 , 默认打印
@property(nonatomic, assign) BOOL noLog;

//  是否显示网络访问的提示，默认不显示（  YES 显示， NO 不现实）
@property(nonatomic, assign) BOOL isShowHUD;


+ (Connetion *)shared;







- (void)customReservationQueue:(NSString *)tokenId finish:(void (^)(NSDictionary *resultData,  NSError *error))finishBlock;

 

@end
