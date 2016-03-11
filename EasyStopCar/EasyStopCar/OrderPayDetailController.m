//
//  OrderPayDetailController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/4.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "OrderPayDetailController.h"
#import "PayDetailCell.h"

@interface OrderPayDetailController ()

@property(nonatomic,strong)UILabel *orderNumberLabel;
@property(nonatomic,strong)UILabel *parkNameLabel;

@property(nonatomic,strong)UIImageView *orderDetailBakcage;//顶部背景图片
@property(nonatomic,strong)UIView *orderDetailView;

@property(nonatomic,strong)UIView *userTimeView;//使用时间

@property(nonatomic,strong) UITableView *datailTableView;//列表

@property(nonatomic,strong)UILabel *paySumLabel;
@end

@implementation OrderPayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [super initNavBarItems:@"支付明细"];
    
    self.orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 15)];
    self.orderNumberLabel.text = @"订单号 000000000000000";
    self.orderNumberLabel.font = [UIFont systemFontOfSize:12];
    self.orderNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.orderNumberLabel.textColor = fontColorLightgray;
    [self.view addSubview:self.orderNumberLabel];
    
    self.parkNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.orderNumberLabel.frame.origin.y+self.orderNumberLabel.frame.size.height+10, ScreenWidth, 15)];
    self.parkNameLabel.text = @"暂无";
    self.parkNameLabel.font = [UIFont systemFontOfSize:17];
    self.parkNameLabel.textAlignment = NSTextAlignmentCenter;
    self.parkNameLabel.textColor = fontColorBlack;
    [self.view addSubview:self.parkNameLabel];
    
    
    self.orderDetailBakcage = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 74, ScreenWidth-marginSize*2, 18)];
    
    if (ScreenWidth == 375*2) {
          self.orderDetailBakcage.image = [UIImage imageNamed:@"backage_order_top_iphone6"];
    }else{
    self.orderDetailBakcage.image = [UIImage imageNamed:@"backage_order_top"];
    }
//    self.orderDetailBakcage.contentMode = UIViewContentModeScaleAspectFit;
     [self.view addSubview:self.orderDetailBakcage];
    
    self.orderDetailView = [[UIView alloc]initWithFrame:CGRectMake(25, 74+9, ScreenWidth-25*2, 10+70+60*4+60)];
    self.orderDetailView.backgroundColor = [UIColor whiteColor];
    self.orderDetailView.layer.borderWidth = 0.5;
    self.orderDetailView.layer.borderColor =[lineColorGray CGColor];
    [self.view addSubview:self.orderDetailView];
 
    
    self.datailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.orderDetailView.frame.size.width, 70+60*4)];
    self.datailTableView.delegate = self;
    self.datailTableView.dataSource = self;
    self.datailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.datailTableView.backgroundColor = [UIColor whiteColor];
    [self.datailTableView setTableFooterView:[[UIView alloc]init]];
    [self.orderDetailView addSubview:self.datailTableView];
    
    UIImageView *shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.orderDetailView.frame.size.width, 15)];
    shadowView.image = [UIImage imageNamed:@"backage_order_shadow"];
    [self.orderDetailView addSubview:shadowView];
    
    
    self.paySumLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, self.datailTableView.frame.origin.y+self.datailTableView.frame.size.height, self.orderDetailView.frame.size.width-marginSize, 60)];
    self.paySumLabel.textColor = backageColorRed;
    self.paySumLabel.font = [UIFont boldSystemFontOfSize:17];
    self.paySumLabel.text = @"需支付总金额 ￥0元";
    self.paySumLabel.textAlignment = NSTextAlignmentRight;
    [self.orderDetailView addSubview:self.paySumLabel];
 
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString:@"需支付总金额 ￥0元"];
    [orderStateAttributedString addAttribute:NSForegroundColorAttributeName value:fontColorBlack range:NSMakeRange(0,6)];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, 6)];
    self.paySumLabel.attributedText = orderStateAttributedString;
    
//    CALayer *bottomBorder=[[CALayer alloc]init];
//    bottomBorder.frame=CGRectMake(0, 0, self.orderDetailView.frame.size.width, 0.5);
//    bottomBorder.backgroundColor=lineColorLightgray.CGColor;
//    [self.paySumLabel.layer addSublayer:bottomBorder ];
}


-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"ico_time" forKey:@"image"];
    [myDictionary setValue:@"使用时间" forKey:@"title"];
    [myDictionary setValue:@"" forKey:@"time"];
    [myDictionary setValue:@"0时0分" forKey:@"value"];
    [myDictionary setValue:@"停车入库时间  2016-00-00 00:00\n取车入库时间  2016-00-00 00:00" forKey:@"content"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"ico_search_day" forKey:@"image"];
    [myDictionary setValue:@"日间停车费" forKey:@"title"];
    [myDictionary setValue:@"0:00-24:00" forKey:@"time"];
    [myDictionary setValue:@"0元" forKey:@"value"];
    [myDictionary setValue:@"0元/小时×0分\n" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"ico_search_night" forKey:@"image"];
    [myDictionary setValue:@"夜间停车费" forKey:@"title"];
    [myDictionary setValue:@"0:00-24:00" forKey:@"time"];
    [myDictionary setValue:@"0元" forKey:@"value"];
    [myDictionary setValue:@"0元/小时×0分\n" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"ico_home_cell_flag" forKey:@"image"];
    [myDictionary setValue:@"电费" forKey:@"title"];
    [myDictionary setValue:@"" forKey:@"time"];
    [myDictionary setValue:@"0元" forKey:@"value"];
    [myDictionary setValue:@"0元/度×0度\n" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"ico_home_cell_flag" forKey:@"image"];
    [myDictionary setValue:@"充电服务费" forKey:@"title"];
    [myDictionary setValue:@"" forKey:@"time"];
    [myDictionary setValue:@"0元" forKey:@"value"];
    [myDictionary setValue:@"0元/度×0度\n" forKey:@"content"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 60;
    if (indexPath.row==0) {
        rowHeight = 70;
    }
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"PayDetailCell";
    
    PayDetailCell  *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[PayDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
