//
//  CouponCell.h
//  EasyStopCar
//  优惠券
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell

@property(nonatomic, strong) UIView *backageView;//背景

@property(nonatomic, strong) UILabel *couponPriceLabel;
@property(nonatomic, strong) UILabel *couponNameLabel;
@property(nonatomic, strong) UILabel *couponContentLabel;
@property(nonatomic, strong) UILabel *couponDateLabel;
@property(nonatomic, strong) UIImageView *couponFlagImageView;//标记
@property(nonatomic, strong) UIImageView *lineView;

 
- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
