//
//  UITempletViewController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UITempletViewController.h"

@interface UITempletViewController ()

@property(nonatomic,strong)UIView *myAlertView;

@end

@implementation UITempletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = backageColorLightgray;
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self.navigationController.navigationBar setBarTintColor:backageColorYellow];
    [self addLeftButton:@"ico_navigation_back" lightedImage:@"ico_navigation_back" selector:@selector(toReturn)];
//    [self addRightButton:@"ico_navigation_phone" lightedImage:@"ico_navigation_phone" selector:@selector(callPhone)];
    
    //进度指示器
    self.loadIndicator =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadIndicator.center = CGPointMake(ScreenWidth*0.5, ScreenHeight*0.5-30);//只能设置中心，不能设置大小
    //    [self.loadIndicator setFrame = CGRectMack(100, 100, 100, 100)];//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [self.view addSubview:self.loadIndicator];
//    self.loadIndicator.color = backageColorBlue; // 改变圈圈的颜色为红色； iOS5引入
    
    
   
    //提交弹出层
    float alphaValue = 0.8;
    self.backageTopView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    self.backageTopView.backgroundColor = [UIColor blackColor];
    self.backageTopView.alpha = alphaValue;
    self.backageTopView.hidden = YES;
    UIWindow *myWindow  = [[UIApplication sharedApplication].delegate window];
    [myWindow addSubview:self.backageTopView];
    
    self.backageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.backageView.backgroundColor = [UIColor blackColor];
    self.backageView.alpha = alphaValue;
    self.backageView.hidden = YES;
    [self.view addSubview:self.backageView];
    
    [self initInfoArray];//测试数据

    
}


- (void)initNavBarItems:(NSString *)titlename{
    
    //设置标题
    UILabel *aTitleLabel = nil;
    
    if (kSystemIsIOS7) {
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    }
    else{
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)];
    }
    aTitleLabel.text = titlename;
    aTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    aTitleLabel.textAlignment = NSTextAlignmentCenter;
    aTitleLabel.backgroundColor = [UIColor clearColor];
    aTitleLabel.adjustsFontSizeToFitWidth = YES;
    aTitleLabel.textColor = [UIColor whiteColor];
    aTitleLabel.userInteractionEnabled = YES;
    [self.navigationItem setTitleView:aTitleLabel];
}


- (void)addLeftButton:(NSString *)image lightedImage:(NSString *) aLightedImage selector:(SEL)buttonClicked{
    leftButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTintColor:[UIColor whiteColor]];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [leftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:buttonClicked forControlEvents:UIControlEventTouchUpInside];
    
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 25);
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    leftButton.tag = NAME_MAX;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)addRightButton:(NSString *)image  lightedImage:(NSString *) aLightedImage selector:(SEL)pushPastView{
    rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [rightButton setTintColor:[UIColor whiteColor]];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:aLightedImage] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:pushPastView forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0.0f, 0.0f, 60,44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, -25);
    rightButton.tag = 10009;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}

- (void)addRightTitle:(NSString *)title   selector:(SEL)pushPastView{
    rightButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [rightButton setTintColor:[UIColor whiteColor]];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton addTarget:self action:pushPastView forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(20.0f, 0.0f, 60,44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    rightButton.tag = 10009;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


//显示弹出框背景层
-(void)showAlertBackage:(UIView *)myAlertView{
    self.myAlertView = myAlertView;
    self.myAlertView.hidden = NO;
    self.backageView.hidden = NO;
    self.backageTopView.hidden = NO;
    [self.view bringSubviewToFront:self.backageView];
    [self.view bringSubviewToFront:self.myAlertView];
}

//隐藏弹出框背景层
-(void)hideAlertBackage{
    self.backageView.hidden = YES;
    self.backageTopView.hidden = YES;
     self.myAlertView.hidden = YES;
    [self.view sendSubviewToBack:self.myAlertView];
}


//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

//返回前几页
-(void)toReturn:(int)count{
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    for(int i=0;i<count;i++){
    [navigationArray removeObjectAtIndex: navigationArray.count-1];// You can pass your index here
    }
    self.navigationController.viewControllers = navigationArray;
}

//拨打客服电话
- (void)callPhone
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"拨打客服电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-010-6000", nil];
    [sheet showInView:self.view];
    
    
}


//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"未知" forKey:@"testText"];
    [myDictionary setValue:@"0" forKey:@"testFlag"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"未知" forKey:@"testText"];
    [myDictionary setValue:@"1" forKey:@"testFlag"];
    [self.myArray addObject:myDictionary];
    
    
}

#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"4000106000"];
        NSURL *url = [[NSURL alloc] initWithString:telUrl];
        
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
