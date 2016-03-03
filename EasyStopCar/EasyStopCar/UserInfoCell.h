//
//  UserInfoCell.h
//  EasyStopCar
//  个人信息cell
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *valueLabel;


- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
