//
//  PayDetailCell.h
//  EasyStopCar
//  支付详细cell
//  Created by savvy on 16/3/4.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayDetailCell : UITableViewCell

@property(nonatomic,strong)UIImageView *payDetailIco;
@property(nonatomic,strong)UILabel *payDetailTitle;
@property(nonatomic,strong)UILabel *payDetailTime;
@property(nonatomic,strong)UILabel *payDetailValue;
@property(nonatomic,strong)UILabel *payDetailContent;
 

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
