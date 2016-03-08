//
//  LoginController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "LoginController.h"

#import "ViewController.h"

@interface LoginController ()
{
    UITextField *currentTextField;
}


@property(nonatomic, strong) InputItemModel *userView;
@property(nonatomic, strong) InputItemModel *passwordView;
@property(nonatomic, strong) UIButton *gainCodeButton;

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super initNavBarItems:@"手机快捷登陆"];
     self.navigationItem.leftBarButtonItem=nil;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.userView = [[InputItemModel alloc] initWithFrame:CGRectMake(marginSize,20, ScreenWidth-marginSize*2, 45) iconImage:@"ico_login_user" text:@"" placeHolderText:@"手机号"];
    self.userView.delegate = self;
    [self.view addSubview:self.userView];
    
    self.passwordView = [[InputItemModel alloc]initWithFrame:CGRectMake(marginSize, self.userView.frame.origin.y+self.userView.frame.size.height+10, ScreenWidth-marginSize*2, 45) iconImage:@"ico_login_password" text:@"" placeHolderText:@"登陆密码"];
     self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
   
    
 
    
    self.gainCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.passwordView.frame.origin.x+self.passwordView.frame.size.width-90, self.passwordView.frame.origin.y, 90, self.passwordView.frame.size.height)];
    [self.gainCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.gainCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.gainCodeButton.backgroundColor = backageColorYellow;
    [self.view addSubview:self.gainCodeButton];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.gainCodeButton.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.gainCodeButton.bounds;
    maskLayer.path = maskPath.CGPath;
    self.gainCodeButton.layer.mask = maskLayer;
    
    
    
    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(marginSize, 200, ScreenWidth-marginSize*2, 50)];
    [self.submitButoon setTitle:@"验证并登陆" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorYellow;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:14];
    self.submitButoon.layer.cornerRadius = 5;
    self.submitButoon.layer.masksToBounds = YES;
    [self.view addSubview:self.submitButoon];
    
    
    
//    [[Connetion shared]customReservationQueue:nil   finish:^(NSDictionary *resultData, NSError *error)
//     {
//         
//         if (!error)
//         {
//             NSLog(@"接口返回数据为%@",resultData);
//         }else{
//         NSLog(@"接口返回错误为%@",error);
//         }
//         
//     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交按钮点击事件
-(void)submitClick{
    ViewController *myController = [[ViewController alloc]init];
            [self.navigationController pushViewController:myController animated:YES];
}


#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [currentTextField resignFirstResponder];
    return YES;
}


@end
