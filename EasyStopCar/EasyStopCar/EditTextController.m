//
//  EditTextController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "EditTextController.h"

@interface EditTextController ()
{
    UITextField *currentTextField;
}

@property(nonatomic, strong) UIView *editView;
@property(nonatomic, strong) UITextField *editTextField;//文本编辑

@end

@implementation EditTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"编辑"];
    
    UIButton *myButton = [[UIButton  alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 60,30)];
    [myButton setTintColor:[UIColor whiteColor]];
    [myButton setTitle:@"保存" forState:UIControlStateNormal];
    myButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [myButton addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    myButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    //设置圆角边框
    myButton.layer.cornerRadius = 5;
    myButton.layer.masksToBounds = YES;
    //设置边框及边框颜色
    myButton.layer.borderWidth = 0.5;
    myButton.layer.borderColor =[ [UIColor whiteColor] CGColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    
    
    
    self.editView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth, 50)];
    self.editView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editView];
    
    CALayer *editViewTopBorder=[[CALayer alloc]init];
    editViewTopBorder.frame=CGRectMake(0, 0, self.editView.frame.size.width, 0.5);
    editViewTopBorder.backgroundColor=lineColorGray.CGColor;
    [self.editView.layer addSublayer:editViewTopBorder ];
    
    CALayer *editViewBottomBorder=[[CALayer alloc]init];
    editViewBottomBorder.frame=CGRectMake(0, self.editView.frame.size.height-0.5, self.editView.frame.size.width, 0.5);
    editViewBottomBorder.backgroundColor=lineColorGray.CGColor;
    [self.editView.layer addSublayer:editViewBottomBorder ];
    
    self.editTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth, self.editView.frame.size.height)];
    self.editTextField.delegate = self;
    self.editTextField.text = self.editString;
    [self.editView addSubview:self.editTextField];
    
    
}

//保存信息
-(void)saveInfo{
    [self toReturn];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
