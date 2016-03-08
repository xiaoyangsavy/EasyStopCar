//
//  SearchPartController.h
//  EasyStopCar
//  搜索停车位，列表
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"


@interface SearchPartController : UITempletViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, assign)NSInteger styleType;     //显示类型
@property (nonatomic, strong)NSString *searchedLocation;
@property (nonatomic, strong)NSString *searchedData;
@property (nonatomic, assign)BOOL isElectricity;//是否有电
@end
