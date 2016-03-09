//
//  MemberAccountCell.h
//  EasyStopCar
//
//  Created by savvy on 16/3/8.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberAccountCell : UITableViewCell

@property(nonatomic, strong) UIImageView *memberIco;//图标
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UILabel *numberLabel;

- (void)setCellInfo:(NSDictionary *)dic;

@end
