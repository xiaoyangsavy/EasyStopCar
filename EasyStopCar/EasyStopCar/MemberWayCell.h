//
//  MemberWayCell.h
//  EasyStopCar
//  会员支付方式
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberWayCell : UITableViewCell

@property(nonatomic, strong) UIImageView *wayIco;
@property(nonatomic, strong) UILabel *wayTitle;
@property(nonatomic, strong) UIImageView *wayState;
@property(nonatomic, strong) UIView *lineView;

- (void)setCellInfo:(NSDictionary *)dic;
- (void)updateShow; //更改显示状态

@end
