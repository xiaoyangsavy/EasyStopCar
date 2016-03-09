//
//  MemberPayViewController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "MemberPayViewController.h"
#import "CouponCell.h"
#import "MemberWayCell.h"
#import "SVProgressHUD.h"

#import "OrderUnit.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


#import "SVProgressHUD.h"
#import "PayModel.h"
#import "WXApi.h"
#import "NSString+MD5Addition.h"


#define BASE_URL @"https://api.weixin.qq.com"

@interface MemberPayViewController ()
{
    UITextField *currentTextField;
}

@property(nonatomic, strong) UIScrollView *pageScroll;//页面滚动视图



@property(nonatomic, strong) UILabel *memberInfoLable;//会员卡信息
@property(nonatomic, strong) UIView *memberInfoView;
@property(nonatomic, strong) UIView *nameView;//姓名
@property(nonatomic, strong) UIView *phoneView;//手机号
@property(nonatomic, strong) UIView *remainderView;//余额
@property(nonatomic, strong) UIView *moneyView;//充值金额

@property(nonatomic, strong) UIView *lineView01;//分割线
@property(nonatomic, strong) UIView *lineView02;
@property(nonatomic, strong) UIView *lineView03;


@property(nonatomic, strong) UILabel *payWayLable;//支付方式
@property(nonatomic, strong) UITableView *payWayTableView;//支付方式列表
@property(nonatomic, strong) UIView *agreeView;//同意

@property(nonatomic, strong) UIButton *payButton;//支付

@property(nonatomic, strong) UILabel *nameLabe;
@property(nonatomic, strong) UITextField *nameText;         //姓名
@property(nonatomic, strong) UILabel *phoneLabe;
@property(nonatomic, strong) UITextField *phoneText;        //手机号
@property(nonatomic, strong) UILabel *remainderLabe;
@property(nonatomic, strong) UILabel *remainderContentLabel;
@property(nonatomic, strong) UILabel *moneyLabe;
@property(nonatomic, strong) UILabel *moneyText;        //充值金额

@property(nonatomic, strong) UIImageView *agreeImageView;
@property(nonatomic, strong) UIButton *agreeButton;
@property(nonatomic, strong) UILabel *agreeLabel;
@property(nonatomic, strong) UIButton *clauseButton;

@property(nonatomic, strong) NSMutableArray *payWayArray;//支付方式数据

@property (nonatomic, retain) WXProduct *WXPayProduct;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, strong) NSString *nonceStr;
@property (nonatomic, strong) NSString *traceId;

@property (nonatomic, assign) float rechargeMoney;//充值金额
//@property(nonatomic, assign) NSInteger  payWayID;//所选支付方式
@end

@implementation MemberPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"会员卡"];
    
    self.view.backgroundColor = backageColorLightgray;
    
    
    
    self.payButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    //    self.payButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.payButton.backgroundColor = backageColorRed;
    [self.payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.payButton addTarget:self action:@selector(startPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
    
    
    //页面滚动视图
    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-self.payButton.frame.size.height-64)];
    //    self.pageScroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageScroll.contentSize=CGSizeMake(ScreenWidth, 500);
    self.pageScroll.showsHorizontalScrollIndicator=NO;
    self.pageScroll.showsVerticalScrollIndicator=NO;
    self.pageScroll.backgroundColor = backageColorLightgray;
    [self.view addSubview:self.pageScroll];
    
    self.memberInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 15)];
    //    self.memberInfoLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.memberInfoLable.text = @"会员卡信息";
    self.memberInfoLable.font = [UIFont systemFontOfSize:12];
    self.memberInfoLable.textColor = fontColorGray;
    [self.pageScroll addSubview:self.memberInfoLable];
    
    
    self.memberInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.memberInfoLable.frame.origin.y+self.memberInfoLable.frame.size.height+10, ScreenWidth, 160)];
    //    self.memberInfoLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.memberInfoView.backgroundColor = [UIColor whiteColor];
    [self.pageScroll addSubview:self.memberInfoView];
    
    
    self.nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    //    self.nameView.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameView.backgroundColor = [UIColor whiteColor];
    [self.memberInfoView addSubview:self.nameView];
    
    self.lineView01 = [[UIView alloc] initWithFrame:CGRectMake(15, self.nameView.frame.origin.y+self.nameView.frame.size.height+0, ScreenWidth, 0.5)];
    //    self.lineView01.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView01.backgroundColor = lineColorGray;
    [self.memberInfoView addSubview:self.lineView01];
    
    self.phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView01.frame.origin.y+self.lineView01.frame.size.height+0, ScreenWidth, 40)];
    //    self.phoneView.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.phoneView];
    
    self.lineView02 = [[UIView alloc] initWithFrame:CGRectMake(15, self.phoneView.frame.origin.y+self.phoneView.frame.size.height+0, ScreenWidth, 0.5)];
    self.lineView02.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView02.backgroundColor = lineColorGray;
    [self.memberInfoView addSubview:self.lineView02];
    
    self.remainderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView02.frame.origin.y+self.lineView02.frame.size.height+0, ScreenWidth, 40)];
    //    self.remainderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.remainderView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.remainderView];
    
    self.lineView03 = [[UIView alloc] initWithFrame:CGRectMake(15, self.remainderView.frame.origin.y+self.remainderView.frame.size.height+0, ScreenWidth, 0.5)];
    //    self.lineView03.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineView03.backgroundColor = lineColorGray;
    [self.memberInfoView addSubview:self.lineView03];
    
    self.moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lineView03.frame.origin.y+self.lineView03.frame.size.height+0, ScreenWidth, 40)];
    //    self.moneyView.translatesAutoresizingMaskIntoConstraints = NO;
    self.moneyView.backgroundColor =  [UIColor whiteColor];
    [self.memberInfoView addSubview:self.moneyView];
    
    self.payWayLable = [[UILabel alloc] initWithFrame:CGRectMake(15, self.memberInfoView.frame.origin.y+self.memberInfoView.frame.size.height+20, ScreenWidth, 15)];
    //    self.payWayLable.translatesAutoresizingMaskIntoConstraints = NO;
    self.payWayLable.text = @"支付方式";
    self.payWayLable.font = [UIFont systemFontOfSize:12];
    self.payWayLable.textColor = fontColorLightgray;
    [self.pageScroll addSubview:self.payWayLable];
    
    self.payWayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.payWayLable.frame.origin.y+self.payWayLable.frame.size.height+10, ScreenWidth, 180)];
    self.payWayTableView.delegate = self;
    self.payWayTableView.dataSource = self;
    self.payWayTableView.allowsMultipleSelectionDuringEditing = YES;
    self.payWayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.payWayTableView.backgroundColor = backageColorLightgray;
    [self.pageScroll addSubview:self.payWayTableView];
    
    self.agreeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.payWayTableView.frame.origin.y+self.payWayTableView.frame.size.height+10, ScreenWidth, 30)];
    //    self.agreeView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.agreeView.backgroundColor =  [UIColor whiteColor];
    [self.pageScroll addSubview:self.agreeView];
    
    //控件内部布局
    //姓名
    self.nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.nameView.frame.size.height)];
    self.nameLabe.text = @"真实姓名";
    self.nameLabe.font = [UIFont systemFontOfSize:14];
    self.nameLabe.textColor = fontColorGray;
    [self.nameView addSubview:self.nameLabe];
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.nameView.frame.size.height)];
    self.nameText.delegate = self;
    self.nameText.placeholder = @"持卡人真实姓名";
    self.nameText.font = [UIFont systemFontOfSize:14];
    self.nameText.textColor = fontColorGray;
    self.nameText.returnKeyType=UIReturnKeyNext;
    [self.nameView addSubview:self.nameText];
    
    //手机号
    self.phoneLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.phoneView.frame.size.height)];
    self.phoneLabe.text = @"手机号";
    self.phoneLabe.font = [UIFont systemFontOfSize:14];
    self.phoneLabe.textColor = fontColorGray;
    [self.phoneView addSubview:self.phoneLabe];
    
    self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.phoneView.frame.size.height)];
    self.phoneText.delegate = self;
    self.phoneText.placeholder = @"请输入手机号";
    self.phoneText.font = [UIFont systemFontOfSize:14];
    self.phoneText.textColor = fontColorGray;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.returnKeyType=UIReturnKeyNext;
    [self.phoneView addSubview:self.phoneText];
    
    //会员余额
    self.remainderLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.remainderView.frame.size.height)];
    self.remainderLabe.text = @"会员余额";
    self.remainderLabe.font = [UIFont systemFontOfSize:14];
    self.remainderLabe.textColor = fontColorGray;
    [self.remainderView addSubview:self.remainderLabe];
    
    self.remainderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.remainderView.frame.size.height)];
    
    self.remainderContentLabel.text = @"0";
    
    self.remainderContentLabel.font = [UIFont systemFontOfSize:14];
    self.remainderContentLabel.textColor = fontColorGray;
    [self.remainderView addSubview:self.remainderContentLabel];
    
    //充值金额
    self.moneyLabe = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, self.moneyView.frame.size.height)];
    self.moneyLabe.text = @"充值金额";
    self.moneyLabe.font = [UIFont systemFontOfSize:14];
    self.moneyLabe.textColor = fontColorGray;
    [self.moneyView addSubview:self.moneyLabe];
    
    self.moneyText = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, ScreenWidth-150, self.moneyView.frame.size.height)];
    //     self.moneyText.delegate = self;
    //    self.moneyText.placeholder = @"请输入金额";
    self.moneyText.font = [UIFont systemFontOfSize:14];
    self.moneyText.textColor = fontColorGray;
    //    self.moneyText.keyboardType = UIKeyboardTypeNumberPad;
    //    self.moneyText.returnKeyType=UIReturnKeyDone;
    [self.moneyView addSubview:self.moneyText];
    
    //同意条款
    self.agreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 15, self.agreeView.frame.size.height)];
    self.agreeImageView.image = [UIImage imageNamed:@"ico_member_unselect"];
    self.agreeImageView.contentMode = UIViewContentModeScaleAspectFit;
    //     self.agreeImageView.userInteractionEnabled = YES;
    [self.agreeView addSubview:self.agreeImageView];
    //    UITapGestureRecognizer *agreeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateAgreeState:)];
    //    [self.agreeImageView addGestureRecognizer:agreeTapGesture];
    
    self.agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.agreeView.frame.size.height)];
    self.agreeButton.tag = 198801;
    [self.agreeButton addTarget:self action:@selector(updateAgreeState:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeView addSubview:self.agreeButton];
    
    
    self.agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.agreeImageView.frame.origin.x+self.agreeImageView.frame.size.width+5, 0, 60, self.agreeView.frame.size.height)];
    self.agreeLabel.text = @"阅读并同意";
    self.agreeLabel.font = [UIFont systemFontOfSize:12];
    [self.agreeView addSubview:self.agreeLabel];
    
    self.clauseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.agreeLabel.frame.origin.x+self.agreeLabel.frame.size.width+5, 0, 120, self.agreeView.frame.size.height)];
    [self.clauseButton setTitle:@"《世纪生活会员协议》" forState:UIControlStateNormal];
    [self.clauseButton setTitleColor:backageColorRed forState:UIControlStateNormal];
    self.clauseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    //    self.agreeButton.backgroundColor = TEST_COLOR;
    [self.agreeView addSubview:self.clauseButton];
    
    [self initPayWayData];//加入支付方式数据
    
    //支付回调
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(payAlipaySuccessBack)
     name:@"payAlipaySuccessBack"
     object:nil];
    
    //微信支付完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"wx_pay_notification" object:nil];//监听一个通知
    
    
}

//加入测试数据
-(void)initPayWayData{
    //测试数据
    self.payWayArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *payWayDictionary = nil;
    
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_wechat" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"微信支付" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"推荐安装微信版本5.0以上版本使用" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"2" forKey:@"payWayState"];
    [payWayDictionary setValue:@"wxpay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_alipay" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"支付宝" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"配送人员上门现金支付" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
    [payWayDictionary setValue:@"Alipay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    
    payWayDictionary = [[NSMutableDictionary alloc] init];
    [payWayDictionary setValue:@"icon_order_unionpay" forKey:@"payWayIcon"];
    [payWayDictionary setValue:@"银联支付" forKey:@"payWayTitle"];
    //    [payWayDictionary setValue:@"立即开通，专享优惠" forKey:@"payWayContent"];
    [payWayDictionary setValue:@"1" forKey:@"payWayState"];
    [payWayDictionary setValue:@"unionpay" forKey:@"payID"];
    [self.payWayArray addObject:payWayDictionary];
    
    [self.payWayTableView reloadData];
    [self.payWayTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];//默认选中第一行
    
//    [self loadMemberInfo];//加载会员支付信息
    
}

-(void)updateAgreeState: (UIButton *)myButton{
    NSLog(@"点击了同意按钮!!!");
    
    if (myButton.tag==198801) {
        myButton.tag=198802;
        self.agreeImageView.image = [UIImage imageNamed:@"ico_member_select"];
    }else{
        myButton.tag=198801;
        self.agreeImageView.image = [UIImage imageNamed:@"ico_member_unselect"];
    }
    
}


#pragma marks tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payWayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"MemberWayCell";
    
    MemberWayCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[MemberWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消全部样式
    }
    
    
    [cell setCellInfo:self.payWayArray[indexPath.row]];
    if (indexPath.row==self.payWayArray.count-1) {
        [cell updateShow];//隐藏分割线
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择商品%@!!!!!!!!",indexPath);
    //    self.payWayID = indexPath.row;
    
    for (int i=0; i<self.payWayArray.count;i++) {
        if(![self.payWayArray[i][@"payWayState"] isEqual:@"0"]){
            if (i==indexPath.row) {
                self.payWayArray[i][@"payWayState"]=@"2";
            }else{
                self.payWayArray[i][@"payWayState"]=@"1";
            }
            
        }
    }
    
    
    [self.payWayTableView reloadData];
    
    [self.payWayTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
}


//返回上一页
-(void)toReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark 支付逻辑****************************
-(void)startPay{
    //    if (self.payWayID) {
    
    //测试
        self.nameText.text = @"测试";
        self.phoneText.text = @"15888888888";
 
    if(self.agreeButton.tag == 198802){
        
        if(self.nameText.text!=nil&&![self.nameText.text isEqualToString:@""]){
            if(self.phoneText.text!=nil&&![self.phoneText.text isEqualToString:@""]){
                
                
                self.rechargeMoney = [self.moneyText.text floatValue];
                
                
                NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
                NSString *payWay =  self.payWayArray[payWayID][@"payID"];
                
                NSLog(@"支付方式为dic%@！！！！！！",payWay);
 
                
                    [[Connetion shared]submitNewOrder:self.nameText.text phone:self.phoneText.text payWay:payWay  finish:^(NSDictionary *resultData, NSError *error)
                     {
                
                         if (!error)
                         {
                             NSLog(@"接口返回数据为%@",resultData);
  
                             NSString *code = [resultData objectForKey:@"code"];
                             //    NSString *msg = nil;
                             if ([code integerValue]==200) {
                                 
                                 NSInteger payWayID =  self.payWayTableView.indexPathForSelectedRow.row;
                                 NSString *payWay =  self.payWayArray[payWayID][@"payID"];
                                 
                                 
                                 NSDictionary *dataDictionary = resultData[@"result"][@"data"];
                                 NSArray *orderArray = dataDictionary[@"orders"];
                                 NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
                                 NSLog(@"支付方式为dic%@！！！！！！",payWay);
                                 
                                  if ([payWay isEqual:@"wxpay"]) {
                                     [self payOrderByWX:resultData];
                                 }else  if ([payWay isEqual:@"Alipay"]) {
                                     [self payOrderByAlipay:resultData];
                                 }
                             }
                             
                         }else{
                         NSLog(@"接口返回错误为%@",error);
                         }
                         
                     }];
                
                }else{
                 [SVProgressHUD showErrorWithStatus:@"请填写手机号"];
                
            }
        }else{
             [SVProgressHUD showErrorWithStatus:@"请填写姓名"];
           
        }
    }else{
         [SVProgressHUD showErrorWithStatus:@"请同意协议后支付"];
        
    }
    
}





//跳转到支付宝支付
- (void)payOrderByAlipay:(NSDictionary *)myDictionary{
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString* partner = @"2088311228128442";
    NSString* seller = @"shijishenghuo@qq.com";
    NSString* privateKey =
    @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJxVJUvS3uA59+D6nNF/RF5EoH+WKhTPETBhvIhnwGFgGbIHsFPCdFH7V/TBTRG0tKHe3ZjJfLSG2jDKjtfeFCRc12iRpcXLm/ARdBeZUtrIA0uQImV2/1WlrrY35Pf5coVQqb8B4ucUoOzXEHnesDRt/xhK35Exbws1X6HatDeDAgMBAAECgYBGuP42Xx8UsSTCUp2+6KQ1QTaagYRoBYTxLkXsL4OIicEWGQRb4AxfSiVwREJpUCanU/tLs1sHEDqE+B3G6mCRnasPieL0x26gIbvH0Rn9p/TbiGYcQ6wXc18GqzHwhqKXJTrH61iBuYgcs5OwnUX4hD+FILebzEH4nzG31DMCAQJBAMoMDTVBj/95yJfD5S9K1UfLAJpN2u3GMwEg3FOIQQ5hKV1yaW6Xf6Ojoj1W++N7Wo0ppEdP+xtDlVE9419bOtECQQDGFAzYtXTYH5oj7gHy7TrzJIGxbf2IvI/tcZS6Azo6nihZ2SM7+jHR44p3C2GmvL62Nn6mVbrNYbaJjSrhw7oTAkEAt4fo+4ZZklyCjPFiHupgAH3zRzcPdktCi3TZDnvHdJNnqr3B7bZqOC/ssMFxv3qOj4nS8wBA/cwPN6P7BORu8QJAMopXJMxX/fVCTTyjfqqNShDcjrsz37nNN5atjjDYoLBON26yENGr+JQIdouO5Q5v0upgsmxZd6IhA0Pj1ysrxQJACc4OSncoVBTgpB4Eu+OVoIxqH4rhH7E3q4boJUd5yXkZhzHAQLyMmtpbG4FejaEhOJd5pwtQWWRFmt77MA1eDA==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    
//    [super hideGif];
    NSDictionary *dataDictionary = myDictionary[@"result"][@"data"];
    NSArray *orderArray = dataDictionary[@"orders"];
    NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.tradeNO = orderDictionary[@"order_num"];  // [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = dataDictionary[@"order_name"];  //商品标题
    order.productDescription =
    @"订单支付";  // DesignerData[@"orderName"]; //商品描述
    order.amount = [NSString stringWithFormat:@"%f",self.rechargeMoney];  //商品价格
    order.notifyURL = @"http://www.sjsh8.cn/Notify_message_alipay_mobile.php";  //回调URL
    
    
    order.partner = partner;
    order.seller = seller;
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}



//跳转到微信支付
- (void)payOrderByWX:(NSDictionary *)myDictionary{
    
    NSLog(@"所选支付方式为微信!!!!!!!!");
    
    NSDictionary *dataDictionary = myDictionary[@"result"][@"data"];
    NSArray *orderArray = dataDictionary[@"orders"];
    NSDictionary *orderDictionary = (NSDictionary *)orderArray[0];
    
    
    NSMutableDictionary *weChatPayDictionary = [[NSMutableDictionary alloc]init];
    weChatPayDictionary[@"body"] = dataDictionary[@"order_name"];
    weChatPayDictionary[@"out_trade_no"] = orderDictionary[@"order_num"];
    weChatPayDictionary[@"total_fee"] = [NSString stringWithFormat:@"%.0f",self.rechargeMoney*100];
    
    NSLog(@"参数为%@！！！！！！！！",weChatPayDictionary);
    
 
    //新方法，后台获取预支付订单
    //调用下单接口
    [[Connetion shared]getOrderPreWithWeChat:weChatPayDictionary finish:^(NSDictionary *dict, NSError *error)
     {
         if (!error)
         {
             NSLog(@"接口返回数据为%@",dict);
             
             NSString *prePayId = dict[@"prepayid"];
             NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
             // 获取预支付订单id，调用微信支付sdk
             if (prePayId)
             {
                 NSLog(@"--- PrePayId: %@", prePayId);
                 
                 //调起微信支付
                 PayReq* req             = [[PayReq alloc] init];
                 req.partnerId           = [dict objectForKey:@"partnerid"];
                 req.prepayId            = [dict objectForKey:@"prepayid"];
                 req.nonceStr            = [dict objectForKey:@"noncestr"];
                 req.timeStamp           = stamp.intValue;
                 req.package             = [dict objectForKey:@"package"];
                 req.sign                = [dict objectForKey:@"sign"];
                 [WXApi sendReq:req];
                 //日志输出
                 NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
             }
         }else{
             NSLog(@"接口返回错误为%@",error);
         }
             
         
     }];
    
}

//  支付成功后的回调
- (void)payAlipaySuccessBack {
    NSLog(@"支付成功！！！！！！！");
 
   
    [self toReturn];//返回上一页
}


#pragma mark - 微信支付结果
- (void)getOrderPayResult:(NSNotification *)notification
{
    
//    [super hideGif];
    
    if ([[notification.object objectForKey:@"result"] isEqualToString:@"success"])
    {
        NSLog(@"微信success: 支付成功！！！！！！！");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付成功"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"微信fail: 支付失败！！！！！！");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                        message:@"支付失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    }
    //    [self roadWXPayResultWithCode:[notification.object objectForKey:@"code"]];
    self.WXPayProduct = nil;
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
