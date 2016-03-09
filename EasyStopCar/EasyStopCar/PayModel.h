//
//  PayModel.h
//  EasyStopCar
//
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
    NSString *_returnUrl;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *returnUrl;

@end

@interface WXProduct : NSObject{
@private
    int     _total_fee;
    NSString *_outTradNo;
    NSString *_body;
    NSString *_traceId;
    NSString *_returnUrl;
}

@property (nonatomic, assign) int total_fee;
@property (nonatomic, copy) NSString *outTradNo;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, copy) NSString *returnUrl;

@end

@interface PayModel : NSObject

@end
