//
//  SearchPartCell.h
//  EasyStopCar
//  搜索停车位,cell
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPartCell : UITableViewCell


@property(nonatomic, strong) UIView  *cutLine;//分割线
@property(nonatomic, strong) UIImageView *searchImageView;
@property(nonatomic, strong) UILabel *searchName;
@property(nonatomic, strong) UIImageView *searchFlag;
@property(nonatomic, strong) UILabel *searchPartCount;
@property(nonatomic, strong) UILabel *searchDistance;
@property(nonatomic, strong) UILabel *searchPrice;
@property(nonatomic, strong) UILabel *searchBusinessHours;



- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
