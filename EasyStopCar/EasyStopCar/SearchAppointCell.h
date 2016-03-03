//
//  SearchAppointCell.h
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAppointCell : UITableViewCell


@property(nonatomic, strong) UIView  *cutLine;//分割线
@property(nonatomic, strong) UIImageView *searchImageView;
@property(nonatomic, strong) UILabel *searchName;
@property(nonatomic, strong) UIImageView *searchFlag;


- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据


@end
