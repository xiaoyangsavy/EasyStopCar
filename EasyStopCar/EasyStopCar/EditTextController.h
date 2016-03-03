//
//  EditTextController.h
//  EasyStopCar
//  文本编辑页面
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"

@interface EditTextController : UITempletViewController<UITextFieldDelegate>

@property(nonatomic, strong) NSString *editString;//待编辑文本

@end
