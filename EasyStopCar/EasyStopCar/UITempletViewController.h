//
//  UITempletViewController.h
//  EasyStopCar
//  模板父类
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "Connetion.h"

@interface UITempletViewController : UIViewController<UIActionSheetDelegate>{

    UIButton     *leftButton;//左导航按钮
    UIButton     *rightButton;//右导航按钮

}


//@property (nonatomic,retain) UIButton *leftButton;
//@property (nonatomic,retain) UIButton *rightButton;

@property (nonatomic,retain) UIActivityIndicatorView *loadIndicator;//进度指示器
@property(nonatomic,strong)NSMutableArray *myArray;//测试列表数据

@property(nonatomic,strong)UIView *backageTopView;
@property(nonatomic,strong)UIView *backageView;

//NavBar设置
- (void)initNavBarItems:(NSString *)titlename;

//NavBar左右按钮
- (void)addLeftButton:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked;

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView;

- (void)addRightTitle:(NSString *)title   selector:(SEL)pushPastView;

//显示弹出框背景层
-(void)showAlertBackage:(UIView *)myAlertView;

//隐藏弹出框背景层
-(void)hideAlertBackage;

-(void)toReturn;//返回上一页

- (void)callPhone;//拨打电话

-(void) initTestArray;//测试数据

@end
