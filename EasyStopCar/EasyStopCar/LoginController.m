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
@property(nonatomic, strong) UILabel *infoLabel;

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮

@property(nonatomic,strong) NSTimer *myNSTimer;     //倒计时
@property(nonatomic,assign) NSInteger numberIndex;


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super initNavBarItems:@"手机快捷登陆"];
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc]init]];//隐藏左侧返回按钮
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.userView = [[InputItemModel alloc] initWithFrame:CGRectMake(marginSize,20, ScreenWidth-marginSize*2, 45) iconImage:@"ico_login_user" text:@"" placeHolderText:@"手机号"];
    self.userView.textField.keyboardType = UIKeyboardTypePhonePad;
    self.userView.delegate = self;
    [self.view addSubview:self.userView];
    
    self.passwordView = [[InputItemModel alloc]initWithFrame:CGRectMake(marginSize, self.userView.frame.origin.y+self.userView.frame.size.height+10, ScreenWidth-marginSize*2, 45) iconImage:@"ico_login_password" text:@"" placeHolderText:@"登陆密码"];
     self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
   
    
 
    
    self.gainCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.passwordView.frame.origin.x+self.passwordView.frame.size.width-90, self.passwordView.frame.origin.y, 90, self.passwordView.frame.size.height)];
    [self.gainCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.gainCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.gainCodeButton.backgroundColor = backageColorYellow;
    [self.gainCodeButton addTarget:self action:@selector(gainCode) forControlEvents:UIControlEventTouchUpInside];
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
    self.submitButoon.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.submitButoon.layer.cornerRadius = 5;
    self.submitButoon.layer.masksToBounds = YES;
    [self.view addSubview:self.submitButoon];
    
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, ScreenHeight-80-64, ScreenWidth-30, 60)];
    self.infoLabel.text = @"温馨提示：未注册易停车账号的手机号，登录时将自动注册易停车，且已代表您已同意《用户协议》和《停车协议》";
    self.infoLabel.font = [UIFont systemFontOfSize:14];
    self.infoLabel.textColor = fontColorGray;
    self.infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.infoLabel.numberOfLines = 0;//上面两行设置多行显示
    [self.view addSubview:self.infoLabel];
    
    
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


//获取验证码
-(void)gainCode{
    
    NSString *phone = self.userView.textField.text;
//    NSString *password = self.passwordView.textField.text;
    
//     NSLog(@"参数为%@和%@！！！！",phone,password);
    
    if (phone&&![phone isEqualToString:@""]) {//已输入用户名和密码
        
        //调用接口
        [SVProgressHUD show];
        [[Connetion shared]sendCode:phone finish:^(NSDictionary *dict, NSError *error)
         {
//             [SVProgressHUD dismiss];
             if (!error)
             {
                 NSLog(@"接口返回数据为%@",dict);
                 
                 NSInteger code = [dict[@"code"] integerValue];
                 if (code == 200) {//返回成功
                     
                     
                     [SVProgressHUD showSuccessWithStatus:@"验证码已发送" maskType:SVProgressHUDMaskTypeGradient];
                     
                     //重新发送按钮倒计时
                     self.numberIndex=60;//Countdown
                     if (self.myNSTimer) {
                         [self.myNSTimer invalidate];
                         self.myNSTimer = nil;
                     }
                     
                     self.myNSTimer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                        target:self
                                                                      selector:@selector(timerFireMethod:)
                                                                      userInfo:nil
                                                                       repeats:YES];
                     
                     self.gainCodeButton.enabled=NO;
                 }else{
                 [SVProgressHUD showErrorWithStatus:dict[@"msg"] maskType:SVProgressHUDMaskTypeGradient];
                 }
                 
             }else{
                [SVProgressHUD showErrorWithStatus:@"服务器错误" maskType:SVProgressHUDMaskTypeGradient];
                 NSLog(@"接口调用错误%@!!!!!!",error);
             }
             
         }];
        
    }else{
       [SVProgressHUD showErrorWithStatus:@"手机号不能为空" maskType:SVProgressHUDMaskTypeGradient];
    
    }
    
    
   
    
    
    
    
    

}

- (void)timerFireMethod:(NSTimer *)timer {
        if(self.numberIndex==0){
            self.gainCodeButton.enabled=YES;
            [self.gainCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        }else{
            self.numberIndex--;
             [self.gainCodeButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.numberIndex] forState:UIControlStateNormal];
           
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交按钮点击事件
-(void)submitClick{
    
    NSString *phone = self.userView.textField.text;
    NSString *password = self.passwordView.textField.text;
    
    NSLog(@"参数为%@和%@！！！！",phone,password);
    
    if (phone&&password&&![phone isEqualToString:@""]&&![password isEqualToString:@""]) {//已输入用户
    
        
        //调用接口
         [SVProgressHUD show];
        [[Connetion shared]loginAndRegister:phone code:(NSString *)password finish:^(NSDictionary *dict, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"接口返回数据为%@",dict);
                 
                 NSInteger code = [dict[@"code"] integerValue];
                 if (code == 200||code == 1000) {//返回成功
                      [SVProgressHUD dismiss];
                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                     [userDefaults setObject:@"1" forKey:@"isLogin"];
                     [userDefaults synchronize];
                     
                     ViewController *myController = [[ViewController alloc]init];
                     [self.navigationController pushViewController:myController animated:YES];
                     
                 }else{
                     [SVProgressHUD showErrorWithStatus:@"失败，请重试" maskType:SVProgressHUDMaskTypeGradient];
                 }
                 
             }else{
                 [SVProgressHUD showErrorWithStatus:@"服务器错误" maskType:SVProgressHUDMaskTypeGradient];
                 NSLog(@"接口调用错误%@!!!!!!",error);
             }
             
         }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"手机号和密码不能为空" maskType:SVProgressHUDMaskTypeGradient];
        
    }
    
   
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
