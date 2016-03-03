//
//  EditSelectCell.h
//  EasyStopCar
//  编辑选择cell
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSelectCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *selectFlag;


- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
