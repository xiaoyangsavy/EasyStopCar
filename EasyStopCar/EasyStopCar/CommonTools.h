//
//  CommonTools.h
//  EasyStopCar
//  工具方法类
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject


//UIView转UIImage
-(UIImage *)getImageFromView:(UIView *)view;

-(NSInteger)getDataAndTime:(int)type;
@end
