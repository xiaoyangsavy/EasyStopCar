//
//  HomeCell.h
//  EasyStopCar
//  首页列表cell
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCellDelegate<NSObject>

- (void)getDictionary:(NSDictionary *)myDictionary;//取得修改之后的商品数据

@end

@interface HomeCell : UITableViewCell


@property(nonatomic, assign) id<HomeCellDelegate> delegate;

@property(nonatomic, strong) UIView *myContentView;
@property(nonatomic, strong) UILabel *homeDataLabel;
@property(nonatomic, strong) UILabel *homeTitle;
@property(nonatomic, strong) UIView *homeLine;
@property(nonatomic, strong) UIImageView *homeLocationIco;
@property(nonatomic, strong) UILabel *homeLocationTitle;
@property(nonatomic, strong) UILabel *homeLocationContent;
@property(nonatomic, strong) UIImageView *homeLocationFlag;
@property(nonatomic, strong) UIButton *homeButton;

@property(nonatomic, strong) NSMutableDictionary *myDictionary;  //商品数据

- (void)setCellInfo:(NSDictionary *)dic;//设置接口数据

@end
