//
//  ResultInfoController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/17.
//  Copyright (c) 2016年 Savvy. All rights reserved.
//

#import "ResultInfoController.h"

@interface ResultInfoController ()

@property(nonatomic,strong)UIImageView *stateImageView;//状态图片
@property(nonatomic,strong)UILabel *stateLabel;//状态

@property(nonatomic,strong)UILabel *infoLabel;//信息
@property(nonatomic,strong)UILabel *payMoneyLabel;//冲入金额
@property(nonatomic,strong)UILabel *allMoneyLabel;//所有金额

@property(nonatomic,strong)UILabel *remarksLabel;//备注


@end

@implementation ResultInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-60)/2, 100, 60, 60)];
    self.stateImageView.image = [UIImage imageNamed:@"image_order_complete"];
    self.stateImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.stateImageView];
    
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.stateImageView.frame.origin.y+self.stateImageView.frame.size.height+10, ScreenWidth, 15)];
    self.stateLabel.font = [UIFont systemFontOfSize:18];
    self.stateLabel.textColor = fontColorBlack;
    self.stateLabel.text = @"取消成功";
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.stateLabel];
    
    
    //信息区域
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.stateLabel.frame.origin.y+self.stateLabel.frame.size.height+10, ScreenWidth, 40)];
    self.infoLabel.font = [UIFont systemFontOfSize:14];
    self.infoLabel.textColor = fontColorBlack;
    self.infoLabel.text = @"您已成功取消本次停车预约\n易停车感谢您的使用";
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.infoLabel.numberOfLines = 0;//上面两行设置多行显示
    [self.view addSubview:self.infoLabel];
    
    self.payMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.stateLabel.frame.origin.y+self.stateLabel.frame.size.height+10, ScreenWidth, 30)];
    self.payMoneyLabel.font = [UIFont systemFontOfSize:30];
    self.payMoneyLabel.textColor = fontColorBlack;
    self.payMoneyLabel.text = @"￥0元";
    self.payMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.payMoneyLabel.hidden = YES;
    [self.view addSubview:self.payMoneyLabel];
    
    self.allMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.payMoneyLabel.frame.origin.y+self.payMoneyLabel.frame.size.height+10, ScreenWidth, 15)];
    self.allMoneyLabel.font = [UIFont systemFontOfSize:9];
    self.allMoneyLabel.textColor = fontColorGray;
    self.allMoneyLabel.text = @"现余额0元";
    self.allMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.allMoneyLabel.hidden = YES;
    [self.view addSubview:self.allMoneyLabel];
    
    
 
    self.remarksLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-40-64-20, ScreenWidth, 40)];
    self.remarksLabel.font = [UIFont systemFontOfSize:14];
    self.remarksLabel.textColor = fontColorGray;
    self.remarksLabel.text = @"如有问题或建议请拨打电话\n400-8888-9999";
    self.remarksLabel.textAlignment = NSTextAlignmentCenter;
    self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarksLabel.numberOfLines = 0;//上面两行设置多行显示
    [self.view addSubview:self.remarksLabel];
    
    
    [self initViewByType];//初始化页面数据
}


-(void)initViewByType{

    NSString *titleString = @"";
    NSString *stateString = @"";
    NSString *infoString = @"";
      NSString *payString = @"";
     NSString *allString = @"";
     NSString *remarksString = @"";
    if(self.type == 1){
        titleString = @"取消订单";
        stateString = @"取消成功";
        infoString = @"您已成功取消本次停车预约\n易停车感谢您的使用";
        remarksString = @"如有问题或建议请拨打电话\n400-8888-9999";
        self.payMoneyLabel.hidden = YES;
         self.allMoneyLabel.hidden = YES;
        
    }else if(self.type == 2){
        titleString = @"充值";
         stateString = @"充值成功";
        payString =  @"￥0元";
        allString =  @"现余额0元";
        remarksString = @"\n充值时间:2016-01-01 00:00:00";
        self.infoLabel.hidden = YES;
    }
    [super initNavBarItems:titleString];
    
    
     self.stateLabel.text = stateString;
     self.infoLabel.text = infoString;
     self.payMoneyLabel.text = payString;
     self.allMoneyLabel.text = allString;
     self.remarksLabel.text = remarksString;
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
